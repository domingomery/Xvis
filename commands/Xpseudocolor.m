% function I = Xpseudocolor(I,map,show)
%
% Toolbox Xvis: Load image from GDXray.
%
%      I     : output RGB image
%      group : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%      map   : color map
%      k     : number of the image of the series
%      show  : display resulys
%
% Example:
%    I = Xloadimg('C',3,2);
%    J = Xpseudocolor(I,jet,1);

function J = Xpseudocolor(I,map,show)

if ~exist('show','var')
    show = 1;
end

n = size(map,1);

switch class(I)
    case 'logical'
        t = 2;
    case 'uint8'
        t = 256;
    case 'uint16'
        t = 65536;
end

if n~=t
    if t==2
        map = [0 0 0; 1 1 1];
    else
        map = imresize(map,[t 3]);
        map(map<0) = 0;
        map(map>1) = 1;
    end
end

J = ind2rgb(I,map);

if show==1
    imshow(J);
end
