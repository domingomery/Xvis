function varargout = Xfxgui(varargin)
% XFXGUI MATLAB code for Xfxgui.fig
%      XFXGUI, by itself, creates a new XFXGUI or raises the existing
%      singleton*.
%
%      H = XFXGUI returns the handle to a new XFXGUI or the handle to
%      the existing singleton*.
%
%      XFXGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XFXGUI.M with the given input arguments.
%
%      XFXGUI('Property','Value',...) creates a new XFXGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xfxgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xfxgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xfxgui

% Last Modified by GUIDE v2.5 25-Feb-2015 08:30:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Xfxgui_OpeningFcn, ...
    'gui_OutputFcn',  @Xfxgui_OutputFcn, ...
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


% --- Executes just before Xfxgui is made visible.
function Xfxgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xfxgui (see VARARGIN)

% Choose default command line output for Xfxgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Xfxgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global d i n fxvar

fxvar.segmentation = 'None';
fxvar.fmt          = 'png';
fxvar.parameters   = [];

fxvar.basicgeo   = 0;
fxvar.fitellipse = 0;
fxvar.flusser    = 0;
fxvar.fourierdes = 0;
fxvar.gupta      = 0;
fxvar.hugeo      = 0;

fxvar.basicint   = 0;
fxvar.clp        = 0;
fxvar.contrast   = 0;
fxvar.fourier    = 0;
fxvar.gabor      = 0;
fxvar.haralick   = 0;
fxvar.huint      = 0;

fxvar.rotinv     = 0;
fxvar.trainv     = 0;
fxvar.scainv     = 0;


d = dir('*.png');
n = length(d);
i = 1;

warning('off', 'Images:initSize:adjustingMag');

ShowImage


function ShowImage
global d i n fxvar
if n==0
    beep;
    fprintf('There is no image in this directory with format %s.\n',fxvar.fmt);
    figure(1)
    clf
