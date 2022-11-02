function varargout = analyser_gui(varargin)
% ANALYSER_GUI MATLAB code for analyser_gui.fig
%      ANALYSER_GUI, by itself, creates a new ANALYSER_GUI or raises the existing
%      singleton*.
%
%      H = ANALYSER_GUI returns the handle to a new ANALYSER_GUI or the handle to
%      the existing singleton*.
%
%      ANALYSER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSER_GUI.M with the given input arguments.
%
%      ANALYSER_GUI('Property','Value',...) creates a new ANALYSER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analyser_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analyser_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analyser_gui

% Last Modified by GUIDE v2.5 08-Apr-2019 12:20:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analyser_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @analyser_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before analyser_gui is made visible.
function analyser_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analyser_gui (see VARARGIN)

handles.log_edit.String = {''};

% Choose default command line output for analyser_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes analyser_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analyser_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_parameters;

options.plot_signals = false;
options.perform_analysis = true;
options.write_output = true;
options.output_console = false;
options.output_gui = true;

bd_locator(files, parameters, options, handles);

function dir_tdms_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dir_tdms_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dir_tdms_edit as text
%        str2double(get(hObject,'String')) returns contents of dir_tdms_edit as a double


% --- Executes during object creation, after setting all properties.
function dir_tdms_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dir_tdms_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dir_data_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dir_data_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dir_data_edit as text
%        str2double(get(hObject,'String')) returns contents of dir_data_edit as a double


% --- Executes during object creation, after setting all properties.
function dir_data_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dir_data_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function save_dir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to save_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_dir_edit as text
%        str2double(get(hObject,'String')) returns contents of save_dir_edit as a double


% --- Executes during object creation, after setting all properties.
function save_dir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function log_edit_Callback(hObject, eventdata, handles)
% hObject    handle to log_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of log_edit as text
%        str2double(get(hObject,'String')) returns contents of log_edit as a double


% --- Executes during object creation, after setting all properties.
function log_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to log_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startday_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startday_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startday_edit as text
%        str2double(get(hObject,'String')) returns contents of startday_edit as a double


% --- Executes during object creation, after setting all properties.
function startday_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startday_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endday_edit_Callback(hObject, eventdata, handles)
% hObject    handle to endday_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endday_edit as text
%        str2double(get(hObject,'String')) returns contents of endday_edit as a double


% --- Executes during object creation, after setting all properties.
function endday_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endday_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startmonth_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startmonth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startmonth_edit as text
%        str2double(get(hObject,'String')) returns contents of startmonth_edit as a double


% --- Executes during object creation, after setting all properties.
function startmonth_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startmonth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startyear_edit_Callback(hObject, eventdata, handles)
% hObject    handle to startyear_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startyear_edit as text
%        str2double(get(hObject,'String')) returns contents of startyear_edit as a double


% --- Executes during object creation, after setting all properties.
function startyear_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startyear_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

drawnow;
update_parameters;

options.output_console = false;
options.output_gui = true;

[filename, path] = uiputfile('config.mat');

% %check if filename is valid - uiputfile will return 0 if invalid, string if valid
if(isnumeric(filename) || isnumeric(path))
    add_to_log('Invalid filename.', files, options, handles);
else
    save([path, filename], 'files', 'parameters', 'pulse_explorer', 'bd_plotter_settings');
    add_to_log('Config file saved.', files, options, handles);
    drawnow;
end
    
    


% --- Executes on button press in split_checkbox.
function split_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to split_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of split_checkbox



function max_length_edit_Callback(hObject, eventdata, handles)
% hObject    handle to max_length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_length_edit as text
%        str2double(get(hObject,'String')) returns contents of max_length_edit as a double


% --- Executes during object creation, after setting all properties.
function max_length_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, path] = uigetfile('*.mat');

options.output_console = false;
options.output_gui = true;

%check if filename is valid - uiputfile will return 0 if invalid, string
%if valid
if(isnumeric(filename) || isnumeric(path))
    add_to_log('Invalid filename.', [], options, handles);
