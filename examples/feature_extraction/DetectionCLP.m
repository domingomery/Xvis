% DetectionCLP.m
close all
X = imread('small_wheel.png');
[N,M] = size(X);
figure(1);
imshow(X); title('Input image');                % input image

D = Xgradlog(X,1.25,4);                         % edge detection
figure(2)
imshow(D,[]);title('or(LoG,High gradient)')     

[F,m]   = bwlabel(not(D),4);                    % labels of the regions           
op.ng   = 32;                                   % size of CLP window
op.show = 0;                                    % do not display results
R           = zeros(N,M);                       % initialization of detection
for i=1:m                                       % for each region
    Ri    = F==i;                               % region i
    Area  = sum(Ri(:));                         % area of region
    CLP   = Xclp(X,Ri,op);                      % CLP features
    if (Area>10) && (Area<40) && CLP(6)>0.8     % detection
        R       = or(R,Ri);
        op.show = 1;
        CLP     = Xclp(X,Ri,op);                % display results
        op.show = 0;
        pause(1)
    end
end
figure(3)
Xbinview(X,imclose(R,ones(5,5)));                % output image
title('Casting defects');
