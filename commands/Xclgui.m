% Xclgui
%
% Toolbox Xvis
%
%    Graphic User Interface for feature extraction.
%
% (c) GRIMA-DCCUC, 2011
% http://grima.ing.puc.cl

function varargout = Xclgui(varargin)
% XCLGUI M-file for Xclgui.fig
%      XCLGUI, by itself, creates a new XCLGUI or raises the existing
%      singleton*.
%
%      H = XCLGUI returns the handle to a new XCLGUI or the handle to
%      the existing singleton*.
%
%      XCLGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XCLGUI.M with the given input arguments.
%
%      XCLGUI('Property','Value',...) creates a new XCLGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Xclgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Xclgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Xclgui

% Last Modified by GUIDE v2.5 07-Mar-2015 09:08:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Xclgui_OpeningFcn, ...
    'gui_OutputFcn',  @Xclgui_OutputFcn, ...
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


% --- Executes just before Xclgui is made visible.
function Xclgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Xclgui (see VARARGIN)

% Choose default command line output for Xclgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Xclgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

clc
disp('Balu 3.0: GUI for feature and classifier selection.')
disp(' ')
disp('This GUI will load data stored in current directory:')
cd
disp('Warning: not all features selection and classifier algorithm implemented');
disp('in Balu are in this GUI.');
disp(' ')
disp('Please define the feature selection and classifier processes in the GUI window,');
disp('and press [Go] when you finish.')
disp(' ')
xlabel('Number of features')
ylabel('Performance [%]');
s.dmin            = 0;
s.maha            = 0;
s.lda             = 0;
s.qda             = 0;
s.knn1            = 0;
s.knn3            = 0;
s.knn5            = 0;
s.knn9           = 0;
s.knn15           = 0;
s.mlplin           = 0;
s.mlplog         = 0;
s.svma            = 0;
s.mlpsoft            = 0;
s.svmc            = 0;
s.svmd            = 0;
s.svme            = 0;
s.pnn             = 0;
s.nnglma          = 0;
s.nnglmb          = 0;
s.nnglmc          = 0;
s.adaboost5       = 0;
s.adaboost10      = 0;
s.boosting025     = 0;
s.boosting050     = 0;
s.sfsfisher       = 0;
s.fmRMR          = 0;
s.rankroc            = 0;
s.frank           = 0;
s.sfsknn5         = 0;
s.sfslda          = 0;
s.sfsqda          = 0;
s.sfssvmlin       = 0;
s.sfslibsvmrbf    = 0;
s.sfsglma         = 0;
s.sfsmlpb        = 0;
s.allfeatures     = 0;
s.mmax            = 20;
s.crossvalfolders = 10;
s.filename        = '';
s.advanced        = 0;
axis([0 s.mmax 50 100])

save Xguidata s


% --- Outputs from this function are returned to the command line.
function varargout = Xclgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dmin.
function dmin_Callback(hObject, eventdata, handles)
% hObject    handle to dmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dmin
load Xguidata
s.dmin = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Minimal Distance Classifier = %s',offon(s.dmin+1,:)))


% --- Executes on button press in maha.
function maha_Callback(hObject, eventdata, handles)
% hObject    handle to maha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of maha
load Xguidata
s.maha = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Mahalanobis Distance Classifier = %s',offon(s.maha+1,:)))


% --- Executes on button press in lda.
function lda_Callback(hObject, eventdata, handles)
% hObject    handle to lda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lda
load Xguidata
s.lda = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Linear Discriminant Analysis Classifier = %s',offon(s.lda+1,:)))


% --- Executes on button press in qda.
function qda_Callback(hObject, eventdata, handles)
% hObject    handle to qda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of qda
load Xguidata
s.qda = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Quadratic Discriminant Analysis Classifier = %s',offon(s.qda+1,:)))


% --- Executes on button press in knn1.
function knn1_Callback(hObject, eventdata, handles)
% hObject    handle to knn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn1
load Xguidata
s.knn1 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Nearest Neighbours Classifier with 1 neighbor = %s',offon(s.knn1+1,:)))

% --- Executes on button press in knn3.
function knn3_Callback(hObject, eventdata, handles)
% hObject    handle to knn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn3
load Xguidata
s.knn3 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Nearest Neighbours Classifier with 3 neighbors = %s',offon(s.knn3+1,:)))


