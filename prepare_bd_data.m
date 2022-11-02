function [metrics, BD_list] = prepare_bd_data(files, parameters, options, metrics, gui_handle, field_names, ...
    tdms_struct, tdms_filename)

%Construct an ordered list of BDs with previous pulses.
if(parameters.xbox1)
    [BD_list, bds_found] = construct_bd_list_xb_1(parameters, files, options, gui_handle, field_names, tdms_struct, tdms_filename);
else
    [BD_list, bds_found] = construct_bd_list_xb_2_3(parameters, files, options, gui_handle, field_names, tdms_struct, tdms_filename);
end

metrics.total_bds = metrics.total_bds + bds_found;

%Determine if each BD occured in the structure or not:
if(~isequal(BD_list, {''})) %Skip if no BDs found in this file
    for i = 1:length(BD_list)
        %Only consider BDs with prev data available
        if(isfield(BD_list{i}, 'prev_index'))
            %Ignore BD flags from PXI, apply software filter to check if real BD
            bd_dc_up = structure_bd_filter(parameters, files, options, gui_handle, field_names, tdms_struct, BD_list, i, 'Up');
            bd_dc_down = structure_bd_filter(parameters, files, options, gui_handle, field_names, tdms_struct, BD_list, i, 'Down');
            
            if(bd_dc_up || bd_dc_down)
                BD_list{i}.structure_bd = true;
                metrics.structure_bds = metrics.structure_bds + 1;
            else
                BD_list{i}.structure_bd = false;
            end
        else
            %Reject as non structure BD if prev pulse not found
            add_to_log(['No previous pulse in ' field_names{BD_list{i}.index} '.'], files, options, gui_handle);
            add_to_log('Treating as non-structure BD.', files, options, gui_handle);
            
            BD_list{i}.structure_bd = false;
        end
    end
    
    %Iterate through BD_list and pass on pulse delta to next structure BD
    %
    % potential bug in case when there are no BDs in a given day: pulse
    % delta from those days does not get counted
    
    if(parameters.xbox1)
        pulses_since_struct_bd = 0;
        
        for i = 1:length(BD_list)
            try
                pulses_since_struct_bd = pulses_since_struct_bd + BD_list{i}.pulse_delta;
            catch
                add_to_log(['Could not read Pulse Delta in ' field_names{BD_list{i}.index} '.'], files, options, gui_handle);
                add_to_log('Ignoring.', files, options, gui_handle);
            end
            
            if(BD_list{i}.structure_bd)
                BD_list{i}.pulse_delta = pulses_since_struct_bd;
                pulses_since_struct_bd = 0;
            end
        end
    end
end
end