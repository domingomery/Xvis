% E = Xgradlog(I,sigma,th)
%
% Toolbox Xvis: Edge detection using LoG and gradient.
%
%     I    : input image
%     sigma: sigma of Gaussian function
%     th   : threshold of gradient
%     E    : edge detection. It is or(E_log,E_grad), where E_log is edge
%     detection using LoG, and E_grad is edge detection using gradient of I
%     thresholding by th. Gradient of I is computed after Gaussian low pass
%     filtering (using sigma).
%
%  Example:
%     I = imread('small_wheel.png');
%     E = Xgradlog(I,1.25,4);
%     figure
%     imshow(I,[])
%     figure
%     imshow(E,[])

function E = Xgradlog(I,sigma,th)

E_log = edge(I,'log',1e-10,sigma);         % LoG edge detection

hsize = round((8.5*sigma)/2)*2+1;
g = fspecial('gaussian',hsize,sigma);
h = conv2(g,[-1 1],'same');                % gradient of Gaussian

E_grad = Ximgrad(I,h)>th;                  % high gradient are thicker
E = or(E_log,E_grad);                      % output
