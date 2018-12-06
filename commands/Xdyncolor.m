% Xdyncolor(X,map,channels)
%
% Toolbox Xvis: Dynamic pseudocolor representations of image X.
%
%    Input data:
%       X       : Xray image.
%       map     : colormap.
%       channels: channels to be dynamically changed
%
%   In this program image X will be displayed using different color maps 
%   as a movie. The first color map is the original ('map'), the next maps
%   will be constructed by circularly shifting the the rows of the map in one 
%   direction. When a whole shift is done, the direction is changed. This
%   process is performed 3 times. Parameter 'channels' defines which columns 
%   of the map are shifted. Default is 1:3 (all three channels).
%
%   This program can be used for manual inspection. The objects of interest 
%   can be more distinguishible when displaying the X-ray image as video in 
%   different color maps.
%
%    Example 1:
%       I  = Xloadimg('B',2,4);
%       Xdyncolor(I,hot);
%
%    Example 2:
%       I  = Xloadimg('B',2,4);
%       Xdyncolor(I,hsv,1);

function Xdyncolor(X,map,channels)

if ~exist('channels','var')
    channels = 1:3;
end

K  = uint8(double(X)/4);

n = size(map,1);

for j=1:3
    
    for i=1:2*n
        imshow(K,map);
        drawnow;
        if i>=n
            map(:,channels) = [map(2:end,channels); map(1,channels)];
        else
            map(:,channels) = [map(end,channels); map(1:end-1,channels); ];
        end
    end
    
end