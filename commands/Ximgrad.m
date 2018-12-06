% [G,A] = Ximgrad(I,h)
%
% Toolbox Xvis: Gradient of image I using mask h.
%
%     I: input image
%     h: mask
%     G: magnitud of gradient
%     A: direction of gradient
%
%  Example:
%     I  = imread('weld.png');
%     hs = fspecial('sobel')';
%     G = Ximgrad(I,hs);
%     figure
%     imshow(I,[])
%     figure
%     imshow(log(G+1),[])

function [G,A] = Ximgrad(I,hs)

Gi = conv2(double(I),hs','same');
Gj = conv2(double(I),hs,'same');

C = Gi + sqrt(-1)*Gj;

G = abs(C);
A = angle(C);

