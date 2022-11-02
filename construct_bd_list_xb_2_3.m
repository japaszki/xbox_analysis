function [BD_list, bds_found] = construct_bd_list_xb_2_3(parameters, files, options, gui_handle, field_names, ...
    tdms_struct, tdms_filename)
%Construct a cell array containing the index of every breakdown pulse and relevant data.
%In Xbox 2 and 3, the entries of tdms_struct are seperated into breakdowns and log pulses, not in chronological 
%order. Hence, the previous pulse for each breakdown must be found and assigned to it.

bds_found = 0;

BD_list = {''};
BD_index = 1;

prev_list = {''};
prev_index = 1;

%Iterate through TDMS structure elements
for i = 2:length(field_names)
    split_event_name = strsplit(field_names{i}, '_');
    event_type = split_event_name{1};
    event_year = split_event_name{2};
    event_month = split_event_name{3};
    event_day = split_event_name{4};
    event_hour = split_event_name{5};
    event_min = split_event_name{6};
    event_sec = split_event_name{7};
    event_ms = split_event_name{8};
    
    event_timestamp = [event_year event_month event_day ...
        event_hour event_min event_sec '.' event_ms];
    
    %Identify type of event
    if(strcmp(event_type, 'Breakdown'))
        try
            BD_list{BD_index}.index = i;
            BD_list{BD_index}.pulse_count = double(tdms_struct.(field_names{i}).Props.Pulse_Count);
            BD_list{BD_index}.timestamp = event_timestamp;
            BD_list{BD_index}.field_name = field_names{i};
            BD_index = BD_index + 1;
        catch
            add_to_log(['Problem reading ' field_names{i}], files, options, gui_handle);
            add_to_log('Skipping entry.', files, options, gui_handle);
        end
        
        bds_found = bds_found + 1;
    elseif(strcmp(event_type, 'Log'))
        %Only save log pulse if just before BD
        try
            if(tdms_struct.(field_names{i}).Props.Log_Type == parameters.prev_log_type)
                prev_list{prev_index}.index = i;
                prev_list{prev_index}.pulse_count = double(tdms_struct.(field_names{i}).Props.Pulse_Count);
                prev_index = prev_index + 1;
            end
        catch
            add_to_log(['Problem reading ' field_names{i}], files, options, gui_handle);
            add_to_log('Skipping entry.', files, options, gui_handle);
        end
    end
end

add_to_log(['Found ' num2str(BD_index - 1) ' BDs and ' num2str(prev_index - 1) ...
    ' previous events in ' tdms_filename], files, options, gui_handle);

if(BD_index == 1)
    add_to_log(['No BDs found in ' tdms_filename], files, options, gui_handle);
else
    if(prev_index == 1)
        add_to_log(['No previous events found in ' tdms_filename], files, options, gui_handle);
    else
        %Find previous which corresponds to each BD
        %If previous and BD lists are sorted in time, each element of
        %prev_list will only be read once.
        prev_index = 0;
        
        for i = 1:length(BD_list)
            prev_found = false;
            
            %Check each entry of prev_list once.
            for j = 1:length(prev_list)
                prev_index = prev_index + 1;
                
                %Wrap prev_index if exceeds size of prev_list
                if(prev_index > length(prev_list))
                    prev_index = prev_index - length(prev_list);
                end
                
                %Check that the prev event is the pulse just before the BD
                if((BD_list{i}.pulse_count - prev_list{prev_index}.pulse_count <= parameters.max_pulses_to_prev) &&...
                        (BD_list{i}.pulse_count - prev_list{prev_index}.pulse_count >= 0))
                    BD_list{i}.prev_index = prev_list{prev_index}.index;
                    
                    %Break out of for loop if prev event found.
                    prev_found = true;
                    break;
                end
            end
            
            if(~prev_found)
                add_to_log(['Previous event not found for ' field_names{BD_list{i}.index}], files, options, gui_handle);
            end
        end
    end
end
end