% [f_new,fn_new] = Xnofeatures(f,fn,s)
%
% Toolbox Xvis:
%
%     This procedure deletes those features whose feature names contain a  
%     strings of s.
%
% Example:
%      I = imread('fruit.png');               % input image
%      R = Xsegbimodal(I);                    % segmentation
%      [X1,Xn1] = Xbasicgeo(R);               % basic geometric features
%      [X2,Xn2] = Xfitellipse(R);             % Ellipse features
%      X0 = [X1 X2]; Xn0 =[Xn1;Xn2];
%      fprintf('\nOriginal features\n');
%      Xprintfeatures(X0,Xn0)
%      s = {'Perimeter','Roundness'};
%      [X,Xn] = Xnofeatures(X0,Xn0,s);        % delete Perimeter and Roundness
%      fprintf('\nSelected features\n');
%      Xprintfeatures(X,Xn)

function [f_new,fn_new] = Xnofeatures(f,fn,s)


n = length(s);

M = size(fn,1);


ii = false(M,1);
for i=1:n
    x = s{i};
    nx = length(x);
    for j=1:M
        % ii(j) = or(ii(j),strcmp(x,fn(j,1:nx))); % version for feature name starts with x
        ii(j) = or(ii(j),~isempty(strfind(fn(j,1:nx),x)));
    end
end
    
f_new = f;
fn_new = fn;

f_new(:,ii)  = [];
fn_new(ii,:) = [];

