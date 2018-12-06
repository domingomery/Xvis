% AppleSegmentation.m

close all
I = Xloadimg('N',5,9);                      % input image (a fruit)
figure(1) 
imshow(I);title('Input image');

[R,E] = Xsegbimodal(I);                     % bimodal segmentation and boundary
figure(2)
imshow(R); title('Segmetation');

figure(3)
Xbinview(I,E,'r',2); title('Segmentation'); % boundary of the segmented region