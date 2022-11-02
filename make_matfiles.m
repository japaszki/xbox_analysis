tdms_suffix = '.tdms';
matfile_suffix = '.mat';

tdms_prefix = handles.file_prefix_edit.String;
tdms_dir = handles.dir_tdms_edit.String;
local_tdms_dir = handles.dir_data_edit.String;
matfile_dir  = handles.save_dir_edit.String;

start_day = str2num(handles.startday_edit.String);
start_month = str2num(handles.startmonth_edit.String);
start_year = str2num(handles.startyear_edit.String);

end_day = str2num(handles.endday_edit.String);
end_month = str2num(handles.endmonth_edit.String);
end_year = str2num(handles.endyear_edit.String);

split_file = handles.split_checkbox.Value; %split across multiple mat files ?
max_length = str2num(handles.max_length_edit.String); %maximum number of entries per output file

start_date = datenum(start_year, start_month, start_day);
end_date = datenum(end_year, end_month, end_day);

%Check if local matfile dir exists
if(exist(local_tdms_dir, 'dir') ~= 7)
    handles.log_edit.String = [handles.log_edit.String; ...
        'Directory '  local_tdms_dir ' does not exist.'];
    handles.log_edit.Value = length(handles.log_edit.String);
    drawnow;
else
    for curr_date = start_date:end_date
        curr_datetime = datetime(curr_date,'ConvertFrom','datenum');
        curr_year = curr_datetime.Year;
        curr_month = curr_datetime.Month;
        curr_day = curr_datetime.Day;
        
        tdms_filename = [tdms_dir, tdms_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
            num2str(curr_day, '%02d'), tdms_suffix];
        
        local_tdms_filename = [local_tdms_dir, tdms_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
            num2str(curr_day, '%02d'), tdms_suffix];
        
        %Check if file exists
        if(exist(tdms_filename, 'file') ~= 2)
            handles.log_edit.String = [handles.log_edit.String; ...
                'File '  tdms_filename ' is missing.'];
            drawnow;
        else
            
            %Copy file to local directory
            copyfile(tdms_filename, local_tdms_dir);
            handles.log_edit.String = [handles.log_edit.String; 'Copied ', tdms_filename, ' to ', local_tdms_dir];
            handles.log_edit.String = [handles.log_edit.String; 'Beginning conversion of ', local_tdms_filename];
            handles.log_edit.Value = length(handles.log_edit.String);
            drawnow;
            
            %Perform conversion
            tdms_struct = TDMS_getStruct(local_tdms_filename);
            field_names = fieldnames(tdms_struct);
            
            %Save matfile
            if(split_file)
                %Split structure into multiple mat files
                
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
                    matfile_filename = [matfile_dir, tdms_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
                        num2str(curr_day, '%02d'), '_' num2str(j), matfile_suffix];
                    
                    save(matfile_filename, 'tdms_struct_section', 'field_names_section');
                    
                    handles.log_edit.String = [handles.log_edit.String; 'Finished ', matfile_filename];
                    handles.log_edit.Value = length(handles.log_edit.String);
                    drawnow;
                end
            else
                %Save entire TDMS struct as single mat file:
                matfile_filename = [matfile_dir, tdms_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
                    num2str(curr_day, '%02d'), matfile_suffix];
                
                save(matfile_filename, 'tdms_struct', 'field_names');
                
                handles.log_edit.String = [handles.log_edit.String; 'Finished ', matfile_filename];
                handles.log_edit.Value = length(handles.log_edit.String);
                drawnow;
            end
            
            %Delete local copy of TDMS file:
            try
                handles.log_edit.String = [handles.log_edit.String; 'Removing local copy ' local_tdms_filename];
                handles.log_edit.Value = length(handles.log_edit.String);
                drawnow;
                delete(local_tdms_filename);
            catch
                handles.log_edit.String = [handles.log_edit.String; 'Problem deleting file ' local_tdms_filename];
                handles.log_edit.String = [handles.log_edit.String; 'Check permissions or delete manually.'];
                handles.log_edit.Value = length(handles.log_edit.String);
                drawnow;
            end
            
        end
    end
end

handles.log_edit.String = [handles.log_edit.String; strcat('Finished.')];
handles.log_edit.Value = length(handles.log_edit.String);
drawnow;