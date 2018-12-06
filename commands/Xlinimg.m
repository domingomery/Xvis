% J = Xlinimg(I,t)
%
% Toolbox Xvis: Linear enhancement of image I from 0 to 255, or 0 to 1.
%
%    Input data:
%       I grayvalue image.
%       if t==255 output will a unit8 image with gray values 0, 1, ... 255
%       else output will a double image with gray values from 0 to t
%
%    Output:
%       J: enhanced image so that
%       J = m*I + b; where min(J) = 0, max(J) = 255 or 1.
%       J is uint8 or double.
%
%    Example:
%       I = imread('circuit.tif');
%       figure(1)
%       imshow(I); title('original image')
%       J = Xlinimg(I);
%       figure(2)
%       imshow(J); title('transformed image')

function J = Xlinimg(I,t)

if ~exist('t','var')
    t = 255;
end

I = double(I);
mi = min(I(:));
mx = max(I(:));
d  = mx - mi;
if d==0
    J = I/mx*t/2;
else
    J = (I-mi)/d*t;
end
if t==255
   J = uint8(round(J));
end