% bf = Xfxbuild({'all'})
% bf = Xfxbuild({'allgeo'})
% bf = Xfxbuild({'allint'})
% bf = Xfxbuild({'haralick','lbp'})
%
% Toolbox Xvis
%    Build structure for feature extraction with default values
%
% Posible geometric names:
% 'basicgeo',
% 'fitellipse',
% 'fourierdes',
% 'hugeo',
% 'flusser',
% 'gupta',
%
% Posible intenisty names:
% 'basicint',
% 'contrast',
% 'haralick',
% 'lbp',
% 'lbps',
% 'dct',
% 'fourier',
% 'gabor',
% 'huint'
%
% Posible family names:
% 'all'
% 'allgeo'
% 'allint'
%
% Example:
%       options.b = Xfxbuild({'haralick','gabor'});
%       I = imread('fruit.png');                             % input image
%       R = Xsegbimodal(I);                                  % segmentation
%       [X,Xn] = Xfxint(I,R,options);                        % intensity features
%       Xprintfeatures(X,Xn)

function bfx = Xfxbuild(varargin)

v = varargin;
n = nargin;
%if compare(class(v),'cell')==0
if iscell(v)
    v = v{1};
    n = length(v);
end
    


if n==1
%    if compare(char(v(1)),'all')==0
    if strcmp(char(v(1)),'all')==1
        v = {'basicgeo','fitellipse','fourierdes','hugeo','flusser','gupta','basicint','contrast','haralick','lbp','lbps','dct','fourier','gabor','huint'};
    end
%    if compare(char(v(1)),'allgeo')==0
    if strcmp(char(v(1)),'allgeo')==1
        v = {'basicgeo','fitellipse','fourierdes','hugeo','flusser','gupta'};
    end
%    if compare(char(v(1)),'allint')==0
    if strcmp(char(v(1)),'allint')==1
        v = {'basicint','contrast','haralick','lbp','lbps','dct','fourier','gabor','huint'};
    end
end

n = length(v);

if n==0
    bfx = [];
else
    bfx(n).name =' ';
    for k=1:n
        s = char(v(k));
        bfx(k).name = s;
        switch lower(s)
            
            % GEOMETRIC FEATURE EXTRACTION DEFINTION
            case 'basicgeo';                       % basic geometric features
                bfx(k).options.type        = 1;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'fitellipse';                     % elliptic features
                bfx(k).options.type        = 1;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'fourierdes';                     % Fourier descriptors
                bfx(k).options.Nfourierdes = 16;   % number of descriptors
                bfx(k).options.type        = 1;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'hugeo';                          % Hu moments
                bfx(k).options.type        = 1;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case  'flusser';                       % Flusser moments
                bfx(k).options.type        = 1;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case  'gupta';                         % Gupta moments
                bfx(k).options.type        = 1;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            % INTENSITY FEATURE EXTRACTION DEFINTION
            case 'basicint';                       % basic intensity features
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'contrast';                       % contrast features
                bfx(k).options.neighbor    = 2;    % neigborhood is imdilate
                bfx(k).options.param       = 5;    % with 5x5 mask
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'clp';                            % crossing line profile (CLP)
                bfx(k).options.ng          = 32;   % mask
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results

            case 'haralick';                       % statistical texture features
                bfx(k).options.dharalick   = 1:7;  % for 1, 2, ... 7 pixels
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'lbp';                            % local binary batterns (LBP)
                bfx(k).options.vdiv        = 1;    % one vertical divition
                bfx(k).options.hdiv        = 1;    % one horizontal divition
                bfx(k).options.samples     = 8;    % number of neighbor samples
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'lbpri';                            % local binary batterns (LBP)
                bfx(k).name = 'lbp';
                bfx(k).options.vdiv        = 1;    % one vertical divition
                bfx(k).options.hdiv        = 1;    % one horizontal divition
                bfx(k).options.samples     = 8;    % number of neighbor samples
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                bfx(k).options.mappingtype = 'ri'; % rotation invariant
                
            case 'lbps';                           % semantic LBP
                bfx(k).name = 'lbp';
                bfx(k).options.vdiv        = 1;    % one vertical divition
                bfx(k).options.hdiv        = 1;    % one horizontal divition
                bfx(k).options.semantic    = 1;    % semantic LBP
                bfx(k).options.samples     = 8;    % number of neighbor samples
                bfx(k).options.sk          = 0.5;  % angle sampling
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'lbpw';                           % weighted semantic LBP
                bfx(k).name = 'lbp';
                bfx(k).options.vdiv        = 1;    % one vertical divition
                bfx(k).options.hdiv        = 1;    % one horizontal divition
                bfx(k).options.semantic    = 0;    % semantic LBP
                bfx(k).options.weight      = 9;    % semantic LBP
                bfx(k).options.samples     = 8;    % number of neighbor samples
                bfx(k).options.sk          = 0.5;  % angle sampling
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case {'lbpws','lbpsw'};                          % weighted & semantic LBP
                bfx(k).name = 'lbp';
                bfx(k).options.vdiv        = 1;    % one vertical divition
                bfx(k).options.hdiv        = 1;    % one horizontal divition
                bfx(k).options.semantic    = 1;    % semantic LBP
                bfx(k).options.weight      = 9;    % semantic LBP
                bfx(k).options.samples     = 8;    % number of neighbor samples
                bfx(k).options.sk          = 0.5;  % angle sampling
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results

            case 'dct';                            % Discrete Cosinus Transform
                bfx(k).options.Ndct        = 64;   % imresize vertical
                bfx(k).options.Mdct        = 64;   % imresize horizontal
                bfx(k).options.mdct        = 4;    % imresize frequency vertical
                bfx(k).options.ndct        = 4;    % imresize frequency horizontal
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'fourier';                        % Discrete Fourier Transform
                bfx(k).options.Nfourier    = 64;   % imresize vertical
                bfx(k).options.Mfourier    = 64;   % imresize horizontal
                bfx(k).options.mfourier    = 4;    % imresize frequency vertical
                bfx(k).options.nfourier    = 4;    % imresize frequency horizontal
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'gabor';                          % Gabor features
                bfx(k).options.Lgabor      = 8;    % number of rotations
                bfx(k).options.Sgabor      = 8;    % number of dilations (scale)
                bfx(k).options.fhgabor     = 2;    % highest frequency of interest
                bfx(k).options.flgabor     = 0.1;  % lowest frequency of interest
                bfx(k).options.Mgabor      = 21;   % mask size
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            case 'huint';                          % Hu-moments with intensity
                bfx(k).options.type        = 2;    % 1 geometric 2 intensity
                bfx(k).options.show        = 0;    % do not display results
                
            otherwise
                error('Xfxbuild does not recognize %s as feature extraction method.',s)
                
        end
    end
end