% [X,Xn] = Xcentroid(R,options)
%
% Toolbox Xvis: Centroid of a region.
%
%    options.show    = 1 display mesagges.
%
%      X(1) is centroid-i, X(2) is centroid-j
%      Xn is the list of the n feature names.
%
%    Example (Centroid of a region)
%      I = imread('fruit.png'); % input image
%      R = Xsegbimodal(I);      % segmentation
%      imshow(R);
%      options.show = 1;
%      [X,Xn] = Xcentroid(R,options);
%      Xprintfeatures(X,Xn)
%
%   See also Bfx_basicgeo, Bfx_gupta, Bfx_fitellipse, Bfx_flusser, 
%   Bfx_hugeo.

function [X,Xn] = Xcentroid(R,options)

if ~exist('options','var')
    options.show = 0;
end

if options.show == 1
    disp('--- extracting centroid...');
end
[Ireg,Jreg] = find(R==1);           % pixels in the region
ic = mean(Ireg);
jc = mean(Jreg);
X  = [ic jc];
Xn = [ 'Centroid i              '
       'Centroid j              ']; % 24 characters per name
if options.show == 1
    clf
    imshow(R)
    hold on
    plot(X(2),X(1),'rx')
    enterpause
end
