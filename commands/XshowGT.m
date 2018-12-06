% function [X,GTdata] = XshowGT(group,series,k,GTfile)
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
%      col   : color of the ground truth (default is 'r')
%      GTdata: coordinates of ground trouth bounding box
%              or binary ideal segmentation
%
% Example 1: Bounding boxes
%
%    [I,GTdata] = XshowGT('C',2,5);
%
% Example 2: Binary ideal segmentation
%
%    [I,Ibin]   = XshowGT('W',1,3,2,'g');

function [X,GTdata] = XshowGT(group,series,k,GTfile,col,map)

warning('off', 'Images:initSize:adjustingMag');



if ~exist('map','var')
    map = gray;
end

m3D =  strcmp(map,'3D');

if ~exist('GTfile','var')
    GTfile = 'ground_truth.txt';
end

if isempty(GTfile)
    GTfile = 'ground_truth.txt';
end



if ~exist('col','var')
    col = 'r';
end

clf

if length(GTfile)==1
    X      = Xloadimg(group,series,k,1,map);
    % X      = Xpseudocolor(X,map);
    GTdata = Xloadimg(group,GTfile,k);
    Xbinview(X,GTdata,col);
else
    GT = Xloaddata(group,series,GTfile);
    % orient = size(GT,2)==9;  % oriented bounding box
    type_bb = round((size(GT,2)-1))/2;
    X = Xloadimg(group,series,k,0);
    if m3D == 0
    X = Xpseudocolor(X,map);
    hold on
    else
    X = Xloadimg(group,series,k,1,'3D');
    end
    ii = find(round(GT(:,1))==k);
    n = length(ii);
    if n>0
        if m3D == 1
            disp('In 3D visualization annotations Ground Truth cannot be displayed.');
        else
            GTdata = zeros(n,size(GT,2)-1);
            for i = 1:n
                t = GT(ii(i),2:end);
                switch type_bb
                    case 4 % 4 vertices (oriented bounding box)
                        plot(t([1:2:end 1]),t([2:2:end 2]),col);
                    case 2 % 2 vertices (horizontal/vertical bounding box)
                        plot(t([1 2 2 1 1]),t([3 3 4 4  3]),col);
                    case 1 % one point
                        plot(t(1),t(2),[col 'x']);
                end
                GTdata(i,:) = t;
                
            end
            if type_bb>1
                if n==1
                    fprintf('%d boudning box.\n',n);
                else
                    fprintf('%d bounding boxes.\n',n);
                end
            else
                if n==1
                    fprintf('%d point.\n',n);
                else
                    fprintf('%d points.\n',n);
                end
                
            end
        end
    else
        fprintf('There is no bounding box in this image.\n');
        GTdata = [];
    end
end
title([group sprintf('%04d',series) '\_'  sprintf('%04d',k) '.png' ]);
