% MaskFlawSimulation.m
close all
I  = imread('wheel.png');                               % Input image
h1 = fspecial('gaussian',27,3); h1 = h1/max(h1(:))*0.7; % Gaussian mask (a)
i1 = 160; j1 = 110;                                     % Location of the mask
J1 = Xsimmask(I,h1,i1,j1,0);                            % Simulation
h2 = ones(17,17)*0.4;                                   % Square mask (b)
i2 = 200; j2 = 120;                                     % Location of the mask
J2 = Xsimmask(J1,h2,i2,j2,0);                           % Simulation
h3 = fspecial('disk',7);h3 = h3/max(h3(:))*0.4;         % Circle mask (c)
i3 = 240; j3 = 130;                                     % Location of the mask
J3 = Xsimmask(J2,h3,i3,j3,0);                           % Simulation
imshow(J3)                                              % Output image
text(j1+15,i1,'a','fontsize',16,'color','w');
text(j2+15,i2,'b','fontsize',16,'color','w');
text(j3+15,i3,'c','fontsize',16,'color','w');
