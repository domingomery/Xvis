% J = Ximaverage(I,k)
%
% Toolbox Xvis: Linear average filtering of image I.
%
%    Input data:
%       I grayvalue image.
%
%    Output:
%       J: filtered image so that J is convolution of I with an average 
%       mask h = ones(k,k)/k^2.
%
%    Example:
%       I = imread('circuit.tif');
%       figure(1)
%       imshow(I,[]); title('original image')
%       J = Ximaverage(I,7);
%       figure(2)
%       imshow(J,[]); title('transformed image')

function J = Ximaverage(I,k)
h = ones(k,k)/k/k;
J = conv2(double(I),h,'same');
