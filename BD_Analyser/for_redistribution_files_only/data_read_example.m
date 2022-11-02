clear all
close all

files.matfile_dir = 'G:\Workspaces\x\Xbox3_TD24SiC_2_L4\matfiles\';
files.matfile_prefix = 'EventDataB_';
files.matfile_suffix = '.mat';

files.start_year = 2018;
files.start_month = 5; %3
files.start_day = 26; %26

files.end_year = 2018;
files.end_month = 6;
files.end_day = 18;

pulse_sample_period = 50; %Sample every N pulses

start_date = datenum(files.start_year, files.start_month, files.start_day);
end_date = datenum(files.end_year, files.end_month, files.end_day);


for curr_date = start_date:end_date
    curr_datetime = datetime(curr_date,'ConvertFrom','datenum');
    curr_year = curr_datetime.Year;
    curr_month = curr_datetime.Month;
    curr_day = curr_datetime.Day;
    
    %Prepare next TDMS file.
    tdms_filename = [files.matfile_dir, files.matfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
        num2str(curr_day, '%02d'), files.matfile_suffix];
    
    %Load file if exists, otherwise skip
    if(exist(tdms_filename, 'file') ~= 2)
        disp(['File '  tdms_filename ' is missing.']);
    else
        load(tdms_filename);
        field_names = fieldnames(tdms_struct);
        
        for i = 2:pulse_sample_period:length(field_names)
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
            
            if(strcmp(event_type, 'Log'))
                pulse_count = double(tdms_struct.(field_names{i}).Props.Pulse_Count);
                psi_amp_raw = double(tdms_struct.(field_names{i}).PSI_amp.data);
                psi_amp_dt = double(tdms_struct.(field_names{i}).PSI_amp.Props.wf_increment);
                psi_amp_coeffs(1) = double(tdms_struct.(field_names{i}).PSI_amp.Props.Scale_Coeff_c0);
                psi_amp_coeffs(2) = double(tdms_struct.(field_names{i}).PSI_amp.Props.Scale_Coeff_c1);
                psi_amp_coeffs(3) = double(tdms_struct.(field_names{i}).PSI_amp.Props.Scale_Coeff_c2);
                
                psi_amp = psi_amp_raw.^2 * psi_amp_coeffs(3) + psi_amp_raw * psi_amp_coeffs(2) + psi_amp_coeffs(1);
            end
        end
        
        disp(['Finished file '  tdms_filename]);
    end
end