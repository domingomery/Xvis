% function I = Xloadimg(group,series,k,show,map)
%
% Toolbox Xvis: Load image from GDXray.
%
%      I     : output image
%      group : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%      k     : number of the image of the series
%      show  : display resulys
%
% Example 1:
%
%    I = Xloadimg('C',3,2,1);
%
% Example 2:
%
%    I = Xloadimg('B',1,2,1,jet);
%
% Example 3:
%
%    I = Xloadimg('N',5,8,1,'3D');

function I = Xloadimg(group,series,k,show,map)

warning('off', 'Images:initSize:adjustingMag');

if ~exist('show','var')
    show = 0;
end

if ~exist('map','var')
    g = (0:63)'/63;
    map = [g g g];
end

if strcmp(map,'3D')
    m3d = 1;
else
    m3d = 0;
    n = size(map,1);
    g = (0:(n-1))'/n;
    t = [g g g];
    gmap = sum(abs(map(:)-t(:)))==0;
end


gdxray_dir = Xgdxdir(group,series);

st = sprintf('%s%s%04d_%04d.png',gdxray_dir,group,series,k);

if exist(st,'file')
    
    I = imread(st);
    if size(I,3)==3
        I = rgb2gray(I);
    end
    if show
        clf
        if m3d == 0
            if gmap
                imshow(I);
            else
                J = Xpseudocolor(I,map);
                imshow(J);
            end
        else
            reset(gcf)
            mesh(I);
            view(-40,70)
        end
        title([group sprintf('%04d',series) '\_'  sprintf('%04d',k) '.png' ]);
    end
else
    I = -1;
    if show
        clf;
        title([group sprintf('%04d',series) '\_'  sprintf('%04d',k) '.png does not exist' ]);
    end
end
