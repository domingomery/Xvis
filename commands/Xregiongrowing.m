%  Dt = Xregiongrowing(I,th,p)
%
% Toolbox Xvis:
%  Region segmentation using growing region algorithm with similar
%  gray-values.
%
%  I   : grayscale image
%  th  : maximal difference of grayvalues in the region
%        (default: th = 20)
%  p   : coordinates of seed p = [x y] if not given, interactive mode is
%        activated.
%  D   : output binary image with segmented regions
%
%  Example:
%     I  = imread('pencase.png');
%     D  = Xregiongrowing(I);
%     Xbinview(I,bwperim(D),'y');

function D = Xregiongrowing(I,th,p)
I  = double(I);
D  = zeros(size(I));
N  = ones(size(I));
if ~exist('p','var')
    figure(1)
    imshow(I,[]);
    disp('select a pixel of a region in Figure 1...')
    p = ginput(1)';
end
i = round(p(2));
j = round(p(1));
m = I(i,j);


if ~exist('th','var')
    th = (max2(I)-min2(I))/16;
end
D(i,j) = 1;
ok = 0;
nd0 = sum2(D);
while not(ok)
    nd = nd0;
    Dd = and(N,imdilate(D,ones(3,3)));
    S  = Dd-D;
    ii = find(S==1);
    for k=1:length(ii)
        if abs(I(ii(k))-m)<th
            D(ii(k))=1;
        else
            N(ii(k))=0;
        end
    end
    nd0 = sum2(D);
    ok = nd0-nd==0;
end
