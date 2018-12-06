% function D = Xloaddata(group,series,datafile)
%
% Toolbox Xvis: Load data from GDXray
%
%      D     : data
%      group : first letter of group images 
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%      datafile : name of the file
%
% Example:
%
%    P = Xloaddata('B',44,'Pmatrices'); % load calibration camera matrices
%                                       % of series B0044

function D = Xloaddata(group,series,datafile)

if isempty(strfind(datafile,'.'))
    datafile = [datafile '.mat'];
end

gdxray_dir = Xgdxdir(group,series);

st = sprintf('%s%s',gdxray_dir,datafile);

if ~exist(st,'file')
    fprintf('WARNING: %s does not exist.\n',st);
    D = -1;
else
    D = load(st);
end