else
    I = imread(d(i).name);
    figure(1)
    clf
    if strcmp(fxvar.segmentation,'None')==1
        imshow(I);
    else
        R = feval(fxvar.segmentation,I,fxvar.parameters);
        t = round(length(I(:))/1e6)+1;
        Xbinview(I,bwperim(R),'r',t);
    end
    s = d(i).name;
    ns = strfind(s,'_');
    if ~isempty(ns)
        s = [ s(1:ns-1) '\' s(ns:end) ];
    end
    title(s);
end




% --- Outputs from this function are returned to the command line.
function varargout = Xfxgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
% hObject    handle to Previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i
i = max([i-1 1]);
ShowImage


% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i n
i = min([i+1 n]);
ShowImage


% --- Executes on button press in BasicGeo.
function BasicGeo_Callback(hObject, eventdata, handles)
% hObject    handle to BasicGeo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BasicGeo
global fxvar
fxvar.basicgeo = get(hObject,'Value');


% --- Executes on button press in FitEllipse.
function FitEllipse_Callback(hObject, eventdata, handles)
% hObject    handle to FitEllipse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FitEllipse
global fxvar
fxvar.fitellipse = get(hObject,'Value');


% --- Executes on button press in Flusser.
function Flusser_Callback(hObject, eventdata, handles)
% hObject    handle to Flusser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Flusser
global fxvar
fxvar.flusser = get(hObject,'Value');


% --- Executes on button press in FourierDes.
function FourierDes_Callback(hObject, eventdata, handles)
% hObject    handle to FourierDes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FourierDes
global fxvar
fxvar.fourierdes = get(hObject,'Value');


% --- Executes on button press in Gupta.
function Gupta_Callback(hObject, eventdata, handles)
% hObject    handle to Gupta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Gupta
global fxvar
fxvar.gupta = get(hObject,'Value');


% --- Executes on button press in HuGeo.
function HuGeo_Callback(hObject, eventdata, handles)
% hObject    handle to HuGeo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of HuGeo
global fxvar
fxvar.hugeo = get(hObject,'Value');


% --- Executes on selection change in Segmentation.
function Segmentation_Callback(hObject, eventdata, handles)
% hObject    handle to Segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Segmentation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Segmentation
global fxvar
contents           = cellstr(get(hObject,'String'));
fxvar.segmentation = contents{get(hObject,'Value')};
ShowImage

% --- Executes during object creation, after setting all properties.
function Segmentation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Segmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Go.
function Go_Callback(hObject, eventdata, handles)
% hObject    handle to Go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fxvar

k = 0;

if fxvar.basicgeo   == 1
    k = k + 1;
    b(k).name = 'basicgeo'; 
    b(k).options.show = 0;
    b(k).options.type = 1;
end

if fxvar.fitellipse == 1
    k = k + 1;
    b(k).name = 'fitellipse'; 
    b(k).options.show = 0;
    b(k).options.type = 1;
end

if fxvar.flusser    == 1
    k = k + 1;
    b(k).name = 'flusser'; 
    b(k).options.show = 0;
    b(k).options.type = 1;
end

if fxvar.fourierdes == 1
    k = k + 1;
    b(k).name = 'fourierdes'; 
    b(k).options.show = 0;
    b(k).options.type = 1;
    b(k).options.Nfourierdes = 12;
end

if fxvar.gupta      == 1
    k = k + 1;
    b(k).name = 'gupta'; 
    b(k).options.show = 0;
    b(k).options.type = 1;
end

if fxvar.hugeo      == 1
    k = k + 1;
    b(k).name = 'hugeo'; 
    b(k).options.show = 0;
    b(k).options.type = 1;
end



if fxvar.basicint   == 1
    k = k + 1;
    b(k).name = 'basicint'; 
    b(k).options.show = 0;
    b(k).options.type = 2;
end
if fxvar.clp        == 1
    k = k + 1;
    b(k).name = 'clp'; 
    b(k).options.show = 0;
    b(k).options.ng = 32;
    b(k).options.type = 2;
end
if fxvar.contrast   == 1
    k = k + 1;
    b(k).name = 'contrast'; 
    b(k).options.show = 0;
    b(k).options.neighbor = 2;
    b(k).options.param = 5;
    b(k).options.type = 2;
end

if fxvar.fourier    == 1
    k = k + 1;
    b(k).name = 'fourier'; 
    b(k).options.show = 0;
    b(k).options.type = 2;
    b(k).options.Nfourier  = 64;                % imresize vertical
    b(k).options.Mfourier  = 64;                % imresize horizontal
    b(k).options.mfourier  = 2;                 % imresize frequency vertical
    b(k).options.nfourier  = 2;
end


if fxvar.gabor      == 1
    k = k + 1;
    b(k).name = 'gabor'; 
    b(k).options.show = 0;
    b(k).options.type = 2;
    b(k).options.Lgabor  = 8;                 % number of rotations
    b(k).options.Sgabor  = 8;                 % number of dilations (scale)
    b(k).options.fhgabor = 2;                 % highest frequency of interest
    b(k).options.flgabor = 0.1;               % lowest frequency of interest
    b(k).options.Mgabor  = 21;                % mask size
end
if fxvar.haralick   == 1
    k = k + 1;
    b(k).name = 'haralick'; 
    b(k).options.show = 0;
    b(k).options.type = 2;
    b(k).options.dharalick = 1:2:5;
end
if fxvar.huint      == 1
    k = k + 1;
    b(k).name = 'huint'; 
    b(k).options.show = 0;
    b(k).options.type = 2;
end

if strcmp(fxvar.segmentation,'None')==1
    opf.segmentation = 0;                       % segmentation
else
    opf.segmentation = fxvar.segmentation;                       % segmentation
    opf.param        = fxvar.parameters;
end

opf.b = b;
figure(1)
clf
[X,Xn,S] = Xfxtractor('','png',opf);
if fxvar.rotinv == 1
    [X,Xn] = Xnorotation(X,Xn);
end
if fxvar.trainv == 1
    [X,Xn] = Xnotranslation(X,Xn);
end
if fxvar.scainv == 1
    [X,Xn] = Xnoscale(X,Xn);
end

save Xfxdata X Xn S fxvar


% --- Executes on selection change in Format.
function Format_Callback(hObject, eventdata, handles)
% hObject    handle to Format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Format
global fxvar d n i
contents           = cellstr(get(hObject,'String'));
fxvar.fmt = contents{get(hObject,'Value')};

d = dir(['*.' fxvar.fmt]);
n = length(d);
i = 1;

ShowImage

% --- Executes during object creation, after setting all properties.
function Format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Parameters as text
%        str2double(get(hObject,'String')) returns contents of Parameters as a double
global fxvar
fxvar.parameters = str2double(get(hObject,'String'));
ShowImage

% --- Executes during object creation, after setting all properties.
function Parameters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BasicInt.
function BasicInt_Callback(hObject, eventdata, handles)
% hObject    handle to BasicInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BasicInt
global fxvar
fxvar.basicint = get(hObject,'Value');


% --- Executes on button press in CLP.
function CLP_Callback(hObject, eventdata, handles)
% hObject    handle to CLP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CLP
global fxvar
fxvar.clp = get(hObject,'Value');


% --- Executes on button press in Contrast.
function Contrast_Callback(hObject, eventdata, handles)
% hObject    handle to Contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Contrast
global fxvar
fxvar.contrast = get(hObject,'Value');


% --- Executes on button press in DCT.
function DCT_Callback(hObject, eventdata, handles)
% hObject    handle to DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DCT
global fxvar
fxvar.dct = get(hObject,'Value');


% --- Executes on button press in Fourier.
function Fourier_Callback(hObject, eventdata, handles)
% hObject    handle to Fourier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fourier
global fxvar
fxvar.fourier = get(hObject,'Value');


% --- Executes on button press in Gabor.
function Gabor_Callback(hObject, eventdata, handles)
% hObject    handle to Gabor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Gabor
global fxvar
fxvar.gabor = get(hObject,'Value');


% --- Executes on button press in Haralick.
function Haralick_Callback(hObject, eventdata, handles)
% hObject    handle to Haralick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Haralick
global fxvar
fxvar.haralick = get(hObject,'Value');


% --- Executes on button press in HuInt.
function HuInt_Callback(hObject, eventdata, handles)
% hObject    handle to HuInt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of HuInt
global fxvar
fxvar.huint = get(hObject,'Value');


% --- Executes on button press in RotInvariant.
function RotInvariant_Callback(hObject, eventdata, handles)
% hObject    handle to RotInvariant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RotInvariant
global fxvar
fxvar.rotinv = get(hObject,'Value');


% --- Executes on button press in TraInvariant.
function TraInvariant_Callback(hObject, eventdata, handles)
% hObject    handle to TraInvariant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TraInvariant
global fxvar
fxvar.trainv = get(hObject,'Value');


% --- Executes on button press in ScaleInvariant.
function ScaleInvariant_Callback(hObject, eventdata, handles)
% hObject    handle to ScaleInvariant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ScaleInvariant
global fxvar
fxvar.scainv = get(hObject,'Value');
