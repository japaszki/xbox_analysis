function [BD_list, bds_found] = construct_bd_list_xb_1(parameters, files, options, gui_handle, ...
    field_names, tdms_struct, tdms_filename)

bds_found = 0;

BD_list = {''};
BD_index = 1;

prev_list = {''};
prev_index = 1;

pulses_since_last_bd = 0;

%Iterate through TDMS structure elements
for i = 2:length(field_names)
    
    split_event_name = strsplit(field_names{i}, '_');
    event_time_string = split_event_name{2};
    event_ms = split_event_name{3};
    event_type = split_event_name{4};
    
    event_timestamp = [event_time_string '.' event_ms];
    
    %Identify type of event
    if(strcmp(event_type, 'B0'))
        try
            BD_list{BD_index}.index = i;
            BD_list{BD_index}.pulse_delta = pulses_since_last_bd; 
            BD_list{BD_index}.timestamp = event_timestamp;
            BD_list{BD_index}.field_name = field_names{i};
            pulses_since_last_bd = 0;
            BD_index = BD_index + 1;
        catch
            add_to_log(['Problem reading ' field_names{i}], files, options, gui_handle);
            add_to_log('Skipping entry.', files, options, gui_handle);
        end
        
        bds_found = bds_found + 1;
    elseif(strcmp(event_type, 'L1') && (parameters.prev_log_type == 1))
        try
            prev_list{prev_index}.index = i;
            prev_list{prev_index}.timestamp = event_timestamp;
            prev_index = prev_index + 1;
        catch
            add_to_log(['Problem reading ' field_names{i}], files, options, gui_handle);
            add_to_log('Skipping entry.', files, options, gui_handle);
        end 
    elseif(strcmp(event_type, 'L2') && (parameters.prev_log_type == 2))
        try
            prev_list{prev_index}.index = i;
            prev_list{prev_index}.timestamp = event_timestamp;
            prev_index = prev_index + 1;
        catch
            add_to_log(['Problem reading ' field_names{i}], files, options, gui_handle);
            add_to_log('Skipping entry.', files, options, gui_handle);
        end
    elseif(strcmp(event_type, 'L0')) %regular log pulse
        try
            pulses_since_last_bd = pulses_since_last_bd + double(tdms_struct.(field_names{i}).Props.Pulse_Delta);
        catch
            add_to_log(['Problem reading ' field_names{i} '. (Counting pulses since last BD.)'], files, options, gui_handle);
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
                
                %Check that the prev event is the pulse just before the BD. Use timestamp since pulse count not available in Xbox 1             
                if((str2double(BD_list{i}.timestamp) - str2double(prev_list{prev_index}.timestamp) <= parameters.max_time_to_prev) &&...
                        (str2double(BD_list{i}.timestamp) - str2double(prev_list{prev_index}.timestamp) >= 0))
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