else
    load([path, filename]);
    
    handles.matfile_dir_edit.String = files.matfile_dir;
    handles.matfile_prefix_edit.String = files.matfile_prefix;
    handles.matfile_suffix_edit.String = files.matfile_suffix;
    
    handles.bdfile_dir_edit.String = files.bdfile_dir;
    handles.bdfile_prefix_edit.String = files.bdfile_prefix;
    handles.bdfile_suffix_edit.String = files.bdfile_suffix;
    
    handles.metafile_dir_edit.String = files.metafile_dir;
    handles.metafile_prefix_edit.String = files.metafile_prefix;
    handles.metafile_suffix_edit.String = files.metafile_suffix;
    
    handles.startyear_edit.String = num2str(files.start_year);
    handles.startmonth_edit.String = num2str(files.start_month);
    handles.startday_edit.String = num2str(files.start_day);
    
    handles.endyear_edit.String = num2str(files.end_year);
    handles.endmonth_edit.String = num2str(files.end_month);
    handles.endday_edit.String = num2str(files.end_day);
    
    handles.xbox1_checkbox.Value = parameters.xbox1;
    handles.pulse_start_threshold_edit.String = num2str(parameters.pulse_start_threshold);
    handles.max_sample_shift_edit.String = num2str(parameters.max_sample_shift);
    handles.samples_before_trig_edit.String = num2str(parameters.samples_before_trig);
    handles.filter_span_edit.String = num2str(parameters.filter_span);
    handles.diff_threshold_edit.String = num2str(parameters.diff_threshold);
    handles.fractional_edge_threshold_edit.String = num2str(parameters.fractional_edge_threshold);
    handles.fractional_psi_threshold_edit.String = num2str(parameters.fractional_psi_threshold);
    handles.dc_up_diff_threshold_edit.String = num2str(parameters.dc_up_diff_threshold);
    handles.dc_down_diff_threshold_edit.String = num2str(parameters.dc_down_diff_threshold);
    handles.phase_scaling_factor_edit.String = num2str(parameters.phase_scaling_factor);
    handles.phase_sampling_window_edit.String = num2str(parameters.phase_sampling_window);
    handles.phase_sampling_delay_edit.String = num2str(parameters.phase_sampling_delay);
    
    if(strcmp(parameters.phase_sampling_edge, 'PSI'))
        handles.phase_sampling_edge_menu.Value = 1;
    elseif(strcmp(parameters.phase_sampling_edge, 'PSR'))
        handles.phase_sampling_edge_menu.Value = 2;
    end
    
    handles.structure_llim_edit.String = num2str(1e9 * parameters.structure_time_limts(1));
    handles.structure_ulim_edit.String = num2str(1e9 * parameters.structure_time_limts(2));
    
    handles.PSI_amp_field_edit.String = parameters.PSI_amp_field;
    handles.PSR_amp_field_edit.String = parameters.PSR_amp_field;
    handles.PEI_amp_field_edit.String = parameters.PEI_amp_field;
    handles.PSI_ph_field_edit.String = parameters.PSI_ph_field;
    handles.PSR_ph_field_edit.String = parameters.PSR_ph_field;
    handles.DC_Down_field_edit.String = parameters.DC_Down_field;
    handles.DC_Up_field_edit.String = parameters.DC_Up_field;
    handles.prev_log_type_edit.String = num2str(parameters.prev_log_type);
    
    if(parameters.xbox1)
        handles.max_pulses_to_prev_edit.String = num2str(parameters.max_time_to_prev);
    else
        handles.max_pulses_to_prev_edit.String = num2str(parameters.max_pulses_to_prev);
    end
    
    handles.pulse_explorer_year_edit.String = num2str(pulse_explorer.year);
    handles.pulse_explorer_month_edit.String = num2str(pulse_explorer.month);
    handles.pulse_explorer_day_edit.String = num2str(pulse_explorer.day);
    
    handles.bd_pos_caxis_llim_edit.String = num2str(bd_plotter_settings.position_caxis_limits(1));
    handles.bd_pos_caxis_ulim_edit.String = num2str(bd_plotter_settings.position_caxis_limits(2));
    
    handles.bd_phase_caxis_llim_edit.String = num2str(bd_plotter_settings.phase_caxis_limits(1));
    handles.bd_phase_caxis_ulim_edit.String = num2str(bd_plotter_settings.phase_caxis_limits(2));
    
    handles.bd_time_caxis_llim_edit.String = num2str(bd_plotter_settings.time_caxis_limits(1));
    handles.bd_time_caxis_ulim_edit.String = num2str(bd_plotter_settings.time_caxis_limits(2));
    
    handles.plotter_structure_time_llim_edit.String = num2str(1e9 * bd_plotter_settings.structure_time_limits(1));
    handles.plotter_structure_time_ulim_edit.String = num2str(1e9 * bd_plotter_settings.structure_time_limits(2));
    
    handles.bd_time_llim_edit.String = num2str(1e9 * bd_plotter_settings.bd_time_limits(1));
    handles.bd_time_ulim_edit.String = num2str(1e9 * bd_plotter_settings.bd_time_limits(2));
    
    handles.pulses_per_bin_edit.String = num2str(bd_plotter_settings.pulses_per_bin);
    handles.s_per_bin_edit.String =  num2str(bd_plotter_settings.s_per_bin * 1e9);
    handles.degrees_per_bin_edit.String = num2str(bd_plotter_settings.degrees_per_bin);

    add_to_log('Config file loaded.', files, options, handles);
    drawnow;
