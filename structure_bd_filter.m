function structure_bd = structure_bd_filter(parameters, files, options, gui_handle, field_names, tdms_struct, BD_list, BD_index, channel)

%%To-do: implement DC offset removal

good_data = true;

if(strcmp(channel, 'Up'))
    try
        bd_dc = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.DC_Up_field).data);
        prev_dc = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.DC_Up_field).data);
    catch
        good_data = false;
        
        add_to_log(['Problem reading DC Up channel in ' field_names{BD_list{BD_index}.index}]', files, options, gui_handle);
        add_to_log('Setting DC Up flag to false.', files, options, gui_handle);
    end
    threshold = parameters.dc_up_diff_threshold;
elseif(strcmp(channel, 'Down'))
    try
        bd_dc = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.DC_Down_field).data);
        prev_dc = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.DC_Down_field).data);
    catch
        good_data = false;
        
        add_to_log(['Problem reading DC Down channel in ' field_names{BD_list{BD_index}.index}]', files, options, gui_handle);
        add_to_log('Setting DC Down flag to false.', files, options, gui_handle);
    end
    threshold = parameters.dc_down_diff_threshold;
else
    error('Channel needs to be ''Up'' or ''Down''');
end

if(good_data)
    %Reject glitched pulses
    if(~(length(bd_dc) == length(prev_dc)))
        add_to_log(['Previous and BD DC ' channel ' have different number of samples in ' ...
            field_names{BD_list{BD_index}.index}], files, options, gui_handle);
        add_to_log(['Ignoring DC ' channel ' signal.'], files, options, gui_handle);
        
        structure_bd = false;
    else
        %Assuming breakdown current is always negative
        max_dc_diff = abs(min(medfilt1(bd_dc - prev_dc, 10)));
        if(max_dc_diff > threshold)
            structure_bd = true;
        else
            structure_bd = false;
        end
    end
else
    structure_bd = false;
end

end