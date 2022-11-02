clear all
close all

% files.matfile_dir = 'G:\Workspaces\x\Xbox2_T24PSI_1\matfiles\';
% files.matfile_prefix = 'EventData_';
% files.matfile_suffix = '.mat';
% 
% files.fldfile_dir = '.\XBox2_PSI1\';
% files.fldfile_prefix = 'field_';
% files.fldfile_suffix = '.txt';
% 
% files.start_year = 2017;
% files.start_month = 10;
% files.start_day = 5;
% 
% files.end_year = 2018;
% files.end_month = 3;
% files.end_day = 19;

% files.matfile_dir = 'G:\Workspaces\x\Xbox2_T24PSI_2\matfiles\';
% files.matfile_prefix = 'EventData_';
% files.matfile_suffix = '.mat';
% 
% files.fldfile_dir = '.\XBox2_PSI2\';
% files.fldfile_prefix = 'field_';
% files.fldfile_suffix = '.txt';
% 
% files.start_year = 2018;
% files.start_month = 3;
% files.start_day = 26;
% 
% files.end_year = 2018;
% files.end_month = 5;
% files.end_day = 13;


files.matfile_dir = 'G:\Workspaces\x\Xbox2_TD26CC_3\mat_files\';
files.matfile_prefix = 'EventData_';
files.matfile_suffix = '.mat';

files.fldfile_dir = '.\XBox2_TD26CC\';
files.fldfile_prefix = 'field_';
files.fldfile_suffix = '.txt';

files.start_year = 2017;
files.start_month = 2;
files.start_day = 1;

files.end_year = 2017;
files.end_month = 9;
files.end_day = 31;



flat_top_threshold = 0.95;
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
        pulse_count_c = {'Pulse Count'};
        timestamp_c = {'Timestamp'};
        peak_power_c = {'Peak Power (W)'};
        flat_top_power_c = {'Flat Top Power (W)'};
        pulse_length_c = {'Pulse Length (s)'};
        k = 2;
        
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
                try
                    pulse_count = double(tdms_struct.(field_names{i}).Props.Pulse_Count);
                    psi_amp_raw = tdms_struct.(field_names{i}).PSI_Amplitude.data;
                    psi_amp_dt = tdms_struct.(field_names{i}).PSI_Amplitude.Props.wf_increment;
                    psi_amp_coeffs(1) = tdms_struct.(field_names{i}).PSI_Amplitude.Props.Scale_Coeff_c0;
                    psi_amp_coeffs(2) = tdms_struct.(field_names{i}).PSI_Amplitude.Props.Scale_Coeff_c1;
                    psi_amp_coeffs(3) = tdms_struct.(field_names{i}).PSI_Amplitude.Props.Scale_Coeff_c2;
                    
                    psi_amp = psi_amp_raw.^2 * psi_amp_coeffs(3) + psi_amp_raw * psi_amp_coeffs(2) + psi_amp_coeffs(1);
                    psi_peak = max(psi_amp);
                    flat_top_level = psi_peak * flat_top_threshold;
                    rising_edge = find(psi_amp >= flat_top_level, 1, 'first');
                    falling_edge = find(psi_amp >= flat_top_level, 1, 'last');
                    if(~isempty(rising_edge) && ~isempty(falling_edge))
                        pulse_length = psi_amp_dt * (falling_edge - rising_edge);
                        flat_top_power = mean(psi_amp(rising_edge:falling_edge));
                    else
                        pulse_length = 0;
                        flat_top_power = 0;
                    end                   
                    
                    pulse_count_c{k} = num2str(pulse_count);
                    timestamp_c{k} = event_timestamp;
                    peak_power_c{k} = num2str(psi_peak);
                    flat_top_power_c{k} = num2str(flat_top_power);
                    pulse_length_c{k} = num2str(pulse_length);
                    k = k + 1;
                catch
                    disp(['Problem reading ' field_names{i}]);
                    disp('Skipping entry.');
                end
            end
        end
        
        %Write processed data for each day to file.
        output_table = table(pulse_count_c', timestamp_c', peak_power_c', flat_top_power_c', pulse_length_c');
        output_filename = [files.fldfile_dir, files.fldfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
            num2str(curr_day, '%02d'), files.fldfile_suffix];
        writetable(output_table, output_filename, 'WriteVariableNames', false, 'Delimiter', ',');
        
        disp(['Finished file '  tdms_filename]);
    end
end