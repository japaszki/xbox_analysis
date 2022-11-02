function add_to_log(string, files, options, gui_handle)
%add_to_log Adds string to log
%Should handle both log file, GUI window, and command window output if
%necessary. Putting in separate function to allow easier modification
%later.

%Standard MATLAB console output.
if(options.output_console)
    disp(string);
end

%Write to log file.

%Add to GUI output.
max_log_length = 200;

if(options.output_gui)
    gui_handle.log_edit.String = [gui_handle.log_edit.String; string];
    
    %limit length of data in GUI to avoid slowdown
    if(length(gui_handle.log_edit.String) > max_log_length)
        gui_handle.log_edit.String = gui_handle.log_edit.String((end - max_log_length + 1):end);
    end
    
    %select final entry to automatically scroll to the bottom
    gui_handle.log_edit.Value = length(gui_handle.log_edit.String);
    drawnow;
end

end