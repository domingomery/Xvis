% function Iseq = Xshowseries(group,series,ii,n,NM,fscale)
%
% Toolbox Xvis: Display X-ray images of a series
%
%      Iseq  : output image with all thumb
%      group : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%      ii    : images
%      n     : number of images per row
%      NM    : resize of the images
%      fscale: 1 lowest/highest grayvalue is set to 0/255
%              0 original grayvalues (no scaled)
%
% Example:
%
%    Xshowseries('C',1,1:72,9,[50 70]);

function Iseq = Xshowseries(group,series,ii,n,NM,fscale)


if not(exist('fscale','var'))
    fscale = 1;
end

II = [];

ni = length(ii);

t = 0;
II = [];
Iseq = [];
for i0=1:ni
    i = ii(i0);
    Ii = imresize(Xloadimg(group,series,i,0),NM);
    if fscale == 1
        Ii = Xlinimg(Ii);
    end
    Iseq = [Iseq Ii];
    t = t + 1;
    if (t==n)
        II = [II; Iseq];
        t = 0;
        Iseq = [];
    end
end
if t>0
    Iseq = [Iseq zeros(size(Ii,1),size(Ii,2)*(n-t))];
    II = [II; Iseq];
end

Iseq = II;

imshow(Iseq);
title(sprintf('Series %s%04d',group,series))
