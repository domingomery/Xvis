% function [TP,FP] = Xpascalstats(B,bb,method,pascalth)
%
% Toolbox Xvis: Pascal statistics for a binary image and ground truth 
%               bounding boxes. 
%
%      Each isolated region in B is considered a detection. A bounding box
%      is computed for each detection, and the intersection and the union
%      is computed for each region in the ground truth defined by the
%      bounding boxes. If the ratio Intersectio/Union is greater than pascalth
%      (default pascalth = 0.5) then it is a true positive, else it is a false
%      positive.
%      B        : Binary image
%      bb       : bounding boxes
%      pascalth : threshold for Pascal ration
%      method   : means binary regions are considered as rectangles, 0 are
%                 considered as original shapes
%      TP       : true positives
%      FP       : false positive
%      P        : positive instances (number of ground truth instances)
%
% Example: 
%
%    Xgdxannotate('B',4);
%    % Please save Bounding Boxes to ASCII file test.txt
%    % Check the bounding boxes using XshowGT('B',4,k,'razor_blade.txt');
%    % where k is the number of a X-ray image of this series, eg k=1;

function [TP,FP,P,A] = Xpascalstats(I,B,bb,method,pascalth,show)

if ~exist('pascalth','var')
    pascalth = 0.5;
end

[L,m] = bwlabel(B,4);

if show
    clf
    imshow(I,[]);
    hold on
    plot(1,1,'y');
    plot(1,1,'g');
    plot(1,1,'r');
    legend({'Ground Truth','True Positive','False Positive'});
end

n = size(bb,1);
P = n;

if n == 0
    TP = 0;
    FP = m;
    A = [];
    return
end

if m==0
    TP = 0;
    FP = 0;
    A = [];
    return
end



[N,M] = size(B);

GT = zeros(N,M,n);

for i=1:n
    t = round(bb(i,:));
    i1 = min([N t(3)]); i2 = max([1 t(4)]); 
    j1 = min([M t(1)]); j2 = max([1 t(2)]);
    GT(i1:i2,j1:j2,i) = 1;
    if show
    plot([j1 j2 j2 j1 j1],[i1 i1 i2 i2 i1],'y');
    end
end


TP = zeros(m,1);
FP = zeros(m,1);
A  = zeros(m,1);
for j=1:m
    R = L==j;
    [ii,jj] = find(R==1);
    i1 = min(ii); i2 = max(ii); j1 = min(jj); j2 = max(jj);
    if method == 1
        R(i1:i2,j1:j2) = 1;
    end
    amax = 0;
    for i=1:n
       Uj = or(R,GT(:,:,i));
       Ij = and(R,GT(:,:,i));
       a  = sum(Ij(:))/sum(Uj(:));
       if a>amax
           amax = a;
       end
    end
    if amax>=pascalth
        TP(j) = 1;
        col = 'g';
    else
        FP(j) = 1;
        col = 'r';
    end
    A(j) = amax;
    if show
        plot([j1 j2 j2 j1 j1],[i1 i1 i2 i2 i1],col);
        text(j1,i1-3,num2str(j),'fontsize',14,'color',col)
    end
end

TP = sum(TP);
FP = sum(FP);
if show
    drawnow;
end
