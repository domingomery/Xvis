% PencaseRegionGrowing.m
close all
X = Xloadimg('B',3,4);             % input image
X = imresize(X,0.35);              % resize of input image
th = 40;                           % threshold
si = 403; sj = 190;                % seed
Y  = Xregiongrowing(X,th,[sj si]); % segmentation of the selected region
figure(1)
imshow(X,[]); title('input image');
hold on 
plot(sj,si,'r+');                  % seed pixel
figure(2)
imshow(Y);title('segmented region');
figure(3)
Xbinview(X,bwperim(Y));title('edges of the region');