end



function matfile_prefix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to matfile_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of matfile_prefix_edit as text
%        str2double(get(hObject,'String')) returns contents of matfile_prefix_edit as a double


% --- Executes during object creation, after setting all properties.
function matfile_prefix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matfile_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endmonth_edit_Callback(hObject, eventdata, handles)
% hObject    handle to endmonth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endmonth_edit as text
%        str2double(get(hObject,'String')) returns contents of endmonth_edit as a double


% --- Executes during object creation, after setting all properties.
function endmonth_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endmonth_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endyear_edit_Callback(hObject, eventdata, handles)
% hObject    handle to endyear_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endyear_edit as text
%        str2double(get(hObject,'String')) returns contents of endyear_edit as a double


% --- Executes during object creation, after setting all properties.
function endyear_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endyear_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function metafile_prefix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to metafile_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of metafile_prefix_edit as text
%        str2double(get(hObject,'String')) returns contents of metafile_prefix_edit as a double


% --- Executes during object creation, after setting all properties.
function metafile_prefix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metafile_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function metafile_dir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to metafile_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of metafile_dir_edit as text
%        str2double(get(hObject,'String')) returns contents of metafile_dir_edit as a double


% --- Executes during object creation, after setting all properties.
function metafile_dir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metafile_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function metafile_suffix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to metafile_suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of metafile_suffix_edit as text
%        str2double(get(hObject,'String')) returns contents of metafile_suffix_edit as a double


% --- Executes during object creation, after setting all properties.
function metafile_suffix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metafile_suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bdfile_prefix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bdfile_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bdfile_prefix_edit as text
%        str2double(get(hObject,'String')) returns contents of bdfile_prefix_edit as a double


% --- Executes during object creation, after setting all properties.
function bdfile_prefix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bdfile_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bdfile_dir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bdfile_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bdfile_dir_edit as text
%        str2double(get(hObject,'String')) returns contents of bdfile_dir_edit as a double


% --- Executes during object creation, after setting all properties.
function bdfile_dir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bdfile_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bdfile_suffix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bdfile_suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bdfile_suffix_edit as text
%        str2double(get(hObject,'String')) returns contents of bdfile_suffix_edit as a double


% --- Executes during object creation, after setting all properties.
function bdfile_suffix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bdfile_suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function matfile_dir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to matfile_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of matfile_dir_edit as text
%        str2double(get(hObject,'String')) returns contents of matfile_dir_edit as a double


% --- Executes during object creation, after setting all properties.
function matfile_dir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matfile_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function matfile_suffix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to matfile_suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of matfile_suffix_edit as text
%        str2double(get(hObject,'String')) returns contents of matfile_suffix_edit as a double


% --- Executes during object creation, after setting all properties.
function matfile_suffix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matfile_suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)
% hObject    handle to plot_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_parameters;

options.plot_signals = false;
options.perform_analysis = true;
options.write_output = true;
options.output_console = false;
options.output_gui = true;

bd_plotter(files, parameters, options, handles, bd_plotter_settings);


function PSI_amp_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to PSI_amp_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PSI_amp_field_edit as text
%        str2double(get(hObject,'String')) returns contents of PSI_amp_field_edit as a double


% --- Executes during object creation, after setting all properties.
function PSI_amp_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSI_amp_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in xbox1_checkbox.
function xbox1_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to xbox1_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of xbox1_checkbox



function PSR_amp_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to PSR_amp_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PSR_amp_field_edit as text
%        str2double(get(hObject,'String')) returns contents of PSR_amp_field_edit as a double


% --- Executes during object creation, after setting all properties.
function PSR_amp_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSR_amp_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PEI_amp_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to PEI_amp_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PEI_amp_field_edit as text
%        str2double(get(hObject,'String')) returns contents of PEI_amp_field_edit as a double


