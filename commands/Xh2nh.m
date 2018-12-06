% function y = Xh2nh(x)
%
% Toolbox Xvis: conversion homogeneous to non-homogeneous coordinates
%
% If x is a vector of n elements it returns x(1:n-1)/x(n).
% If x is a matrix it returns the conversion of each column.
%
% Example:
%
%    m  = [2 3; 4 9; 2 3];   % Two 2D points in homogenous coordinates
%    xy = Xh2nh(m)           % non-homogenus coordinates (1,2) and (1,3)
%

function y = Xh2nh(x)
n = size(x,1);
y = x(1:n-1,:)./(ones(n-1,1)*x(n,:));