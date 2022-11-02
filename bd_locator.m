function bd_locator(files, parameters, options, gui_handle)

%Convert dates into datenums for simpler indexing
start_date = datenum(files.start_year, files.start_month, files.start_day);
end_date = datenum(files.end_year, files.end_month, files.end_day);

%Extract data from TDMS and put into arrays
for curr_date = start_date:end_date
    curr_datetime = datetime(curr_date, 'ConvertFrom', 'datenum');
    curr_year = curr_datetime.Year;
    curr_month = curr_datetime.Month;
    curr_day = curr_datetime.Day;
    
    %Data metrics:
    metrics.total_bds = 0;
    metrics.structure_bds = 0;
    metrics.correct_pos_bds = 0; %breakdown position between -5 and 70 ns (or user-specified limits)
    metrics.incorrect_pos_bds = 0; %breakdown position outside bounds
    
    %Prepare next TDMS file.
    tdms_filename = [files.matfile_dir, files.matfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
        num2str(curr_day, '%02d'), files.matfile_suffix];
    
    %Load file if exists, otherwise skip
    if(exist(tdms_filename, 'file') ~= 2)
        add_to_log(['File '  tdms_filename ' is missing.'], files, options, gui_handle);
    else
        load(tdms_filename);
        field_names = fieldnames(tdms_struct);
        [metrics, BD_list] = prepare_bd_data(files, parameters, options, metrics, gui_handle, field_names, tdms_struct, tdms_filename);
        
        %Perform BD positioning
        if(options.perform_analysis)
            if(~isequal(BD_list, {''})) %Skip if no valid BDs found in this file
                for i = 1:length(BD_list)
                    [metrics, BD_list] = perform_bd_localisation(files, parameters, options, metrics, gui_handle, ...
                        field_names, tdms_struct, BD_list, i);
                end
            end
        end
        
        %Write processed data for each day to file.
        if(options.write_output)
            field_name_c = {'TDMS Field Name'};
            if(parameters.xbox1)
                pulse_count_c = {'Pulse Delta'};
            else
                pulse_count_c = {'Pulse Count'};
            end
            timestamp_c = {'Timestamp'};
            bd_location_c = {'Edge Method Location (s)'};
            bd_phase_c = {'REF-INC Phase (rad)'};
            bd_refl_time_c = {'BD Time (refl) (s)'};
            bd_trans_time_c = {'BD Time (trans) (s)'};
            k = 2;
            
            for i = 1:length(BD_list)
                if(isfield(BD_list{i}, 'bd_edge_time'))
                    field_name_c{k} = BD_list{i}.field_name;
                    if(parameters.xbox1)
                        pulse_count_c{k} = num2str(BD_list{i}.pulse_delta);
                        bd_phase_c{k} = 0; %no phase info in xbox1
                    else
                        pulse_count_c{k} = num2str(BD_list{i}.pulse_count);
                        bd_phase_c{k} = num2str(BD_list{i}.bd_phase);
                    end
                    timestamp_c{k} = num2str(BD_list{i}.timestamp);
                    bd_location_c{k} = num2str(BD_list{i}.bd_edge_time);
                    bd_refl_time_c{k} = BD_list{i}.bd_refl_time;
                    bd_trans_time_c{k} = BD_list{i}.bd_trans_time;
                    
                    k = k + 1;
                end
            end
            
            output_table = table(field_name_c', pulse_count_c', timestamp_c', bd_location_c',...
                bd_phase_c', bd_refl_time_c', bd_trans_time_c');
            output_filename = [files.bdfile_dir, files.bdfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
                num2str(curr_day, '%02d'), files.bdfile_suffix];
            writetable(output_table, output_filename, 'WriteVariableNames', false, 'Delimiter', ',');
            
            %Write metadata for each day to file
            total_bds_c = {'Total BDs saved'; num2str(metrics.total_bds)};
            structure_bds_c = {'Structure BDs identified'; num2str(metrics.structure_bds)};
            correct_pos_bds_c = {'BDs within structure limits'; num2str(metrics.correct_pos_bds) };
            incorrect_pos_bds_c = {'BDs outside structure limits'; num2str(metrics.incorrect_pos_bds)};
            
            output_table = table(total_bds_c, structure_bds_c, correct_pos_bds_c, incorrect_pos_bds_c);
            output_filename = [files.metafile_dir, files.metafile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
                num2str(curr_day, '%02d'), files.metafile_suffix];
            writetable(output_table, output_filename, 'WriteVariableNames', false, 'Delimiter', ',');
        end
        add_to_log(['Finished file '  tdms_filename], files, options, gui_handle);
    end
end
add_to_log('Finished.', files, options, gui_handle);
end