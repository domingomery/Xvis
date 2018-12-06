% DetectionPerformance.m
close all;
[I,bb] = XshowGT('C',21,27,[],'y');
title('Ground truth');
X  = Ximgaussian(I,5);                            % low pass filtering
Y0 = Ximmedian(X,23); 
Y1 = abs(double(X)-double(Y0)); 
Y2 = Y1>18;
Y3 = bwareaopen(Y2,20);
Y = imclearborder(imdilate(Y3,ones(17,17)));
figure(2)
imshow(Y); title('Detection');
figure(3)
[TP,FP,D,A] = Xpascalstats(X,Y,bb,0,0.5,1);
fprintf('There are %d defects (ground truth in yellow)\n',D);
fprintf('  > %d were detected (true posities in green)\n',TP);
fprintf('  > with %d false alarms (false positives in red).\n',FP);
