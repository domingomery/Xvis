% J = Xsimmask(I,h,i0,j0,show)
%
% Toolbox Xvis: Mask superimposition
%
%    I     : original image
%    J     : output image
%    h     : mask to be superimposed
%    i0,j0 : location of the mask (central pixel)
%    show  : display results
%
%   Example:
%   I  = imread('wheel.png');              % Input image
%   h  = fspecial('gaussian',27,3);        % Mask
%   h  = h/max(h(:))*0.7;
%   J = Xsimmask(I,h,160,110,1);           % Simulation
function J = Xsimmask(I,h,i0,j0,show)

if ~exist('show','var')
    show = 0;
end


I       = double(I);
[mi,mj] = size(h);

mi2  = floor(mi/2);
mj2  = floor(mj/2);

i1 = i0-mi2; i2 = i0+mi2;
j1 = j0-mj2; j2 = j0+mj2;
J = I;
J(i1:i2,j1:j2) = I(i1:i2,j1:j2).*(1+h);
J = uint8(J);

if show
    figure(1)
    imshow(I/255); title('original image');
    figure(2)
    imshow(J); title('image with simulated defect');
    hold on
    [N,M] = size(I);
    d = 0.01*max([N M]);
    vmin = j1-d; umin = i1-d; vmax = j2+d; umax = i2+d; 
    plot([vmin vmin vmax vmax vmin],[umax umin umin umax umax],'r')
end
