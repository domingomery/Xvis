% function gdx_dir = Xgdxdir(group,series)
%
% Toolbox Xvis: Name of directory of a group and series
%
%      I      : output image
%      group  : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series : number of the series
%      gdx_dir: name of the directory, it returns -1 if group does not
%      exist.
%
% Example:
%
%    st = Xgdxdir('C',3);

function gdx_dir = Xgdxdir(group,series)


fid = fopen('gdx_root.txt');
gdx_root = fscanf(fid,'%s');
fclose(fid);

if ~exist(gdx_root,'dir')
    error('%s does not exist, please update file gdx_root.txt with the name of the root directory of GDX database correctly.',gdx_root)
end
% gdx_root = '/Users/domingomery/Dropbox/Public/GDXray';

ok = 1;
switch upper(group)
    case 'C'
        st = 'Castings';
    case 'B'
        st = 'Baggages';
    case 'W'
        st = 'Welds';
    case 'N'
        st = 'Nature';
    case 'S'
        st = 'Settings';
    otherwise %   error('Group %d does not exist.\n',group);
        ok = 0;
end

if ok ==1
    gdx_dir = sprintf('%s/%s/%s%04d/%s',gdx_root,st,group,series);
else
    gdx_dir = -1;
end
