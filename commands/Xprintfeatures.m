% Xprintfeatures(X)       % for feature values only
% Xprintfeatures(X,Xn)    % for features with feature names
% Xprintfeatures(X,Xn,Xu) % for features with feature names and units
%
% Toolbox Xvis; Display extracted features.
%    Xn: feature names  (matrix mxp, one row per each string of p
%        characters)
%    X:  feature values (vector 1xm for m features)
%    Xu: feature units  (matrix mxq, one row per each string of q
%        characters)
%
%    The output of Xprintfeatures is like this:
%
%    1 center of grav i       [pixels]         163.297106
%    2 center of grav j       [pixels]         179.841850
%    3 Height                 [pixels]         194.000000
%    4 Width                  [pixels]         196.000000
%    5 Area                   [pixels]         29361.375000
%    :         :           :                  :
%
%   Example: Display of Flusser features of fruit.png
%      I = imread('fruit.png'); % input image
%      R = Xsegbimodal(I);      % segmentation
%      [X,Xn] = Xflusser(R);    % Flusser features
%      Xprintfeatures(X,Xn)                 
%
%   See also Xplotfeatures.

function Xprintfeatures(X,Xn)
N = length(X);
if ~exist('Xn','var')
    Xn = char(zeros(N,16));
end
for k=1:size(Xn,1)
    fprintf('%3d %s %f\n',k,Xn(k,:),X(k));
end    
