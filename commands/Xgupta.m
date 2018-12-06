% [X,Xn] = Xgupta(R,options)
%
% Toolbox Xvis: Extract the three Gupta moments from binary image R.
%
%    options.show = 1 display mesagges.
%
%    X is a 3 elements vector:
%      X(i): Gupta-moment i for i=1,2,3.
%      Xn is the list of feature names.
%
%    Reference: 
%    Gupta, L. & Srinath, M. D. Contour sequence moments for the
%    classification of closed planar shapes Pattern Recognition, 1987, 20,
%    267-272.
%
%    Example:
%      I = imread('fruit.png'); % input image
%      R = Xsegbimodal(I);      % segmentation
%      [X,Xn] = Xgupta(R);      % Flusser moments
%      X
%
%   See also Xflusser, Xhugeo.

function [X,Xn] = Xgupta(R,options)
if ~exist('options','var')
    options.show = 0;
end

if options.show == 1
    disp('--- extracting Gupta moments...');
end
E       = bwperim(R,4);
[Ip,Jp] = find(E==1);               % pixel of perimeter in (i,j)
jj      = sqrt(-1);
Ig      = Ip+jj*Jp;
ix      = mean(Ip);
jx      = mean(Jp);
centre  = ix + jj*jx;
z       = abs(Ig-centre);
m1      = mean(z);
mur1    = z-m1;
mur2    = mur1.*mur1;
mur3    = mur1.*mur2;
mur4    = mur2.*mur2;
mu2     = mean(mur2);
mu3     = mean(mur3);
mu4     = mean(mur4);
F1      = sqrt(mu2)/m1;
F2      = mu3/mu2/sqrt(mu2);
F3      = mu4/mu2^2;



X  = [F1 F2 F3];

Xn = [ 'Gupta-moment 1          '
       'Gupta-moment 2          '
       'Gupta-moment 3          '];
