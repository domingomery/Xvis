% PencaseSegmentation.m

close all
I   = Xloadimg('B',2,1);                             % input image
figure(1)
imshow(I); title('Input image');

[fr,sd,J] = Xsegmser(I,[15 20000 0.9 0.2 6 2 0]);    % MSER segmentation
E = imdilate(bwperim(J),ones(3,3));                  % edges
figure(2)
imshow(E); title('Edges');                  

L = bwlabel(J);
figure(3)
imshow(L,[]); title('Segmentation');
