% J = Ximmedian(I,k)
%
% Toolbox Xvis: Median filtering of image I.
%
%    Input data:
%       I grayvalue image.
%
%    Output:
%       J: filtered image using median mask of k x k pixels.
%
%    Example:
%       I = imread('circuit.tif');
%       figure(1)
%       imshow(I,[]); title('original image')
%       J = Ximmedian(I,7);
%       figure(2)
%       imshow(J,[]); title('transformed image')

function J = Ximmedian(I,k)
J = medfilt2(I,[k k]);
