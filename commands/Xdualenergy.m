% Y = Xdualenergy(X1,X2,LUT,map)
%
% Toolbox Xvis: Dual energy.
%
%    Input data:
%       X1  : grayvalue image taken by low energy.
%       X2  : grayvalue image taken by low energy.
%       LUT : Look up table of the colors (i direction for X1, j direction
%       for X2). It should be a 256 x 256 elements (uint8).
%       map : color map - matrix of 256 x 3 elements (double).
%       show: it display results if show==1
%
%    Output:
%       Y: Output image.
%
%    Example:
% X1  = Xloadimg('B',60,1,0);                   % low energy image
% X2  = Xloadimg('B',60,1,0);                   % high energy image
% x   = Xloaddata('B',60,'DualEnergyLUT.mat');  % LUT
% map = imresize(parula,[256 3]);               % color map
% Y   = Xdualenergy(X1,X2,x.LUT,map,1);         % conversion

function [Y,map] = Xdualenergy(X1,X2,LUT,map,show)

if ~exist('show','var')
    show = 0;
end

if size(map,1)~=256
    map = abs(imresize(map,[256 3]));
end


if show == 1
    figure(1)
    I1 = int16(X1)+1;
    imshow(I1,[])
    title('Low energy image');
    
    figure(2)
    I2 = int16(X2)+1;
    imshow(I2,[])
    title('High energy image');
    
end



[n,m] = size(I1);
Y = zeros(n,m,'uint8');

for i=1:n
    for j=1:m
        Y(i,j) = LUT(I2(i,j),I1(i,j));
    end
end

if show==1
    figure(3)
    imshow(Y,map)
    colorbar
    title('Output image using pseudo colors')
    
    figure(4)
    mesh(double(LUT)/256)
    xlabel('Low energy gray values');
    ylabel('High energy gray values');
    
    figure(5)
    contour(double(LUT)/256)
    xlabel('Low energy gray values');
    ylabel('High energy gray values');
end