% --- Executes on button press in knn5.
function knn5_Callback(hObject, eventdata, handles)
% hObject    handle to knn5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn5
load Xguidata
s.knn5 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Nearest Neighbours Classifier with 5 neighbors = %s',offon(s.knn5+1,:)))


% --- Executes on button press in knn9.
function knn9_Callback(hObject, eventdata, handles)
% hObject    handle to knn9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn9
load Xguidata
s.knn9 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Nearest Neighbours Classifier with 9 neighbors = %s',offon(s.knn9+1,:)))


% --- Executes on button press in knn15.
function knn15_Callback(hObject, eventdata, handles)
% hObject    handle to knn15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn15
load Xguidata
s.knn15 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Nearest Neighbours Classifier with 15 neighbours = %s',offon(s.knn15+1,:)))


% --- Executes on button press in mlplin.
function mlplin_Callback(hObject, eventdata, handles)
% hObject    handle to mlplin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mlplin
load Xguidata
s.mlplin = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Neural Network MLP (linear method) = %s',offon(s.mlplin+1,:)))


% --- Executes on button press in svma.
function svma_Callback(hObject, eventdata, handles)
% hObject    handle to svma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svma
load Xguidata
s.svma = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Support Vector Machine with Linear kernel or dot product = %s',offon(s.svma+1,:)))



% --- Executes on button press in mlpsoft.
function mlpsoft_Callback(hObject, eventdata, handles)
% hObject    handle to mlpsoft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mlpsoft
load Xguidata
s.mlpsoft = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Neural Network MLP (softmax method) = %s',offon(s.mlpsoft+1,:)))



% --- Executes on button press in svmc.
function svmc_Callback(hObject, eventdata, handles)
% hObject    handle to svmc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svmc
load Xguidata
s.svmc = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Support Vector Machine with Polynomial kernel (order 3) = %s',offon(s.svmc+1,:)))


% --- Executes on button press in svmd.
function svmd_Callback(hObject, eventdata, handles)
% hObject    handle to svmd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svmd
load Xguidata
s.svmd = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Support Vector Machine with Gaussian Radial Basis Function kernel = %s',offon(s.svmd+1,:)))


% --- Executes on button press in svme.
function svme_Callback(hObject, eventdata, handles)
% hObject    handle to svme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of svme
load Xguidata
s.svme = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Support Vector Machine with sigmoid kernel = %s',offon(s.svme+1,:)))


% --- Executes on button press in pnn.
function pnn_Callback(hObject, eventdata, handles)
% hObject    handle to pnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pnn
load Xguidata
s.pnn = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Probabilistic Neural Network = %s',offon(s.pnn+1,:)))





% --- Executes on button press in nnglma.
function nnglma_Callback(hObject, eventdata, handles)
% hObject    handle to nnglma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nnglma
load Xguidata
s.nnglma = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Neural Network using a Generalized Linear Model (linear) = %s',offon(s.nnglma+1,:)))



% --- Executes on button press in nnglmb.
function nnglmb_Callback(hObject, eventdata, handles)
% hObject    handle to nnglmb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nnglmb
load Xguidata
s.nnglmb = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Neural Network using a Generalized Linear Model (logistic) = %s',offon(s.nnglmb+1,:)))


% --- Executes on button press in nnglmc.
function nnglmc_Callback(hObject, eventdata, handles)
% hObject    handle to nnglmc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nnglmc
load Xguidata
s.nnglmc = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Neural Network using a Generalized Linear Model (softmax) = %s',offon(s.nnglmc+1,:)))


% --- Executes on button press in adaboost5.
function adaboost5_Callback(hObject, eventdata, handles)
% hObject    handle to adaboost5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of adaboost5
load Xguidata
s.adaboost5 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Adaboost Classifier with 5 iterations = %s',offon(s.adaboost5+1,:)))


% --- Executes on button press in adaboost10.
function adaboost10_Callback(hObject, eventdata, handles)
% hObject    handle to adaboost10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of adaboost10
load Xguidata
s.adaboost10 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Adaboost Classifier with 10 iterations = %s',offon(s.adaboost10+1,:)))


% --- Executes on button press in boosting025.
function boosting025_Callback(hObject, eventdata, handles)
% hObject    handle to boosting025 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boosting025
load Xguidata
s.boosting025 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Boosting with 25%% of samples for first Classifier = %s',offon(s.boosting025+1,:)))

% --- Executes on button press in boosting050.
function boosting050_Callback(hObject, eventdata, handles)
% hObject    handle to boosting050 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boosting050
load Xguidata
s.boosting050 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Boosting with 50%% of samples for first Classifier = %s',offon(s.boosting050+1,:)))


