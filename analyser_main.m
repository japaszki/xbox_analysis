clear all
close all


% % Define files to read and write
settings = 'XBox3_SiC2_L4';

if(strcmp(settings, 'Xbox1_TD26CC'))
    files.matfile_dir = 'G:\Workspaces\x\Xbox1_TD26CC_2\MAT_files\';
    files.matfile_prefix = 'Prod_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox1_TD26CC\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.start_year = 2017;
    files.start_month = 3;
    files.start_day = 7;
    
    files.end_year = 2018;
    files.end_month = 5;
    files.end_day = 15;
    
    %Parameters related to signal processing
    parameters.xbox1 = true;
    parameters.pulse_start_threshold = 0.95;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 100;
    parameters.filter_span = 5;
    parameters.diff_threshold = 0.4;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    parameters.dc_up_diff_threshold = 0.01; %Apply software thresholds to check that BD flags got assigned correctly.
    parameters.dc_down_diff_threshold = 0.01; %Should be the same as hardware thresholds unless
    %     parameters.phase_scaling_factor = pi; %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    %     parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'INC';
    parameters.PSR_amp_field = 'REF';
    parameters.PEI_amp_field = 'TRA';
    parameters.DC_Down_field = 'BPM1';
    parameters.DC_Up_field = 'BPM2';
    parameters.prev_log_type = 1;
    parameters.max_time_to_prev = 1; %How many seconds the prev and BD pulse can differ by to be attributed to the same event
    
elseif(strcmp(settings, 'Xbox2_TD26CC'))
    files.matfile_dir = 'G:\Workspaces\x\Xbox2_TD26CC_3\mat_files\';
    files.matfile_prefix = 'EventData_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox2_TD26CC\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.start_year = 2017;
    files.start_month = 2;
    files.start_day = 1;
    
    files.end_year = 2017;
    files.end_month = 9;
    files.end_day = 31;
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 15;
    parameters.diff_threshold = 0.1;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    parameters.dc_up_diff_threshold = 0.1; %Apply software thresholds to check that BD flags got assigned correctly.
    parameters.dc_down_diff_threshold = 0.18; %Should be the same as hardware thresholds unless
    parameters.phase_scaling_factor = pi; %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_Amplitude';
    parameters.PSR_amp_field = 'PSR_Amplitude';
    parameters.PEI_amp_field = 'PEI_Amplitude';
    parameters.PSI_ph_field = 'PSI_Phase';
    parameters.PSR_ph_field = 'PSR_Phase';
    parameters.DC_Down_field = 'DC_Down';
    parameters.DC_Up_field = 'DC_Up';
    parameters.prev_log_type = 2; %What value of Log_Type a pulse just before BD has
    parameters.max_pulses_to_prev = 1; %How many pulses the prev and BD pulse can differ by to be attributed to the same event
    
elseif(strcmp(settings, 'XBox2_PSI1'))
    
    files.matfile_dir = 'G:\Workspaces\x\Xbox2_T24PSI_1\matfiles\';
    files.matfile_prefix = 'EventData_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox2_PSI1\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.metafile_dir = '.\XBox2_PSI1\';
    files.metafile_prefix = 'metadata_';
    files.metafile_suffix = '.txt';
    
    files.start_year = 2017;
    files.start_month = 10;
    files.start_day = 27;
    
    files.end_year = 2018;
    files.end_month = 3;
    files.end_day = 19;
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 15;
    parameters.diff_threshold = 0.1;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    parameters.dc_up_diff_threshold = 0.13; %Difference in DC pulse between BD and previous
    parameters.dc_down_diff_threshold = 0.05;
    parameters.phase_scaling_factor = pi; %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 30;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_Amplitude';
    parameters.PSR_amp_field = 'PSR_Amplitude';    
    parameters.PEI_amp_field = 'PEI_Amplitude';
    parameters.PSI_ph_field = 'PSI_Phase';
    parameters.PSR_ph_field = 'PSR_Phase';
    parameters.DC_Down_field = 'DC_Down';
    parameters.DC_Up_field = 'DC_Up';
    parameters.prev_log_type = 2; %What value of Log_Type a pulse just before BD has
    parameters.max_pulses_to_prev = 1; %How many pulses the prev and BD pulse can differ by to be attributed to the same event
    
