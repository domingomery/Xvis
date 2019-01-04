% function [X,GTdata] = XreadGT(group,series,k,GTfile)
%
% Toolbox Xvis: Display ground truth for image k of series/group
%
%      X     : output image
%      group : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%      k     : number of the image of the series
%      GTfile: ground trouth file (if GTfile is not given or it is empty,
%              then it will be used file 'ground_truth.txt')
%              or number of the series where is the binary ideal
%              segmentation
%      GTdata: coordinates of ground trouth bounding box
%              or binary ideal segmentation
%
% Example: Bounding boxes
%
%    [I,GTdata] = XreadGT('C',2,5);
%
function GTdata = XreadGT(group,series,k,GTfile)

warning('off', 'Images:initSize:adjustingMag');

if ~exist('GTfile','var')
    GTfile = 'ground_truth.txt';
end

if isempty(GTfile)
    GTfile = 'ground_truth.txt';
end

GT = Xloaddata(group,series,GTfile);
ii = find(round(GT(:,1))==k);
n = length(ii);
if n>0
    GTdata = zeros(n,size(GT,2)-1);
    for i = 1:n
        t = GT(ii(i),2:end);
        GTdata(i,:) = t;
    end
else
    GTdata = [];
end