% --- Executes during object creation, after setting all properties.
function PEI_amp_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PEI_amp_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PSR_ph_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to PSR_ph_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PSR_ph_field_edit as text
%        str2double(get(hObject,'String')) returns contents of PSR_ph_field_edit as a double


% --- Executes during object creation, after setting all properties.
function PSR_ph_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSR_ph_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PSI_ph_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to PSI_ph_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PSI_ph_field_edit as text
%        str2double(get(hObject,'String')) returns contents of PSI_ph_field_edit as a double


% --- Executes during object creation, after setting all properties.
function PSI_ph_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PSI_ph_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DC_Up_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to DC_Up_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DC_Up_field_edit as text
%        str2double(get(hObject,'String')) returns contents of DC_Up_field_edit as a double


% --- Executes during object creation, after setting all properties.
function DC_Up_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DC_Up_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DC_Down_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to DC_Down_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DC_Down_field_edit as text
%        str2double(get(hObject,'String')) returns contents of DC_Down_field_edit as a double


% --- Executes during object creation, after setting all properties.
function DC_Down_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DC_Down_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulse_start_threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_start_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_start_threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of pulse_start_threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function pulse_start_threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_start_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_sample_shift_edit_Callback(hObject, eventdata, handles)
% hObject    handle to max_sample_shift_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_sample_shift_edit as text
%        str2double(get(hObject,'String')) returns contents of max_sample_shift_edit as a double


% --- Executes during object creation, after setting all properties.
function max_sample_shift_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_sample_shift_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function samples_before_trig_edit_Callback(hObject, eventdata, handles)
% hObject    handle to samples_before_trig_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samples_before_trig_edit as text
%        str2double(get(hObject,'String')) returns contents of samples_before_trig_edit as a double


% --- Executes during object creation, after setting all properties.
function samples_before_trig_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samples_before_trig_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filter_span_edit_Callback(hObject, eventdata, handles)
% hObject    handle to filter_span_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filter_span_edit as text
%        str2double(get(hObject,'String')) returns contents of filter_span_edit as a double


% --- Executes during object creation, after setting all properties.
function filter_span_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_span_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function diff_threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to diff_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of diff_threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of diff_threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function diff_threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diff_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fractional_edge_threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fractional_edge_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fractional_edge_threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of fractional_edge_threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function fractional_edge_threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fractional_edge_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fractional_psi_threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fractional_psi_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fractional_psi_threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of fractional_psi_threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function fractional_psi_threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fractional_psi_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dc_up_diff_threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dc_up_diff_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dc_up_diff_threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of dc_up_diff_threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function dc_up_diff_threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dc_up_diff_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dc_down_diff_threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dc_down_diff_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dc_down_diff_threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of dc_down_diff_threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function dc_down_diff_threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dc_down_diff_threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prev_log_type_edit_Callback(hObject, eventdata, handles)
% hObject    handle to prev_log_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prev_log_type_edit as text
%        str2double(get(hObject,'String')) returns contents of prev_log_type_edit as a double


% --- Executes during object creation, after setting all properties.
function prev_log_type_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prev_log_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_pulses_to_prev_edit_Callback(hObject, eventdata, handles)
% hObject    handle to max_pulses_to_prev_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_pulses_to_prev_edit as text
%        str2double(get(hObject,'String')) returns contents of max_pulses_to_prev_edit as a double


% --- Executes during object creation, after setting all properties.
function max_pulses_to_prev_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_pulses_to_prev_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phase_scaling_factor_edit_Callback(hObject, eventdata, handles)
% hObject    handle to phase_scaling_factor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phase_scaling_factor_edit as text
%        str2double(get(hObject,'String')) returns contents of phase_scaling_factor_edit as a double


% --- Executes during object creation, after setting all properties.
function phase_scaling_factor_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_scaling_factor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phase_sampling_window_edit_Callback(hObject, eventdata, handles)
% hObject    handle to phase_sampling_window_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phase_sampling_window_edit as text
%        str2double(get(hObject,'String')) returns contents of phase_sampling_window_edit as a double


% --- Executes during object creation, after setting all properties.
function phase_sampling_window_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_sampling_window_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function structure_llim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to structure_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of structure_llim_edit as text
%        str2double(get(hObject,'String')) returns contents of structure_llim_edit as a double


