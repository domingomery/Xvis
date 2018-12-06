% [X,Xn] = Xbasicint(I,R,options)
% [X,Xn] = Xbasicint(I,options)
%
% Toolbox Xvis: Basic intensity features
%
%    X is the features vector, Xn is the list feature names (see Example to
%    see how it works).
%
%   Example:
%      options.mask  = 5;                   % Gauss mask for gradient computation
%      options.show  = 1;                   % display results
%      I = imread('fruit.png');             % input image
%      R = Xsegbimodal(I);                  % segmentation
%      [X,Xn] = Xbasicint(I,R,options);     % basic intenisty features
%      Xprintfeatures(X,Xn)

function [X,Xn] = Xbasicint(I,R,options)

if nargin==2;
    options = R;
    R = ones(size(I));
end

if ~isfield(options,'mask')
   options.mask = 15;
end

if ~isfield(options,'show')
   options.show = 0;
end

if options.show
    disp('--- extracting basic intensity features...');
end


E = bwperim(R,4);

ii = find(R==1);
jj = find(R==0, 1);
kk = E==1;

I = double(I);

I1 = Bim_d1(I,options.mask);
I2 = Bim_d2(I);

if ~isempty(jj)
   C = mean(abs(I1(kk)));
else
   C = -1;
end


J = I(ii);

G  = mean(J);
S  = std(J);
K  = kurtosis(J);
Sk = skewness(J);
D  = mean(I2(ii));

X = [G S K Sk D C];

Xn = [ 'Intensity Mean          '
       'Intensity StdDev        '
       'Intensity Kurtosis      '
       'Intensity Skewness      '
       'Mean Laplacian          '
       'Mean Boundary Gradient  '];

