% ContrastDefects.m
close all
I           = Xloadimg('N',1,4);                 % X-ray of apples
X           = I(1450:1629,420:609);              % input image (one apple)
figure(1)
imshow(X); title('input image');               

E           = and(edge(X,'log',1e-10,1),X>40);   % edge detection

[F,m]       = bwlabel(not(E),4);                 % labels of the regions
op.neighbor = 2;                                 % neigborhood is imdilate
op.param    = 5;                                 % with 5x5 mask
op.show     = 0;
R           = zeros(size(X));                    % initialization of detection
for i=1:m                                        % for each region
    Ri    = F==i;                                % region i
    Area  = sum(Ri(:));
    K     = Xcontrast(X,Ri,op);                  % contrast features
    if (Area>50) && (Area<150) && ...
        K(2)<-0.01 && K(5) > 2.9                 % detection
        R = or(R,Ri);
    end
end
figure(2)
Xbinview(X,imclose(R,ones(5,5)));                % output image
title('small defects');


