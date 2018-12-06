function varargout = Xgdxbrowse(varargin)
% XGDXBROWSE MATLAB code for Xgdxbrowse.fig
%      XGDXBROWSE, by itself, creates a new XGDXBROWSE or raises the existing
%      singleton*.
%
%      H = XGDXBROWSE returns the handle to a new XGDXBROWSE or the handle to
%      the existing singleton*.
%
%      XGDXBROWSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XGDXBROWSE.M with the given input arguments.
%
%      XGDXBROWSE('Property','Value',...) creates a new XGDXBROWSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xgdxbrowse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xgdxbrowse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xgdxbrowse

% Last Modified by GUIDE v2.5 25-Feb-2015 09:58:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Xgdxbrowse_OpeningFcn, ...
                   'gui_OutputFcn',  @Xgdxbrowse_OutputFcn, ...
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


% --- Executes just before Xgdxbrowse is made visible.
function Xgdxbrowse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xgdxbrowse (see VARARGIN)

% Choose default command line output for Xgdxbrowse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Xgdxbrowse wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global group series image group_old series_old image_old GT map rainbow sinmap
group      = 1;
series     = 1;
image      = 1;
group_old  = 1;
series_old = 1;
image_old  = 1;
GT         = 0;
map        = 'gray';
warning('off', 'Images:initSize:adjustingMag');

w       = ones(3,1)*4*pi/3/255;
k       = 0.5*ones(3,1);
a       = 0.5*ones(3,1);
th      = [0 -2*pi/3 -4*pi/3];
rainbow = Xsincolormap(k,a,w,th);


w       = [1.25*pi/255 1.25*pi/255 1.25*pi/255]';
k       = ones(3,1);
a       = zeros(3,1);
th      = [pi/3 pi/2 -4*pi/3];
sinmap  = Xsincolormap(k,a,w,th);


ShowGDXImage;

function ShowGDXImage
global group series image group_old series_old image_old GT rainbow sinmap map
switch group
    case 0
        st = 'Castings';
        group = group_old;
    case 1
        st = 'Castings';
    case 2
        st = 'Welds';
    case 3
        st = 'Baggages';
    case 4 
        st = 'Nature';
    case 5
        st = 'Settings';
    case 6
        st = 'Settings';
        group = group_old;
end

st_gr = 'CWBNS';

I = Xloadimg(st_gr(group),series,image);
if length(I) == 1
   series = series_old;
   image  = image_old;
end
   
figure(1)
clf
if strcmp(map,'3D');
    xmap = '3D';
else
   eval(['xmap = ' map ';']); 
end
if GT==0
   X = Xloadimg(st_gr(group),series,image,1,xmap);
   % X = Xpseudocolor(I,xmap);
   
   %imshow(X);
   %title([st ': ' st_gr(group) sprintf('%04d',series) '\_'  sprintf('%04d',image) '.png' ]);
else
    XshowGT(st_gr(group),series,image,'ground_truth.txt','r',xmap);
    %if strcmp(map,'gray')==0
    %    disp('Warning: Ground truth is displayed only in grayscale colormap');
    %end
end
%title([st ': ' st_gr(group) sprintf('%04d',series) '\_'  sprintf('%04d',image) '.png' ]);
gdxdir = Xgdxdir(st_gr(group),series);
nimg = length(dir([gdxdir '*.png'])); % images in the series
st_series = [st_gr(group) sprintf('%04d',series)];
gdxdir(end-4:end)=[];nseries = length(dir([gdxdir '*']));
xlabel(sprintf('[ Group %s with %d series ]    [ Series %s with %d images ]',st,nseries,st_series,nimg));
group_old = group;
series_old = series;
image_old = image;



% --- Outputs from this function are returned to the command line.
function varargout = Xgdxbrowse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in PreviousGroup.
function PreviousGroup_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global group series image
group = group - 1;
series = 1;
image = 1;
ShowGDXImage


% --- Executes on button press in NextGroup.
function NextGroup_Callback(hObject, eventdata, handles)
% hObject    handle to NextGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global group series image
group = group + 1;
series = 1;
image = 1;
ShowGDXImage






% --- Executes on button press in NextSeries.
function NextSeries_Callback(hObject, eventdata, handles)
% hObject    handle to NextSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global series image
series = series + 1;
image = 1;
ShowGDXImage
% --- Executes on button press in PreviousSeries.
function PreviousSeries_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global series image
series = series - 1;
image = 1;
ShowGDXImage



% --- Executes on button press in PreviousImage.
function PreviousImage_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
image = image - 1;
ShowGDXImage


% --- Executes on button press in NextImage.
function NextImage_Callback(hObject, eventdata, handles)
% hObject    handle to NextImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
image = image + 1;
ShowGDXImage


% --- Executes on button press in GroundTruth.
function GroundTruth_Callback(hObject, eventdata, handles)
% hObject    handle to GroundTruth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GroundTruth
global GT
GT = get(hObject,'Value');
ShowGDXImage


% --- Executes on selection change in ColorMap.
function ColorMap_Callback(hObject, eventdata, handles)
% hObject    handle to ColorMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ColorMap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ColorMap

global map
contents = cellstr(get(hObject,'String'));
map = contents{get(hObject,'Value')};
ShowGDXImage

% --- Executes during object creation, after setting all properties.
function ColorMap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ColorMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