elseif(strcmp(settings, 'XBox2_PSI2'))
    
    files.matfile_dir = 'G:\Workspaces\x\Xbox2_T24PSI_2\matfiles\';
    files.matfile_prefix = 'EventData_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox2_PSI2\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.metafile_dir = '.\XBox2_PSI2\';
    files.metafile_prefix = 'metadata_';
    files.metafile_suffix = '.txt';
    
    files.start_year = 2018;
    files.start_month = 4; %3
    files.start_day = 26;
    
    files.end_year = 2018;
    files.end_month = 6;
    files.end_day = 18;
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 15;
    parameters.diff_threshold = 0.1;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    parameters.dc_up_diff_threshold = 0.13; %Difference in DC pulse between BD and previous
    parameters.dc_down_diff_threshold = 0.01;
    parameters.phase_scaling_factor = pi; %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_Amplitude';
    parameters.PSR_amp_field = 'PSR_Amplitude';
    parameters.PEI_amp_field = 'PEI_Amplitude';
    parameters.PSI_ph_field = 'PSI_Phase';
    parameters.PSR_ph_field = 'PSR_Phase';
    parameters.DC_Down_field = 'DC_Down';
    parameters.DC_Up_field = 'DC_Up';
    parameters.prev_log_type = 2; %What value of Log_Type a pulse just before BD has
    parameters.max_pulses_to_prev = 1; %How many pulses the prev and BD pulse can differ by to be attributed to the same event
    
    
    
elseif(strcmp(settings, 'XBox3_SiC2'))
    % Define files to read and write
    files.matfile_dir = 'G:\Workspaces\x\XSbox-BTW2_1\Xbox3_SIC_2_mat_files\';
    files.matfile_prefix = 'EventDataA_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox3C\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.start_year = 2017;
    files.start_month = 10;
    files.start_day = 27;
    
    files.end_year = 2018;
    files.end_month = 3;
    files.end_day = 19;
    
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 17;
    parameters.diff_threshold = 0.25;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    
    parameters.dc_up_diff_threshold = 40; %Difference in DC pulse between BD and previous
    parameters.dc_down_diff_threshold = 40;
    
    parameters.phase_scaling_factor = pi/(2^14); %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_amp';
    parameters.PSR_amp_field = 'PSR_amp';
    parameters.PEI_amp_field = 'PEI_amp';
    parameters.PSI_ph_field = 'PSI_ph';
    parameters.PSR_ph_field = 'PSR_ph';
    parameters.DC_Down_field = 'DC_DOWN';
    parameters.DC_Up_field = 'DC_UP';
    parameters.prev_log_type = 0;
    parameters.max_pulses_to_prev = 200;
    
    
elseif(strcmp(settings, 'XBox3_PSI1'))
    %Define files to read and write
    files.matfile_dir = 'G:\Workspaces\x\Xbox3_T24PSI_1\matfiles\';
    files.matfile_prefix = 'EventDataB_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox3D\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.start_year = 2017;
    files.start_month = 3;
    files.start_day = 20;
    
    files.end_year = 2017;
    files.end_month = 10;
    files.end_day = 9;
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 25;
    parameters.diff_threshold = 0.25;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    
    parameters.dc_up_diff_threshold = 40; %Difference in DC pulse between BD and previous
    parameters.dc_down_diff_threshold = 40;
    
    parameters.phase_scaling_factor = pi/(2^14); %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_amp';
    parameters.PSR_amp_field = 'PSR_amp';
    parameters.PEI_amp_field = 'PEI_amp';
    parameters.PSI_ph_field = 'PSI_ph';
    parameters.PSR_ph_field = 'PSR_ph';
    parameters.DC_Down_field = 'DC_DOWN';
    parameters.DC_Up_field = 'DC_UP';
    parameters.prev_log_type = 0;
    parameters.max_pulses_to_prev = 200;
    
    
