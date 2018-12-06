% [X,Xn] = Xfxint(I,R,b)
%
% Toolbox Xvis: Intensity feature extraction.
%
%    This function calls intensity feature extraction procedures of image I
%    according binary image R. See example to see how it works.
%
%    X is the feature matrix (one feature per column, one sample per row),
%    Xn is the list of feature names (see Examples to see how it works).
%
%   Example 1: Extraction of one region image in grayvalue images
%      b(1).name = 'gabor';       b(1).options.show=1;         % Gabor features
%                                 b(1).options.Lgabor  = 8;    % number of rotations
%                                 b(1).options.Sgabor  = 8;    % number of dilations (scale)
%                                 b(1).options.fhgabor = 2;    % highest frequency of interest
%                                 b(1).options.flgabor = 0.1;  % lowest frequency of interest
%                                 b(1).options.Mgabor  = 21;   % mask size
%      b(2).name = 'basicint';    b(2).options.show=1;         % Basic intensity features
%      b(3).name = 'haralick';    b(3).options.show=1;         % Haralick
%                                 b(3).options.dharalick = 3;  % 3 pixels distance for co-ocurrence
%      options.b = b;
%      I = imread('fruit.png');                                % input image
%      R = Xsegbimodal(I);                                     % segmentation
%      [X,Xn] = Xfxint(I,R,options);                           % intensity features
%      Xprintfeatures(X,Xn)
%
%   Example 2: Extraction of multiple regions image
%      b(1).name = 'huint';       b(1).options.show=1;         % Hu moments
%      b(2).name = 'basicint';    b(2).options.show=1;         % Basic intensity features
%      b(3).name = 'lbp';         b(3).options.show=1;         % LBP
%                                 b(3).options.vdiv = 2;       % vertical div
%                                 b(3).options.hdiv = 2;       % horizontal div
%      b(4).name = 'contrast';    b(4).options.show = 1;       % Contrast
%                                 b(4).options.neighbor = 1;   % neighborhood is a window
%                                 b(4).options.param = 1.5;    % 1.5 height x 1.5 width
%      options.b = b;
%      I = Xloadimg('N',5,1);                                  % input image
%      R = I>50;
%      [L,m] = bwlabel(R);
%      [X,Xn] = Xfxint(I,L,options);                           % intensity features
%      i = input('Region?');
%      imshow(L==i);
%      Xprintfeatures(X(i,:),Xn)

function [X,Xn] = Xfxint(I,R,options)


[N,M,P] = size(I);

if P==3
    I = rgb2gray(I);
end

I = double(I);

c = size(I,3);


if nargin==2;
    options = R;
    R = ones(size(I));
end

if isempty(R)
    R = ones(N,M);
end

b    = options.b;

n  = length(b);
m  = int16(max(R(:)));
X  = [];
Xn = [];
for j=1:m
    Rj = R==j;
    Xj = [];
    if j==1
        Xn = [];
    end
    for i=1:n
        s = b(i).name;
            if s(1)~='X'
            s = ['X' s];
        end
        if  ~exist(s,'file')
            error('Xfxint: function %s does not exist.',b(i).name)
        end
            [Xi,Xni] = feval(s,I,Rj,b(i).options);
            Xj = [Xj Xi];
            Xn = [Xn; Xni];
    end
    X = [X;Xj];
end