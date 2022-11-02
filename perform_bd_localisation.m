function [metrics, BD_list] = perform_bd_localisation(files, parameters, options, metrics, gui_handle,...
    field_names, tdms_struct, BD_list, BD_index)

%Only structure BDs with prev data
if(isfield(BD_list{BD_index}, 'prev_index') && BD_list{BD_index}.structure_bd)
    %Load RF signals of prev and BD pulses
    prev_psi = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.PSI_amp_field).data);
    bd_psi = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PSI_amp_field).data);
    
    prev_psr = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.PSR_amp_field).data);
    bd_psr = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PSR_amp_field).data);
    
    prev_pei = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.PEI_amp_field).data);
    bd_pei = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PEI_amp_field).data);
    
    if(~parameters.xbox1)
        %No phase data in Xbox 1:
        bd_psi_ph = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PSI_ph_field).data);
        bd_psr_ph = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PSR_ph_field).data);
    else
        %Xbox 1 uses log detectors which can give negative values - apply offset to make the
        %signal positive only:
        psi_offset = min(min(prev_psi), min(bd_psi));
        prev_psi = prev_psi - psi_offset; %(use the same offset for both prev and bd pulses)
        bd_psi = bd_psi - psi_offset;
        
        psr_offset = min(min(prev_psr), min(bd_psr));
        prev_psr = prev_psr - psr_offset;
        bd_psr = bd_psr - psr_offset;
        
        pei_offset = min(min(prev_pei), min(bd_pei));
        prev_pei = prev_pei - pei_offset;
        bd_pei = bd_pei - pei_offset;
    end
    
    %Reject glitched pulses which have inconsistent number of
    %samples.
    if(~(length(prev_psi) == length(bd_psi)) || ~(length(prev_psr) == length(bd_psr)) || ...
            ~(length(prev_pei) == length(bd_pei)))
        add_to_log(['Previous and BD pulse have different number of samples in ' ...
            field_names{BD_list{BD_index}.index}], files, options, gui_handle);
        add_to_log('Skipping pulse.', files, options, gui_handle);
        
    else
        %Use PSI signal to align pulses in time.
        psi_threshold = parameters.pulse_start_threshold * max(prev_psi); %treat prev pulse as nominal
        prev_psi_index = find(prev_psi >= psi_threshold, 1);
        bd_psi_index = find(bd_psi >= psi_threshold, 1);
        
        if(isempty(bd_psi_index))
            add_to_log(['PSI breakdown waveform in ' field_names{BD_list{BD_index}.index} ...
                ' has low peak value compared to previous pulse. Possibly pulse compressor BD.'],...
                files, options, gui_handle);
            add_to_log('Skipping pulse.', files, options, gui_handle);
        else
            sample_shift = bd_psi_index - prev_psi_index;
            if(abs(sample_shift) > parameters.max_sample_shift)
                sample_shift = max(-parameters.max_sample_shift, min(parameters.max_sample_shift, sample_shift));
                add_to_log(['Large sample shift between previous and BD pulses in '...
                    field_names{BD_list{BD_index}.index}], files, options, gui_handle);
                add_to_log(['Sample shift clamped to ' num2str(sample_shift)], files, options, gui_handle);
            end
            
            %Cut off pre-pulse to avoid confusing the edge detection method with the edge of the pre-pulse.
            %Also avoids filtering unneccesary data. Rising edge of pre-pulse MUST be cut away!
            
            if(bd_psi_index - parameters.samples_before_trig < 1)
                add_to_log(['Check samples_before_trig: window starts before pulse for '...
                    field_names{BD_list{BD_index}.index}], files, options, gui_handle);
            end
            
            window_start_index = max(1, bd_psi_index - parameters.samples_before_trig);
            
            %Find edges of signals for breakdown position analysis. Note the use of a different
            %threshold for PSI vs PER and PSR.
            [psi_edges, psi_signals] = process_rf_signal(prev_psi, ...
                bd_psi, sample_shift, window_start_index, parameters.filter_span, ...
                parameters.diff_threshold, parameters.fractional_psi_threshold);
            
            [pei_edges, pei_signals] = process_rf_signal(prev_pei, ...
                bd_pei, sample_shift, window_start_index, parameters.filter_span, ...
                parameters.diff_threshold, parameters.fractional_edge_threshold);
            
            [psr_edges, psr_signals] = process_rf_signal(prev_psr, ...
                bd_psr, sample_shift, window_start_index, parameters.filter_span, ...
                parameters.diff_threshold, parameters.fractional_edge_threshold);
            
            PSR_dt = tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PSR_amp_field).Props.wf_increment;
            PEI_dt = tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.PEI_amp_field).Props.wf_increment;
            
            %Calculate position of BD in units of time.
            bd_edge_time = 0.5 * (PSR_dt * (psr_edges.dev - psr_edges.prev) - ...
                PEI_dt * (pei_edges.dev - pei_edges.prev));
            
            %Time at which BD occurs (not position) by reflected pulse length
            BD_list{BD_index}.bd_refl_time = PSR_dt * (psr_edges.dev - psr_edges.prev);
            
            %Time at which BD occurs (not position) by transmitted pulse length
            BD_list{BD_index}.bd_trans_time = PSR_dt * (pei_edges.dev - pei_edges.prev);
            
            %Position of BD using edge method:
            BD_list{BD_index}.bd_edge_time = bd_edge_time;
            
            %Get phase of BD:
            if(~parameters.xbox1)
                bd_psi_ph_shifted = parameters.phase_scaling_factor * circshift(bd_psi_ph, sample_shift);
                bd_psr_ph_shifted = parameters.phase_scaling_factor * circshift(bd_psr_ph, sample_shift);
                
                phase_diff = smooth(bd_psr_ph_shifted(window_start_index:end) - ...
                    bd_psi_ph_shifted(window_start_index:end), parameters.filter_span);
                
                %Define samples to average over
                if(strcmp(parameters.phase_sampling_edge, 'PSI'))
                    phase_meas_indices = min((round(psi_edges.dev) + (0:parameters.phase_sampling_window-1)), length(phase_diff));
                elseif(strcmp(parameters.phase_sampling_edge, 'PSR'))
                    phase_meas_indices = min((round(psr_edges.dev) + (0:parameters.phase_sampling_window-1)), length(phase_diff));
                else
                    error('Unknown value of Phase Sampling Edge!');
                end
                
                bd_phase = mean(mod(phase_diff(phase_meas_indices), 2*pi));
                
                BD_list{BD_index}.bd_phase = bd_phase;
            else
                phase_diff = 0;
            end
            
            %If BD position is within the expected limits, increment the appropriate counter
            if((bd_edge_time > min(parameters.structure_time_limts)) && ...
                    (bd_edge_time < max(parameters.structure_time_limts)))
                metrics.correct_pos_bds = metrics.correct_pos_bds + 1;
            else
                metrics.incorrect_pos_bds = metrics.incorrect_pos_bds + 1;
            end
            
            if(options.plot_signals)
                generate_debug_plots(parameters, field_names, tdms_struct, BD_list, BD_index, ...
                    psi_edges, psi_signals, pei_edges, pei_signals, psr_edges, psr_signals, ...
                    phase_diff);
            end
        end
    end
end
end