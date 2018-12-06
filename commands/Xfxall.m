% [X,Xn] = Xfxall(I,R,options)
% [X,Xn] = Xfxall(I,options)
%
% Toolbox Xvis
%    All pixels.
%
%    X is the features vector, Xn is the list feature names (see Example to
%    see how it works).
%
%
%   Example:
%      I = imread('testimg1.jpg');           % input image
%      [X,Xn] = Xfxall(I);                   % all pixels

function [X,Xn] = Xfxall(I,R,options)


X = I(:)';

Xn = zeros(length(X),24);
