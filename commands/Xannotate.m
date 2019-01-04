function varargout = Xannotate(varargin)
% XANNOTATE MATLAB code for Xannotate.fig
%      XANNOTATE, by itself, creates a new XANNOTATE or raises the existing
%      singleton*.
%
%      H = XANNOTATE returns the handle to a new XANNOTATE or the handle to
%      the existing singleton*.
%
%      XANNOTATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XANNOTATE.M with the given input arguments.
%
%      XANNOTATE('Property','Value',...) creates a new XANNOTATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xannotate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xannotate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xannotate

% Last Modified by GUIDE v2.5 10-Feb-2015 12:47:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Xannotate_OpeningFcn, ...
    'gui_OutputFcn',  @Xannotate_OutputFcn, ...
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


% --- Executes just before Xannotate is made visible.
function Xannotate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xannotate (see VARARGIN)

% Choose default command line output for Xannotate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global d k n bb I
d = dir('*.png');
k = 1;
bb = [];
n = length(d);

if n==0
    error('There is no image in this folder.');
end

I = imread(d(1).name);
Xannotate_showimg();

% UIWAIT makes Xannotate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function Xannotate_showimg
global d k n bb I
figure(1)
clf
imshow(I)
s = sprintf('Image %d/%d %s (0 bounding boxes)',k,n,d(k).name);
j = strfind(s,'_');
st = [s(1:j-1) '\' s(j:end)];
title(st);

hold on
if ~isempty(bb)
    kk = find(bb(:,1)==k);
    nk = length(kk);
    % title(sprintf('Image %d/%d: %s (%d bounding boxes)',k,n,d(k).name,nk));
    title(st);
    if nk>0
        for i=1:nk
            t = bb(kk(i),2:end);
            plot(t([1 2 2 1 1]),t([3 3 4 4  3]),'r');
        end
    end
end




% --- Outputs from this function are returned to the command line.
function varargout = Xannotate_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
global bb
varargout{1} = bb;


% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
% hObject    handle to Previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d k n bb I
if k>1
    k = k-1;
    I = imread(d(k).name);
    Xannotate_showimg();
else
    beep;
end

% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d k n bb I
if k<n
    k = k+1;
    I = imread(d(k).name);
    Xannotate_showimg();
else
    beep;
end


% --- Executes on button press in New.
function New_Callback(hObject, eventdata, handles)
% hObject    handle to New (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d k n bb I

disp('Select top corner of bounding box...')
figure(1)
p = ginput(1);
i1 = p(1,2); j1 = p(1,1);                                  % coordinates of first corner
% [j1,i1] = ginputc(1,'Color','r');
plot(j1,i1,'r+')
disp('Select bottom corner of bounding box...')
p = ginput(1);
i2 = p(1,2); j2 = p(1,1);                                  % coordinates of second corner
% [j2,i2] = ginputc(1,'Color','r');
if i1>i2
    s = i1;
    i1 = i2;
    i2 = s;
end
if j1>j2
    s = j1;
    j1 = j2;
    j2 = s;
end
bb = [bb;k j1 j2 i1 i2];
Xannotate_showimg();


% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d k n bb I
kk = find(bb(:,1)==k);
nk = length(kk);
if nk>0
    bb(kk(end),:) = [];
end
Xannotate_showimg();


% --- Executes on button press in End.
function End_Callback(hObject, eventdata, handles)
% hObject    handle to End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global d k n bb I

ok = 0;
while not(ok)
    reply = input('Are you sure? Y/N: ','s');
    if or(upper(reply)=='Y',upper(reply)=='N')
        ok = 1;
    else
        disp('Type Y or N...'); beep
    end
end

if upper(reply)=='Y'
    
    
    if ~isempty(bb)
        kk = bb(:,1);
        [ii,jj] = sort(kk);
        bb = bb(jj,:);
    end
    disp('Bounding Boxes saved to BoundingBox.mat.');
    save BoundingBox bb
    close all
    ok = 0;
    while not(ok)
        reply = input('Do you want to save Bounding Boxes to ASCII file? Y/N: ','s');
        if or(upper(reply)=='Y',upper(reply)=='N')
            ok = 1;
        else
            disp('Type Y or N...'); beep
        end
    end
    if upper(reply)=='Y'
        GTfile = input('ASCII file: ','s');
        save(GTfile,'-ASCII','bb')
    end
end
return