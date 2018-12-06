% function nimg = Xgdxseriesnum(group,series)
%
% Toolbox Xvis: number of images of a series-directory
%
%      group  : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series : number of the series
%      nimgr  : number of images, it returns -1 if group does not
%      exist.
%
% Example:
%
%    nimg = Xgdseriesnum('C',3);

function nimg = Xgdxseriesnum(group,series)

fid = fopen('gdx_root.txt');
gdx_root = fscanf(fid,'%s');
fclose(fid);

if ~exist(gdx_root,'dir')
    error('%s does not exist, please update file gdx_root.txt with the name of the root directory of GDX database correctly.',gdx_root)
end

st = Xgdxdir(group,series);
if exist(st,'dir')
    d1 = dir([st '*.png']); 
    nimg = length(d1);
else
    nimg = -1;
end
