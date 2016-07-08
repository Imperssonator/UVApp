function varargout = UVApp(varargin)
% UVAPP MATLAB code for UVApp.fig
%      UVAPP, by itself, creates a new UVAPP or raises the existing
%      singleton*.
%
%      H = UVAPP returns the handle to a new UVAPP or the handle to
%      the existing singleton*.
%
%      UVAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UVAPP.M with the given input arguments.
%
%      UVAPP('Property','Value',...) creates a new UVAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UVApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UVApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UVApp

% Last Modified by GUIDE v2.5 03-Jun-2016 16:21:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UVApp_OpeningFcn, ...
                   'gui_OutputFcn',  @UVApp_OutputFcn, ...
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


% --- Executes just before UVApp is made visible.
function UVApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UVApp (see VARARGIN)

% Choose default command line output for UVApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UVApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --------------------------------------------------------------------
function RunDir_Callback(hObject, eventdata, handles)
% hObject    handle to RunDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

folderPath = uigetdir;
if isequal(folderPath, 0); return; end % Cancel button pressed
if ispc
    separator = '\';
else
    separator = '/';
end

handles.folderPath = [folderPath, separator];
saveFilePath = [folderPath, 'UV Results.csv'];

handles.options = get_options(handles);

handles.UVS = RunUVFolder(handles.folderPath,handles.options);
handles.tableData = [{handles.UVS(:).Name}', {handles.UVS(:).EB}', {handles.UVS(:).AggFrac}'];
set(handles.uitable1,'Data',handles.tableData);

UVS = handles.UVS;
save('UVStest','UVS')

guidata(hObject,handles);

% --- Executes on button press in Refit.
function Refit_Callback(hObject, eventdata, handles)
% hObject    handle to Refit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.options = get_options(handles);

handles.UVS = RunUVFolder(handles.folderPath,handles.options);
handles.tableData = [{handles.UVS(:).Name}', {handles.UVS(:).EB}', {handles.UVS(:).AggFrac}'];
set(handles.uitable1,'Data',handles.tableData);

guidata(hObject,handles);


% --- Outputs from this function are returned to the command line.
function varargout = UVApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function plotSpecNum_Callback(hObject, eventdata, handles)
% hObject    handle to plotSpecNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function plotSpecNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotSpecNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fitPlot.
function fitPlot_Callback(hObject, eventdata, handles)
% hObject    handle to fitPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

plotSpecNum = uint8(str2num(get(handles.plotSpecNum,'String')));

PlotFit(handles,plotSpecNum)
set(handles.axes1.XLabel,'String','Wavelength (nm)')
set(handles.axes1.YLabel,'String','Absorbance')
set(handles.axes1,'FontSize',16)
set(handles.axes1,'YLim',[-0.2,1.2]);

guidata(hObject,handles)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if size(eventdata.Indices,1)>0
    set(handles.plotSpecNum,'String',num2str(eventdata.Indices(1)))
end

if isfield(handles,'UVS')
    fitPlot_Callback(hObject, eventdata, handles)
end

guidata(hObject,handles)

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in sampleType.
function sampleType_Callback(hObject, eventdata, handles)
% hObject    handle to sampleType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sampleType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sampleType


% --- Executes during object creation, after setting all properties.
function sampleType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


