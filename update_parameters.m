%Update all variable values from edit box values

files.matfile_dir = handles.matfile_dir_edit.String;
files.matfile_prefix = handles.matfile_prefix_edit.String;
files.matfile_suffix = handles.matfile_suffix_edit.String;

files.bdfile_dir = handles.bdfile_dir_edit.String;
files.bdfile_prefix = handles.bdfile_prefix_edit.String;
files.bdfile_suffix = handles.bdfile_suffix_edit.String;

files.metafile_dir = handles.metafile_dir_edit.String;
files.metafile_prefix = handles.metafile_prefix_edit.String;
files.metafile_suffix = handles.metafile_suffix_edit.String;

files.start_year = str2double(handles.startyear_edit.String);
files.start_month = str2double(handles.startmonth_edit.String);
files.start_day = str2double(handles.startday_edit.String);

files.end_year = str2double(handles.endyear_edit.String);
files.end_month = str2double(handles.endmonth_edit.String);
files.end_day = str2double(handles.endday_edit.String);

parameters.xbox1 = handles.xbox1_checkbox.Value;
parameters.pulse_start_threshold = str2double(handles.pulse_start_threshold_edit.String);
parameters.max_sample_shift = str2double(handles.max_sample_shift_edit.String);
parameters.samples_before_trig = str2double(handles.samples_before_trig_edit.String);
parameters.filter_span = str2double(handles.filter_span_edit.String);
parameters.diff_threshold = str2double(handles.diff_threshold_edit.String);
parameters.fractional_edge_threshold = str2double(handles.fractional_edge_threshold_edit.String);
parameters.fractional_psi_threshold = str2double(handles.fractional_psi_threshold_edit.String);
parameters.dc_up_diff_threshold = str2double(handles.dc_up_diff_threshold_edit.String);
parameters.dc_down_diff_threshold = str2double(handles.dc_down_diff_threshold_edit.String);
parameters.phase_scaling_factor = str2double(handles.phase_scaling_factor_edit.String);
parameters.phase_sampling_window = str2double(handles.phase_sampling_window_edit.String);
parameters.phase_sampling_delay = str2double(handles.phase_sampling_delay_edit.String);

if(handles.phase_sampling_edge_menu.Value == 1)
    parameters.phase_sampling_edge = 'PSI';
elseif(handles.phase_sampling_edge_menu.Value == 2)
    parameters.phase_sampling_edge = 'PSR';
end

parameters.structure_time_limts = 1e-9 * [str2double(handles.structure_llim_edit.String) ...
    str2double(handles.structure_ulim_edit.String)];
parameters.PSI_amp_field = handles.PSI_amp_field_edit.String;
parameters.PSR_amp_field = handles.PSR_amp_field_edit.String;
parameters.PEI_amp_field = handles.PEI_amp_field_edit.String;
parameters.PSI_ph_field = handles.PSI_ph_field_edit.String;
parameters.PSR_ph_field = handles.PSR_ph_field_edit.String;
parameters.DC_Down_field = handles.DC_Down_field_edit.String;
parameters.DC_Up_field = handles.DC_Up_field_edit.String;
parameters.prev_log_type = str2double(handles.prev_log_type_edit.String);

if(parameters.xbox1)
    parameters.max_time_to_prev = str2double(handles.max_pulses_to_prev_edit.String);
else
    parameters.max_pulses_to_prev = str2double(handles.max_pulses_to_prev_edit.String);
end

pulse_explorer.year = str2double(handles.pulse_explorer_year_edit.String);
pulse_explorer.month = str2double(handles.pulse_explorer_month_edit.String);
pulse_explorer.day = str2double(handles.pulse_explorer_day_edit.String);

bd_plotter_settings.position_caxis_limits = [str2double(handles.bd_pos_caxis_llim_edit.String) ...
    str2double(handles.bd_pos_caxis_ulim_edit.String)];
bd_plotter_settings.phase_caxis_limits = [str2double(handles.bd_phase_caxis_llim_edit.String)...
    str2double(handles.bd_phase_caxis_ulim_edit.String)];
bd_plotter_settings.time_caxis_limits = [str2double(handles.bd_time_caxis_llim_edit.String) ...
    str2double(handles.bd_time_caxis_ulim_edit.String)];

bd_plotter_settings.structure_time_limits = 1e-9 * [str2double(handles.plotter_structure_time_llim_edit.String) ...
    str2double(handles.plotter_structure_time_ulim_edit.String)];
bd_plotter_settings.bd_time_limits = 1e-9 * [str2double(handles.bd_time_llim_edit.String) ...
    str2double(handles.bd_time_ulim_edit.String)];

bd_plotter_settings.pulses_per_bin = str2double(handles.pulses_per_bin_edit.String);
bd_plotter_settings.s_per_bin = 1e-9 * str2double(handles.s_per_bin_edit.String);
bd_plotter_settings.degrees_per_bin = str2double(handles.degrees_per_bin_edit.String);