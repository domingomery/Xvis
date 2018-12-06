% R = Xsegbimodal(I,p)
%
% Toolbox Balu: Xvis
%
%    Segmentation based on Otsu's method with filling holes. It is assumed
%    that the foreground is brighter than the background.
%
%    Input data:
%       I grayvalue image.
%       p: offset of threshold (default: p=-0.05) with p between -1 and 1. 
%          a positive value is used to dilate the segmentation, the negative 
%          to erode.
%
%    Output:
%       R: segmented binary image.
%       E: edge image of R.
%
%    Example: Training & Test together:
%       X = imread('weld.png');
%       figure(1)
%       imshow(X); title('original image')
%       R = Xsegbimodal(I);
%       figure(2)
%       imshow(R); title('segmented weld')
%

function [R,E,J] = Xsegbimodal(I,p)

if ~exist('p','var')
    p = -0.1;
end
if isempty(p)
    p = -0.1;
end

Id = double(I);
Imax = max(Id(:));
Imin = min(Id(:));
J = (Id-Imin)/(Imax-Imin);
ni = fix(size(J,1)/4);
nj = fix(size(J,2)/4);

if (mean(mean(J(1:ni,1:nj))) > 0.3)
    J = 1 - J;
end

t = graythresh(J);

Ro = J>(t+p);
A = bwareaopen(Ro,fix(length(Ro(:))/100));
C = imclose(double(A),strel('disk',7));
R = bwfill(C,'holes',8);
E = bwperim(R,4);


