function saveTDM2mat(files2save, dir_data, save_dir, split_file, max_length, handles)

for i=1:length(files2save)
    
    file_name = files2save(i).name;
    file_name = fullfile(dir_data,file_name);
    tdms_struct = TDMS_getStruct(file_name);    % reading tdms file
    field_names = fieldnames(tdms_struct) ;     % all records Breakdowns and Log
    
    %Split structure into multiple mat files
    if(split_file)
        %Calculate how many sections to split into:
        num_files = ceil(length(field_names) / max_length);
        
        for j = 1:num_files
            %Pick incides to include in this section
            event_indices = [1 ((j-1) * max_length + 2):min((j * max_length + 1), length(field_names))];
            
            field_names_section = field_names(event_indices);
            
            %Assemble struct section
            tdms_struct_section = struct();
            for k = 1:length(field_names_section)
                tdms_struct_section.(field_names_section{k}) = tdms_struct.(field_names_section{k});
            end
            
            %Save section
            save([save_dir, file_name(end-23:end-5), '_', num2str(j), '.mat'],...
                'tdms_struct_section', 'field_names_section');
            
            handles.log_edit.String = [handles.log_edit.String; ...
                ['File: ', file_name(end-23:end-5), '_', num2str(j), ' is finished']];
            drawnow;
        end
    
    %Save single mat file
    else
        save([save_dir, file_name(end-23:end-5), '.mat'], 'tdms_struct', 'field_names');
        
        handles.log_edit.String = [handles.log_edit.String; ['File: ', file_name(end-23:end-5),' is finished']];
        drawnow;
    end
    
    
    clear file_name;
    clear tdms_struct;
    clear field_names
end