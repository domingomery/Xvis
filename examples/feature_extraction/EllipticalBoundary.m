% EllipticalBoundary.m
I = double(Xloadimg('N',5,9));     % input image
I = imrotate(I(1:2:end,:),25);     % shape transformation and rotation
R = Xsegbimodal(I);                % segmentation
[X,Xn] = Xfitellipse(R);           % ellipse features
Xprintfeatures(X,Xn)               % features
imshow(I,[]); hold on
Xdrawellipse(X,'y')                % ellipse drawing
plot(X(2),X(1),'y*')               % center of ellipse
