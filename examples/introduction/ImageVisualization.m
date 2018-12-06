% ImageVisualization.m
close all
I  = Xloadimg('B',2,4);                        % input image
figure(1); imshow(I); title('X-ray image')
hold on
i1 = 250; i2 = 399; j1 = 340; j2 = 529;
plot([j1 j2 j2 j1 j1],[i1 i1 i2 i2 i1],'r');   % crop
J  = I(i1:i2,j1:j2);                           % cropped image
Xcolorimg(J,[],0);                             % color representation