% --- Executes during object creation, after setting all properties.
function structure_llim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to structure_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function structure_ulim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to structure_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of structure_ulim_edit as text
%        str2double(get(hObject,'String')) returns contents of structure_ulim_edit as a double


% --- Executes during object creation, after setting all properties.
function structure_ulim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to structure_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulse_explorer_day_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_day_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_explorer_day_edit as text
%        str2double(get(hObject,'String')) returns contents of pulse_explorer_day_edit as a double


% --- Executes during object creation, after setting all properties.
function pulse_explorer_day_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_day_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulse_explorer_year_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_year_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_explorer_year_edit as text
%        str2double(get(hObject,'String')) returns contents of pulse_explorer_year_edit as a double


% --- Executes during object creation, after setting all properties.
function pulse_explorer_year_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_year_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulse_explorer_month_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_month_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_explorer_month_edit as text
%        str2double(get(hObject,'String')) returns contents of pulse_explorer_month_edit as a double


% --- Executes during object creation, after setting all properties.
function pulse_explorer_month_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_month_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pulse_explorer_prev_day_button.
function pulse_explorer_prev_day_button_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_prev_day_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

curr_year = str2double(handles.pulse_explorer_year_edit.String);
curr_month = str2double(handles.pulse_explorer_month_edit.String);
curr_day = str2double(handles.pulse_explorer_day_edit.String);

curr_date = datenum(curr_year, curr_month, curr_day);

curr_datetime = datetime(curr_date - 1, 'ConvertFrom', 'datenum');
handles.pulse_explorer_year_edit.String = num2str(curr_datetime.Year);
handles.pulse_explorer_month_edit.String = num2str(curr_datetime.Month);
handles.pulse_explorer_day_edit.String = num2str(curr_datetime.Day);

drawnow;

% --- Executes on button press in pulse_explorer_next_day_button.
function pulse_explorer_next_day_button_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_next_day_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

curr_year = str2double(handles.pulse_explorer_year_edit.String);
curr_month = str2double(handles.pulse_explorer_month_edit.String);
curr_day = str2double(handles.pulse_explorer_day_edit.String);

curr_date = datenum(curr_year, curr_month, curr_day);

curr_datetime = datetime(curr_date + 1, 'ConvertFrom', 'datenum');
handles.pulse_explorer_year_edit.String = num2str(curr_datetime.Year);
handles.pulse_explorer_month_edit.String = num2str(curr_datetime.Month);
handles.pulse_explorer_day_edit.String = num2str(curr_datetime.Day);

drawnow;



% --- Executes on button press in pulse_explorer_load_button.
function pulse_explorer_load_button_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_parameters;

%Load TDMS file and read breakdowns:
tdms_filename = [files.matfile_dir, files.matfile_prefix, handles.pulse_explorer_year_edit.String, ...
    num2str(str2double(handles.pulse_explorer_month_edit.String), '%02d'),...
    num2str(str2double(handles.pulse_explorer_day_edit.String), '%02d'), files.matfile_suffix];

%Load file if exists, otherwise skip

options.output_console = false;
options.output_gui = true;

metrics.total_bds = 0;
metrics.structure_bds = 0;
metrics.correct_pos_bds = 0;
metrics.incorrect_pos_bds = 0;

if(exist(tdms_filename, 'file') ~= 2)
    add_to_log(['File '  tdms_filename ' is missing.'], files, options, handles);
else
    load(tdms_filename);
    field_names = fieldnames(tdms_struct);
    [~, BD_list] = prepare_bd_data(files, parameters, options, metrics, handles, field_names, tdms_struct, tdms_filename);
    
    %Save BD_list and TDMS variables to base workspace:
    assignin('base', 'BD_list', BD_list);
    assignin('base', 'field_names', field_names);
    assignin('base', 'tdms_struct', tdms_struct);
    assignin('base', 'tdms_filename', tdms_filename);
    
    %Populate listbox in any BDs available:
    bd_listbox_string = {''};
    if(~isequal(BD_list, {''}))
        for i = 1:length(BD_list)
            bd_listbox_string = [bd_listbox_string; BD_list{i}.field_name];
        end
        
        %remove first empty entry:
        bd_listbox_string = bd_listbox_string(2:end);
    end
    
    handles.pulse_explorer_bds_listbox.String = bd_listbox_string;
    handles.pulse_explorer_bds_listbox.Value = length(bd_listbox_string);
    drawnow;
end


% --- Executes on selection change in pulse_explorer_bds_listbox.
function pulse_explorer_bds_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_bds_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_parameters;

