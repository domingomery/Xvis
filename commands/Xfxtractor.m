% [X,Xn,S] = Xfxtractor(f,opf)               % gemetric and intensity features
%
% Toolbox Xvis: Feature extraction from a set of files.
%
%    This function calls feature extraction procedures of all
%    images defined in f. See example to see how it works.
%
%    X is the feature matrix (one feature per column, one sample per row),
%    Xn is the list of feature names (see Example to see how it works).
%
%    S is the list of filenames of the images. The features of file S(i,:)
%    are in row X(i,:).
%
% Example:
%    dir_name = Xgdxdir('B',49);
%    fmt      = 'png';
%    opf.b = Xfxbuild({'basicint','hugeo','flusser','fourierdes'});
%    opf.segmentation = 'Xsegbimodal';                       % segmentation
%    opf.param        = -0.05;                               % parameters of segmentation
%    opf.intensity    = 1;
%    [X,Xn,S] = Xfxtractor(dir_name,fmt,opf);

function [X,Xn,S] = Xfxtractor(dir_name,fmt,opf)


d = dir([dir_name '*.' fmt]);

m = length(d);

if m == 0
    error('Xfextractor: set of images is empty.')
end


if ~isfield(opf,'show')
    show = 1;
else
    show = opf.show;
end



if isfield(opf,'segmentation')
    doseg = 1;
    seg = opf.segmentation;
    if opf.segmentation == 0
        doseg = 0;
    end
else
    doseg = 0;
end



n = length(opf.b);
kg = 0;
ki = 0;
opg = [];
opi = [];
for i=1:n
    if opf.b(i).options.type == 1
        kg = kg+1;
        opg.b(kg) = opf.b(i);
    else
        ki = ki+1;
        opi.b(ki) = opf.b(i);
    end
end


X = [];
S = [];

if doseg
    if isfield(opf,'param')
        par = opf.param;
    else
        par = [];
    end
end

if isfield(opf,'intensity')
    inten = opf.intensity;
else
    inten = doseg;
end

ff = statusbar('Feature Extraction');
for i=1:m
    ff = statusbar(i/m,ff);
    Xi = [];
    Xn = [];
    st = [dir_name d(i).name];
    I = imread(st);
    if show==1
    imshow(I(:,:,1),[])
    end
    P = size(I,3);
    if P==3
        I = rgb2gray(I);
    end
    
    fprintf('\n--- processing image %s...\n',st);
    if doseg
        if ~isempty(par)
            Rg = feval(seg,I,par);
        else
            Rg = feval(seg,I);
        end
    else
        Rg = [];
    end
    if inten
        Ri = Rg;
    else
        Ri = [];
    end
    if ~isempty(opg)
        if ~isempty(opg.b)
            [Xgeo,Xng] = Xfxgeo(Rg,opg);
            Xi = [Xi Xgeo];
            Xn = [Xn;Xng];
        end
    end
    if ~isempty(opi)
        if ~isempty(opi.b)
            [Xint,Xni] = Xfxint(I,Ri,opi);
            Xi = [Xi Xint];
            Xn = [Xn;Xni];
        end
    end
    X = [X;Xi];
    st = [st ones(1,200)*' '];
    S = [S;st(1:100)];
end
delete(ff);
