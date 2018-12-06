% [f_new,fn_new] = Xnoscale(f,fn)
%
% Toolbox Xvis:
%
%     This procedure deletes the geometric features related to the scale.
%     It deletes the following features:
%        - center of grav i
%        - center of grav j
%        - Ellipse-centre i
%        - Ellipse-centre j
%
% Example:
%      I = imread('fruit.png');               % input image
%      R = Xsegbimodal(I);                    % segmentation
%      [X1,Xn1] = Xbasicgeo(R);               % basic geometric features
%      [X2,Xn2] = Xfitellipse(R);             % Ellipse features
%      X0 = [X1 X2]; Xn0 =[Xn1;Xn2];
%      fprintf('\nOriginal features\n');
%      Xprintfeatures(X0,Xn0)
%      [X,Xn] = Xnoscale(X0,Xn0);       % delete position features
%      fprintf('\nSelected features\n');
%      Xprintfeatures(X,Xn)

function [f_new,fn_new] = Xnoscale(f,fn)

s = {'Ellipse-minor ax','Ellipse-major ax','Area','Perimeter','Height','Width','Equivalent Diameter','MajorAxisLength','MinorAxisLength','Ellipse-area'};
 
[f_new,fn_new] = Xnofeatures(f,fn,s); 
 
