% function Xgdxannotate(group,series)
%
% Toolbox Xvis: Interactive environment for annotation of GDXray 
%
%      group : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%
% Example: 
%
%    Xgdxannotate('B',4);
%    % Please save Bounding Boxes to ASCII file test.txt
%    % Check the bounding boxes using XshowGT('B',4,k,'razor_blade.txt');
%    % where k is the number of a X-ray image of this series, eg k=1;

function Xgdxannotate(group,series)
st = Xgdxdir(group,series);
cd(st)
Xannotate
