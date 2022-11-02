function varargout = make_matfiles_gui(varargin)
% MAKE_MATFILES_GUI MATLAB code for make_matfiles_gui.fig
%      MAKE_MATFILES_GUI, by itself, creates a new MAKE_MATFILES_GUI or raises the existing
%      singleton*.
%
%      H = MAKE_MATFILES_GUI returns the handle to a new MAKE_MATFILES_GUI or the handle to
%      the existing singleton*.
%
%      MAKE_MATFILES_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKE_MATFILES_GUI.M with the given input arguments.
%
%      MAKE_MATFILES_GUI('Property','Value',...) creates a new MAKE_MATFILES_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before make_matfiles_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to make_matfiles_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help make_matfiles_gui

% Last Modified by GUIDE v2.5 05-Dec-2017 14:57:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @make_matfiles_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @make_matfiles_gui_OutputFcn, ...
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


% --- Executes just before make_matfiles_gui is made visible.
function make_matfiles_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to make_matfiles_gui (see VARARGIN)

handles.log_edit.String = {''};

tdms_prefix = 'EventData_';
tdms_dir = 'G:\Workspaces\x\Xbox2_T24PSI_1\';
local_tdms_dir = 'C:\Users\japaszki\tdms_data\';
matfile_dir = 'G:\Users\j\japaszki\Public\XBOX\xbox_analysis\';
start_day = 15;
start_month = 10;
start_year = 2017;
end_day = 16;
end_month = 10;
end_year = 2017;
split_file = false;
max_length = 500;

handles.file_prefix_edit.String = tdms_prefix;
handles.dir_tdms_edit.String = tdms_dir;
handles.dir_data_edit.String = local_tdms_dir;
handles.save_dir_edit.String = matfile_dir;
handles.startday_edit.String = num2str(start_day);
handles.startmonth_edit.String = num2str(start_month);
handles.startyear_edit.String = num2str(start_year);
handles.endday_edit.String = num2str(end_day);
handles.endmonth_edit.String = num2str(end_month);
handles.endyear_edit.String = num2str(end_year);
handles.split_checkbox.Value = split_file;
handles.max_length_edit.String = num2str(max_length);

% Choose default command line output for make_matfiles_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes make_matfiles_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = make_matfiles_gui_OutputFcn(hObject, eventdata, handles) 
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

make_matfiles;

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
tdms_prefix = handles.file_prefix_edit.String;
dir_tdms = handles.dir_tdms_edit.String;
dir_data = handles.dir_data_edit.String;
save_dir  = handles.save_dir_edit.String;
start_day = str2num(handles.startday_edit.String);
start_month = str2num(handles.startmonth_edit.String);
start_year = str2num(handles.startyear_edit.String);
end_day = str2num(handles.endday_edit.String);
end_month = str2num(handles.endmonth_edit.String);
end_year = str2num(handles.endyear_edit.String);
split_file = handles.split_checkbox.Value;
max_length = str2num(handles.max_length_edit.String);

[filename, path] = uiputfile('config.mat');

%check if filename is valid - uiputfile will return 0 if invalid, string
%if valid
if(isnumeric(filename) || isnumeric(path))
    handles.log_edit.String = [handles.log_edit.String; 'Invalid filename.'];
else
    save([path, filename], 'tdms_prefix', 'dir_tdms', 'dir_data', 'save_dir',...
        'start_day', 'start_month', 'start_year', 'end_day',...
        'end_month', 'end_year', 'split_file', 'max_length');
    
    handles.log_edit.String = [handles.log_edit.String; 'Config file saved.'];
    handles.log_edit.Value = length(handles.log_edit.String);
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

%check if filename is valid - uiputfile will return 0 if invalid, string
%if valid
if(isnumeric(filename) || isnumeric(path))
    handles.log_edit.String = [handles.log_edit.String; 'Invalid filename.'];
else
    load([path, filename]);
    
    handles.file_prefix_edit.String = tdms_prefix;
    handles.dir_tdms_edit.String = dir_tdms;
    handles.dir_data_edit.String = dir_data;
    handles.save_dir_edit.String = save_dir;
    handles.startday_edit.String = num2str(start_day);
    handles.startmonth_edit.String = num2str(start_month);
    handles.startyear_edit.String = num2str(start_year);
    handles.endday_edit.String = num2str(end_day);
    handles.endmonth_edit.String = num2str(end_month);
    handles.endyear_edit.String = num2str(end_year);
    handles.split_checkbox.Value = split_file;
    handles.max_length_edit.String = num2str(max_length);
    
    handles.log_edit.String = [handles.log_edit.String; 'Config file loaded.'];
    handles.log_edit.Value = length(handles.log_edit.String);
    drawnow;
end



function file_prefix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to file_prefix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_prefix_edit as text
%        str2double(get(hObject,'String')) returns contents of file_prefix_edit as a double


% --- Executes during object creation, after setting all properties.
function file_prefix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_prefix_edit (see GCBO)
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
