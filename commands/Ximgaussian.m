% J = Ximgaussian(I,k)
%
% Toolbox Xvis: Gaussian filtering of image I.
%
%    Input data:
%       I grayvalue image.
%
%    Output:
%       J: filtered image so that J is convolution of I with a Gaussian 
%       mask of size k x k. If parameter sigma is not given, it will be set
%       as sigma = k/8.5.
%
%    Example:
%       I = imread('circuit.tif');
%       figure(1)
%       imshow(I,[]); title('original image')
%       J = Ximgaussian(I,17);
%       figure(2)
%       imshow(J,[]); title('transformed image')

function J = Ximgaussian(I,k,sigma)
if ~exist('sigma','var')
    sigma = k/8.5;
end

h = fspecial('gaussian',k,sigma);
h = h/sum(h(:));
J = conv2(double(I),h,'same');
