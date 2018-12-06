%  [F,m] = Xseglogfeat(J,R,[Amin Amax],[Gmin Gmax],[Cmin Cmax],sig)
%
% Toolbox Xvis:
%  Segmentation of regions in image J using LoG edge detection.
%  R   : binary image of same size of J that indicates the piexels where
%        the segmentation will be performed. Default R = ones(size(J));
%  [Amin Amax]: minimum and maximum area of the segmented details.
%  [Gmin Gmax]: minimum and maximum gray values of the segmented details.
%  [Cmin Cmax]: minimum and maximum contrast of the segmented details.
%  Contrast is defined as (mean gray value of a region) / (mean gray value 
%  of the boundary of the region), where boundary is 3 pixels around the region. 
%  sig : sigma of LoG edge detector.
%  F   : labeled image of the segmentation.
%  m   : numbers of segmented regions.
%
%  Example:
%     I = imread('cast_defect.png');
%     figure(1);imshow(I);title('test image');
%     [F,m] = Xseglogfeat(I,I<230,[200 2000],[0 150],[1.10 2],3.4);
%     figure(2);Xbinview(I,F>0);title('segmented image');

function [F,m] = Xseglogfeat(J,R,Area,Gray,Contrast,sig)
if isempty(R)
    R = ones(size(J));
end

Amin = Area(1);
Amax = Area(2);
Gmin = Gray(1);
Gmax = Gray(2);
Cmin = Contrast(1);
Cmax = Contrast(2);

se = strel('disk',3);
Re = imdilate(R,se);
E  = imclearborder(bwperim(R,4),4);
B  = (edge(J,'log',1e-10,sig) & Re) | E;
B  = imclearborder(not(B),4);
[F,m]  = bwlabel(B,4);

D = zeros(size(J));


for i=1:m
    R        = F==i;
    B        = xor(R,imdilate(R,ones(17,17)));
    iR       = R==1;
    iB       = B==1;
    Area     = sum(iR(:));
    GrayR    = mean(J(iR));
    GrayB    = mean(J(iB));
    Contrast = GrayR/GrayB;
    if (Area>= Amin) && (Area<= Amax) && (GrayR>=Gmin) && (GrayR<=Gmax) && (Contrast>=Cmin) && (Contrast<=Cmax)
        D = or(D,R);
        %figure(3);
        %Xbinview(J,bwperim(D))
        %[i Area GrayR Contrast*1000]/1000
        %pause
    end
end

[F,m] = bwlabel(D);
fprintf('%d segmented regions.\n',m);
