% ContrastEnhancement.m
close all
X = Xloadimg('B',44,130);                                 % input image
figure(1)
imshow(X,[]); title('original image')
hold on
disp('Select top corner of rectangle to be enhanced...')
p = round(ginput(1));
i1 = p(1,2); j1 = p(1,1);                                  % coordinates of first corner
plot(j1,i1,'r+')
disp('Select bottom corner of rectangle to be enhanced...')
p = round(ginput(1));
i2 = p(1,2); j2 = p(1,1);                                  % coordinates of second corner
plot([j1 j2 j2 j1 j1],[i1 i1 i2 i2 i1],'r')                % selected area
Xbox = X(i1:i2,j1:j2);                                     % subimage
Ybox = Xforceuni(Xbox);                                    % equalization of subimage
Y = X;
Y(i1:i2,j1:j2) = Ybox;                                     % replacement
figure(2)
imshow(Y,[]); title('enhanced image')

