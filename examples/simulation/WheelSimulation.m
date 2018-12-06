% WheelSimulation.m
close all
Nv = 1800;                                    % Number of voxels in each direction
V  = Xobjvoxels(1,Nv,1);                      % V has Nv^3 voxels od a wheel with a flaw

% Transformation (x,y)->(u,v)
u0 = 235; v0 = 305; ax = 1.1; ay = 1.1;       % translation and scaling
K  = [ax 0 u0; 0 ay v0; 0 0 1];               % transformation matrix

% Transformation (Xb,Yb,Zb)->(x,y)
f  = 1500;                                    % focal length
P  = [f 0 0 0; 0 f 0 0; 0 0 1 0];

% Transformation (X,Y,Z)->(Xb,Yb,Zb)
R  = Xmatrixr3(0.5,0.1,0.6);                  % rotation
t  = [-120 -120 1000]';                       % translation
H  = [R t; 0 0 0 1];                          % transformation matrix

PP = K*P*H;                                   % complete projection matrix

Q = Xsimvoxels(512,512,V,7,PP);               % simulation

imshow(exp(-0.0001*Q),[])                     % display simulation