elseif(strcmp(settings, 'XBox3_PSI2'))
    %Define files to read and write
    files.matfile_dir = 'G:\Experiments\CTF3\DATA\mkx\XBOX3CD\Xbox3_PSI_2_matfiles\';
    files.matfile_prefix = 'EventDataB_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox3D\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.start_year = 2017;
    files.start_month = 10;
    files.start_day = 27;
    
    files.end_year = 2018;
    files.end_month = 3;
    files.end_day = 19;
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 17;
    parameters.diff_threshold = 0.25;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.75; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    
    parameters.dc_up_diff_threshold = 40; %Difference in DC pulse between BD and previous
    parameters.dc_down_diff_threshold = 40;
    
    parameters.phase_scaling_factor = pi/(2^14); %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_amp';
    parameters.PSR_amp_field = 'PSR_amp';
    parameters.PEI_amp_field = 'PEI_amp';
    parameters.PSI_ph_field = 'PSI_ph';
    parameters.PSR_ph_field = 'PSR_ph';
    parameters.DC_Down_field = 'DC_DOWN';
    parameters.DC_Up_field = 'DC_UP';
    parameters.prev_log_type = 0;
    parameters.max_pulses_to_prev = 200;
    
    
elseif(strcmp(settings, 'XBox3_SiC2_L4'))
    %Define files to read and write
    files.matfile_dir = 'G:\Workspaces\x\Xbox3_TD24SiC_2_L4\matfiles\';
    files.matfile_prefix = 'EventDataB_';
    files.matfile_suffix = '.mat';
    
    files.bdfile_dir = '.\XBox3D_SiC2\';
    files.bdfile_prefix = 'BD_location_';
    files.bdfile_suffix = '.txt';
    
    files.metafile_dir = '.\XBox3D_SiC2\';
    files.metafile_prefix = 'metadata_';
    files.metafile_suffix = '.txt';
    
    files.start_year = 2018;
    files.start_month = 5; %3
    files.start_day = 2; %26
    
    files.end_year = 2018;
    files.end_month = 6;
    files.end_day = 18;
    
    %Parameters related to signal processing
    parameters.xbox1 = false;
    parameters.pulse_start_threshold = 0.75;
    parameters.max_sample_shift = 10;
    parameters.samples_before_trig = 500;
    parameters.filter_span = 17;
    parameters.diff_threshold = 0.25;
    parameters.fractional_edge_threshold = 0.1; %should be bigger than noise and pulse-to-pulse variation
    parameters.fractional_psi_threshold = 0.5; %set this higher for PSI signal since we want to measure phase
    %after the signal has had some time to stabilise
    
    parameters.dc_up_diff_threshold = 40; %Difference in DC pulse between BD and previous
    parameters.dc_down_diff_threshold = 40;
    
    parameters.phase_scaling_factor = pi/(2^14); %In Xbox2, range [-1, 1] corresponds to a full rotation.
    %Other scaling factor for Xbox 3 etc !
    parameters.phase_sampling_window = 10;
    parameters.structure_time_limts = [-5e-9 70e-9];
    parameters.PSI_amp_field = 'PSI_amp';
    parameters.PSR_amp_field = 'PSR_amp';
    parameters.PEI_amp_field = 'PEI_amp';
    parameters.PSI_ph_field = 'PSI_ph';
    parameters.PSR_ph_field = 'PSR_ph';
    parameters.DC_Down_field = 'DC_DOWN';
    parameters.DC_Up_field = 'DC_UP';
    parameters.prev_log_type = 0;
    parameters.max_pulses_to_prev = 200;
else
    error('Unknown parameter set.');
end


options.plot_signals = true;
options.perform_analysis = true;
options.write_output = true;
options.output_console = true;
options.output_gui = false;

bd_locator(files, parameters, options, 0);

% disp([num2str(metrics.total_bds) ' events processed.']);
% disp([num2str(metrics.structure_bds) ' (' num2str(metrics.structure_bds / metrics.total_bds * 100) '%) identified as structure breakdowns.']);
% disp([num2str(metrics.correct_pos_bds) ' (' num2str(metrics.correct_pos_bds / metrics.total_bds * 100) '%) within 5 ns of structure.']);
% %since structure BD might have mising previous pulse:
% disp([num2str(metrics.incorrect_pos_bds) ' (' num2str(metrics.incorrect_pos_bds / metrics.total_bds * 100) '%) outside of structure.']);