%Read BD_list and TDMS variables from base workspace:
BD_list = evalin('base', 'BD_list');
field_names = evalin('base', 'field_names');
tdms_struct = evalin('base', 'tdms_struct');

selected_BD = handles.pulse_explorer_bds_listbox.Value;

options.plot_signals = true;
options.perform_analysis = true;
options.write_output = true;
options.output_console = false;
options.output_gui = true;

metrics.total_bds = 0;
metrics.structure_bds = 0;
metrics.correct_pos_bds = 0;
metrics.incorrect_pos_bds = 0;

if(~isequal(BD_list, {''}))
    [~, BD_list] = perform_bd_localisation(files, parameters, options, metrics, handles, ...
        field_names, tdms_struct, BD_list, selected_BD);
end



% --- Executes during object creation, after setting all properties.
function pulse_explorer_bds_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_explorer_bds_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plotter_structure_time_llim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to plotter_structure_time_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plotter_structure_time_llim_edit as text
%        str2double(get(hObject,'String')) returns contents of plotter_structure_time_llim_edit as a double


% --- Executes during object creation, after setting all properties.
function plotter_structure_time_llim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotter_structure_time_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plotter_structure_time_ulim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to plotter_structure_time_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plotter_structure_time_ulim_edit as text
%        str2double(get(hObject,'String')) returns contents of plotter_structure_time_ulim_edit as a double


% --- Executes during object creation, after setting all properties.
function plotter_structure_time_ulim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotter_structure_time_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_pos_caxis_llim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_pos_caxis_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_pos_caxis_llim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_pos_caxis_llim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_pos_caxis_llim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_pos_caxis_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_pos_caxis_ulim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_pos_caxis_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_pos_caxis_ulim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_pos_caxis_ulim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_pos_caxis_ulim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_pos_caxis_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_phase_caxis_llim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_phase_caxis_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_phase_caxis_llim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_phase_caxis_llim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_phase_caxis_llim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_phase_caxis_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_phase_caxis_ulim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_phase_caxis_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_phase_caxis_ulim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_phase_caxis_ulim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_phase_caxis_ulim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_phase_caxis_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_time_llim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_time_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_time_llim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_time_llim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_time_llim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_time_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_time_ulim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_time_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_time_ulim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_time_ulim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_time_ulim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_time_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_time_caxis_llim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_time_caxis_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_time_caxis_llim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_time_caxis_llim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_time_caxis_llim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_time_caxis_llim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bd_time_caxis_ulim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to bd_time_caxis_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bd_time_caxis_ulim_edit as text
%        str2double(get(hObject,'String')) returns contents of bd_time_caxis_ulim_edit as a double


% --- Executes during object creation, after setting all properties.
function bd_time_caxis_ulim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bd_time_caxis_ulim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tdms_converter_launch_button.
function tdms_converter_launch_button_Callback(hObject, eventdata, handles)
% hObject    handle to tdms_converter_launch_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

make_matfiles_gui;



function phase_sampling_delay_edit_Callback(hObject, eventdata, handles)
% hObject    handle to phase_sampling_delay_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phase_sampling_delay_edit as text
%        str2double(get(hObject,'String')) returns contents of phase_sampling_delay_edit as a double


% --- Executes during object creation, after setting all properties.
function phase_sampling_delay_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_sampling_delay_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in phase_sampling_edge_menu.
function phase_sampling_edge_menu_Callback(hObject, eventdata, handles)
% hObject    handle to phase_sampling_edge_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns phase_sampling_edge_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from phase_sampling_edge_menu


% --- Executes during object creation, after setting all properties.
function phase_sampling_edge_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_sampling_edge_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pulses_per_bin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pulses_per_bin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulses_per_bin_edit as text
%        str2double(get(hObject,'String')) returns contents of pulses_per_bin_edit as a double


% --- Executes during object creation, after setting all properties.
function pulses_per_bin_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulses_per_bin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_per_bin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to s_per_bin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_per_bin_edit as text
%        str2double(get(hObject,'String')) returns contents of s_per_bin_edit as a double


% --- Executes during object creation, after setting all properties.
function s_per_bin_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_per_bin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function degrees_per_bin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to degrees_per_bin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of degrees_per_bin_edit as text
%        str2double(get(hObject,'String')) returns contents of degrees_per_bin_edit as a double


% --- Executes during object creation, after setting all properties.
function degrees_per_bin_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to degrees_per_bin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