% --- Executes on button press in sfsfisher.
function sfsfisher_Callback(hObject, eventdata, handles)
% hObject    handle to sfsfisher (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfsfisher
load Xguidata
s.sfsfisher = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with Fisher Criteria = %s',offon(s.sfsfisher+1,:)))


% --- Executes on button press in mRMR.
function mRMR_Callback(hObject, eventdata, handles)
% hObject    handle to mRMR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mRMR
load Xguidata
s.fmRMR = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using fmRMR = %s',offon(s.fmRMR+1,:)))


% --- Executes on button press in rankroc.
function rankroc_Callback(hObject, eventdata, handles)
% hObject    handle to rankroc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rankroc
load Xguidata
s.rankroc = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using Rank-roc = %s',offon(s.rankroc+1,:)))


% --- Executes on button press in rankttest.
function rankttest_Callback(hObject, eventdata, handles)
% hObject    handle to rankttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rankttest
load Xguidata
s.frank = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using Rank-ttest = %s',offon(s.frank+1,:)))


% % --- Executes on button press in sfsfisherpca.
% function sfsfisherpca_Callback(hObject, eventdata, handles)
% % hObject    handle to sfsfisherpca (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hint: get(hObject,'Value') returns toggle state of sfsfisherpca
% load Xguidata
% s.sfsfisherpca = get(hObject,'Value');
% save Xguidata s
% offon = ['off';'on '];
% disp(sprintf('Feature Selection from all features and PCA features using SFS with Fisher Criteria = %s',offon(s.sfsfisherpca+1,:)))


% --- Executes on button press in sfsknn5.
function sfsknn5_Callback(hObject, eventdata, handles)
% hObject    handle to sfsknn5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfsknn5
load Xguidata
s.sfsknn5 = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with KNN-5 Classifier = %s',offon(s.sfsknn5+1,:)))


% --- Executes on button press in sfslda.
function sfslda_Callback(hObject, eventdata, handles)
% hObject    handle to sfslda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfslda
load Xguidata
s.sfslda = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with LDA Classifier = %s',offon(s.sfslda+1,:)))


% --- Executes on button press in sfsqda.
function sfsqda_Callback(hObject, eventdata, handles)
% hObject    handle to sfsqda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfsqda
load Xguidata
s.sfsqda = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with QDA Classifier = %s',offon(s.sfsqda+1,:)))


% --- Executes on button press in sfssvmlin.
function sfssvmlin_Callback(hObject, eventdata, handles)
% hObject    handle to sfssvmlin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfssvmlin
load Xguidata
s.sfssvmlin = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with SVM-lin Classifier = %s',offon(s.sfssvmlin+1,:)))


% --- Executes on button press in go.
function go_Callback(hObject, eventdata, handles)
% hObject    handle to go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Xguidata
ok = 1;

if s.advanced == 0
    
    fclas = s.dmin         +...
        s.maha         +...
        s.lda          +...
        s.qda          +...
        s.knn1         +...
        s.knn3         +...
        s.knn5         +...
        s.knn9        +...
        s.knn15        +...
        s.mlplin        +...
        s.mlplog      +...
        s.svma         +...
        s.mlpsoft         +...
        s.svmc         +...
        s.svmd         +...
        s.svme         +...
        s.pnn          +...
        s.nnglma       +...
        s.nnglmb       +...
        s.nnglmc       +...
        s.adaboost5    +...
        s.adaboost10   +...
        s.boosting025  +...
        s.boosting050;
    
    ffsel = s.sfsfisher    +...
        s.fmRMR       +...
        s.rankroc         +...
        s.frank        +...
        s.sfsknn5      +...
        s.sfslda       +...
        s.sfsqda       +...
        s.sfslibsvmrbf +...
        s.sfssvmlin    +...
        s.sfsglma      +...
        s.sfsmlpb     +...
        s.allfeatures;
    
    
    
    
    if ffsel==0
        beep
        wwarndlg('You must set at least one feature selector.','Error in Xclgui');
        ok = 0;
    end
    if fclas==0
        beep
        wwarndlg('You must set at least one classifier.','Error in Xclgui');
        ok = 0;
    end
end
if s.mmax<1
    beep
    wwarndlg('Invalid maximal number of features to be selected.','Error in Xclgui');
    ok = 0;
end
if s.crossvalfolders<1
    beep
    wwarndlg('Invalid cros validations folders.','Error in Xclgui');
    ok = 0;
end

if exist(s.filename,'file')==0
    beep
    wwarndlg(sprintf('.mat file %s is not defined.',s.filename),'Error in Xclgui');
    ok = 0;
end



if ok
    yesnoans = questdlg('Xclgui will start to find the best classification. This process could take several minutes. Are you sure?', ...
        'Bfex Information', ...
        'Yes', 'No', 'No');
    if yesnoans(1)=='Y'
        eval(['load ' s.filename]);
        set(handles.Result1, 'String', ' ');
        set(handles.Result2, 'String', ' ');
        pause(0)
        if not(exist('fn','var'))
            fn = [];
        end
    if exist('f','var')
        XX = f;
        Xn = fn
    end
    if exist('X','var')
        XX = X;
    end
    
    if exist('Xtrain','var')
        XX = [Xtrain; Xtest];
        d  = [dtrain; dtest];
    end
        
        Xguifun(s,XX,Xn,d,handles);
        questdlg(sprintf('Xclgui ended successfully.'),'Xclgui Information','Ok', 'Ok');
    end
end


function mmax_Callback(hObject, eventdata, handles)
% hObject    handle to mmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mmax as text
%        str2double(get(hObject,'String')) returns contents of mmax as a double
load Xguidata
s.mmax = str2num(get(hObject,'String'));
save Xguidata s
disp(sprintf('Maximal Number of Features to be selected = %d ',s.mmax))


% --- Executes during object creation, after setting all properties.
function mmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sfsmlp.
function sfsmlp_Callback(hObject, eventdata, handles)
% hObject    handle to sfsmlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfsmlp
load Xguidata
s.sfsmlpb = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with MLP-Logistic Classifier = %s',offon(s.sfsmlpb+1,:)))


% --- Executes on button press in allfeatures.
function allfeatures_Callback(hObject, eventdata, handles)
% hObject    handle to allfeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allfeatures
load Xguidata
s.allfeatures = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('All features = %s',offon(s.allfeatures+1,:)))


% --- Executes on button press in ensvote.
function ensvote_Callback(hObject, eventdata, handles)
% hObject    handle to ensvote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ensvote
load Xguidata
s.ensvote = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Ensamble using majority vote = %s',offon(s.ensvote+1,:)))


% % --- Executes on button press in ensindividual.
% function ensindividual_Callback(hObject, eventdata, handles)
% % hObject    handle to ensindividual (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hint: get(hObject,'Value') returns toggle state of ensindividual
% load Xguidata
% s.ensindividual = get(hObject,'Value');
% save Xguidata s
% offon = ['off';'on '];
% disp(sprintf('Individual Classifiers = %s',offon(s.ensindividual+1,:)))
%


function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double
load Xguidata
s.filename = get(hObject,'String');
save Xguidata s
disp(sprintf('MAT filename = %s',s.filename))



% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in select_filename.
function select_filename_Callback(hObject, eventdata, handles)
% hObject    handle to select_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d = dir('*.mat');
str = {d.name};
[ss,vv] = listdlg('PromptString','Select a file:',...
    'SelectionMode','single',...
    'ListString',str);
if vv
    load Xguidata
    fstr = d(ss,:).name;
    s.filename = fstr;
    save Xguidata s
    disp(sprintf('MAT filename = %s',s.filename))
    load(s.filename)
    disp('Features:')
    if exist('f','var')
        XX = f;
        Xn = fn
    end
    if exist('X','var')
        XX = X;
    end
    
    if exist('Xtrain','var')
        XX = [Xtrain; Xtest];
        d  = [dtrain; dtest];
    end
    
    howis(XX)
    disp('Classes:')
    howis(d)
end
set(handles.printfilename, 'String', fstr);




function CrossValFolders_Callback(hObject, eventdata, handles)
% hObject    handle to CrossValFolders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CrossValFolders as text
%        str2double(get(hObject,'String')) returns contents of CrossValFolders as a double
load Xguidata
s.crossvalfolders = str2num(get(hObject,'String'));
save Xguidata s
disp(sprintf('Number of folders in Cross Validation = %d ',s.crossvalfolders))


% --- Executes during object creation, after setting all properties.
function CrossValFolders_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CrossValFolders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sfsglm.
function sfsglm_Callback(hObject, eventdata, handles)
% hObject    handle to sfsglm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfsglm
load Xguidata
s.sfsglma = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature selection using SFS with GLM-1 = %s',offon(s.sfsglma+1,:)))


function [bcs,selec] = Xguifun(s,XX,Xn,d,handles)
% s structur with classifier and feature selector definition (see Xclgui.m)
% XX features
% d ideal classification

if s.advanced == 0
    
    % Classifier defintion
    
    k = 0;
    if s.dmin
        k=k+1;
        bcl(k).name = 'dmin';
        bcl(k).options = [];
    end
    
    if s.maha
        k=k+1;
        bcl(k).name = 'maha';
        bcl(k).options = [];
    end
    
    if s.lda
        k=k+1;
        bcl(k).name = 'lda';
        bcl(k).options.p = [];
    end
    
    if s.qda
        k=k+1;
        bcl(k).name = 'qda';
        bcl(k).options.p = [];
    end
    
    if s.knn1
        k=k+1;
        bcl(k).name = 'knn';
        bcl(k).options.k = 1;
    end
    
    if s.knn3
        k=k+1;
        bcl(k).name = 'knn';
        bcl(k).options.k = 3;
    end
    
    if s.knn5
        k=k+1;
        bcl(k).name = 'knn';
        bcl(k).options.k = 5;
    end
    
    if s.knn9
        k=k+1;
        bcl(k).name = 'knn';
        bcl(k).options.k = 9;
    end
    
    if s.knn15
        k=k+1;
        bcl(k).name = 'knn';
        bcl(k).options.k = 15;
    end
    
    if s.mlplin
        k=k+1;
        bcl(k).name = 'mlp';
        bcl(k).options.method = 1;                       % 'logistic'
        bcl(k).options.iter = 12;                        % number of iterations
        bcl(k).options.nhidden = 6;                      % number of hidden units
        bcl(k).options.ncycles = 60;                     % Number of training cycles
        bcl(k).options.alpha = 0.2;                      % Weight decay    end
    end
    
    if s.mlplog
        k=k+1;
        bcl(k).name = 'mlp';
        bcl(k).options.method = 2;                       % 'logistic'
        bcl(k).options.iter = 12;                        % number of iterations
        bcl(k).options.nhidden = 6;                      % number of hidden units
        bcl(k).options.ncycles = 60;                     % Number of training cycles
        bcl(k).options.alpha = 0.2;                      % Weight decay    end
    end
    
    if s.mlpsoft
        k=k+1;
        bcl(k).name = 'mlp';
        bcl(k).options.method = 3;                       % 'logistic'
        bcl(k).options.iter = 12;                        % number of iterations
        bcl(k).options.nhidden = 6;                      % number of hidden units
        bcl(k).options.ncycles = 60;                     % Number of training cycles
        bcl(k).options.alpha = 0.2;                      % Weight decay    end
    end
    
    
    if s.svma
        k=k+1;
        bcl(k).name = 'svmplus';
        bcl(k).options.kernel = '-t 0';
    end
        
    if s.svmc
        k=k+1;
        bcl(k).name = 'svmplus';
        bcl(k).options.kernel = '-t 1';
    end
    
    if s.svmd
        k=k+1;
        bcl(k).name = 'svmplus';
        bcl(k).options.kernel = '-t 2';
    end
    
    if s.svme
        k=k+1;
        bcl(k).name = 'svmplus';
        bcl(k).options.kernel = '-t 3';
    end
    
    if s.pnn
        k=k+1;
        bcl(k).name = 'pnn';
        bcl(k).options = [];
    end
    
    if s.nnglma
        k=k+1;
        bcl(k).name = 'glm';
        bcl(k).options.method = 1;
        bcl(k).options.iter   = 12;
    end
    
    if s.nnglmb
        k=k+1;
        bcl(k).name = 'glm';
        bcl(k).options.method = 2;
        bcl(k).options.iter   = 12;
    end
    
    if s.nnglmc
        k=k+1;
        bcl(k).name = 'glm';
        bcl(k).options.method = 3;
        bcl(k).options.iter   = 12;
    end
    
    if s.adaboost5
        k=k+1;
        bcl(k).name = 'adaboost';
        bcl(k).options.iter   =5;
    end
    
    if s.adaboost10
        k=k+1;
        bcl(k).name = 'adaboost';
        bcl(k).options.iter   =10;
    end
    
    if s.boosting025
        k=k+1;
        bcl(k).name = 'boosting';
        bcl(k).options.s  =0.25;
    end
    
    if s.boosting050
        k=k+1;
        bcl(k).name = 'boosting';
        bcl(k).options.s  =0.5;
    end
    
    % Feature selection definition
    k = 0;
    if s.sfsfisher
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'fisher';
    end
    
    if s.fmRMR
        k=k+1;
        bfs(k).name = 'fmRMR';
    end
    
    if s.rankroc
        k=k+1;
        bfs(k).name = 'frank';
        bfs(k).options.criterion = 'roc';
    end
    
    if s.frank
        k=k+1;
        bfs(k).name = 'frank';
        bfs(k).options.criterion = 'ttest';
    end
    
    
    if s.sfslda
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'lda';
        bfs(k).options.b.options.p = [];
    end
    
    if s.sfsqda
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'qda';
        bfs(k).options.b.options.p = [];
    end
    
    if s.sfsknn5
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'knn';
        bfs(k).options.b.options.k = 5;
        
    end
    
    if s.sfslibsvmrbf
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'svmplus';
        bfs(k).options.b.options.kernel = '-t 2';
    end
    
    if s.sfssvmlin
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'svmplus';
        bfs(k).options.b.options.kernel = '-t 0';
    end
    
    if s.sfsglma
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'glm';
        bfs(k).options.b.options.method = 1;
        bfs(k).options.b.options.iter   = 10;
    end
    
    if s.sfsmlpb
        k=k+1;
        bfs(k).name = 'sfs';
        bfs(k).options.b.name = 'mlp';
        bfs(k).options.b.options.method = 2;                       % 'logistic'
        bfs(k).options.b.options.iter = 12;                        % number of iterations
        bfs(k).options.b.options.nhidden = 6;                      % number of hidden units
        bfs(k).options.b.options.ncycles = 60;                     % Number of training cycles
        bfs(k).options.b.options.alpha = 0.2;                      % Weight decay    end
    end
    if s.allfeatures
        k=k+1;
        bfs(k).name = 'fsall';
    end
else
    [bfs,bcl] = feval(s.advanced);
end



m = min(s.mmax,size(XX,2));

options.Xn  = Xn;
options.bcl = bcl;
options.bfs = bfs;
options.p   = m;
options.opcv.v   = s.crossvalfolders;
options.opcv.p = 0.95;
options.opcv.show = 0;
options.opcv.strat = 1;

[bcs,selec,acc] = Xclsearch(XX,d,bcl,bfs,options);

axis([0 length(selec)+1 50 100])
s1 = sprintf('Feature Selector: %s                            ',bcs.fs_method);
s2 = sprintf('Features: %d                                      ',length(selec));
s3 = sprintf('Classifier: %s                                    ',bcs.options.string);
s4 = sprintf('Accuracy: %5.2f%%                                 ',acc*100);

ns = 30;
strper1 = sprintf('%s\n%s',s1(1:ns),s2(1:ns));
set(handles.Result1, 'String', strper1);

strper2 = sprintf('%s\n%s',s3(1:ns),s4(1:ns));
set(handles.Result2, 'String', strper2);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

d = dir('B*.m');
str = {d.name};
[ss,vv] = listdlg('PromptString','Select a file:',...
    'SelectionMode','single',...
    'ListString',str);
if vv
    load Xguidata
    fstr = d(ss,:).name;
    s.advanced = fstr(1:end-2);
    save Xguidata s
    disp(sprintf('m filename = %s.m',s.advanced))
    [bfs,bcl] = feval(s.advanced);
    disp('Feature Extraction Models:')
    for i=1:length(bfs)
        fprintf(' %2d) %s-type\n',i,bfs(i).name);
    end
    disp(' ');
    disp('Classifier Models:')
    for i=1:length(bcl)
        fprintf(' %2d) %s-type\n',i,bcl(i).name);
    end
end
set(handles.text8, 'String', fstr);


% --- Executes on button press in mlplog.
function mlplog_Callback(hObject, eventdata, handles)
% hObject    handle to mlplog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mlplog

load Xguidata
s.mlplog = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Neural Network MLP (logistic method) = %s',offon(s.mlplog+1,:)))





% --- Executes on button press in sfssvmrbf.
function sfssvmrbf_Callback(hObject, eventdata, handles)
% hObject    handle to sfssvmrbf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sfssvmrbf
load Xguidata
s.sfslibsvmrbf = get(hObject,'Value');
save Xguidata s
offon = ['off';'on '];
disp(sprintf('Feature Selection using SFS with SVM-RBF Classifier = %s',offon(s.sfslibsvmrbf+1,:)))
