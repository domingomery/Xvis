% MedianDetection.m

close all;
X  = Xloadimg('C',21,29);                         % original image
X  = Ximgaussian(X,5);                            % low pass filtering
figure(1);
imshow(X,[]); title('Original image with defects');

figure(2)
Y0 = Ximmedian(X,23); 
imshow(Y0,[]);title('Median filter');

figure(3);
Y1 = abs(double(X)-double(Y0)); 
imshow(log(Y1+1),[]); title('Difference image');

figure(4)
Y2 = Y1>18;
imshow(Y2); title('Binary image');

figure(5)
Y3 = bwareaopen(Y2,18);
imshow(Y3); title('Small regions are eliminated');

figure(6)
Y = imclearborder(imdilate(Y3,ones(3,3)));
imshow(Y); title('Regions are dilated and border region are eliminated');

figure(7)
Xbinview(X,Y,'y'); title('Detection');
