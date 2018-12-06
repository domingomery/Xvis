% SegmentationCastDefect.m
X = Xloadimg('C',31,19);                               % input image
X = X(1:2:572,1:2:572);
figure(1)
imshow(X); title('input image');

R = X<240;                                             % casting segmentation
figure(2);imshow(R);title('segmented object');

Amin  = 30;  Amax = 2000;                              % Area range
Gmin  = 0;   Gmax = 150;                               % Gray value range
Cmin  = 1.1; Cmax = 3;                                 % Contrast range
sigma = 2.5;                                           % sigma of LoG


Y = Xseglogfeat(X,R,[Amin Amax],[Gmin Gmax],...        % Segmentation
                    [Cmin Cmax],sigma);
figure(3)
Xbinview(X,bwperim(Y>0)); title('segmented regions')   % Edges of the segmentation