% EllipsoidSimulation.m
close all
I = imread('wheel.png');                     % input image

xmax = 400; var_mu = 0.1;                    % maximal thickness and mu

% Transformation (x,y)->(u,v)
u0 = 235; v0 = 305; ax = 1.1; ay = 1.1;       % translation and scaling 
K  = [ax 0 u0; 0 ay v0; 0 0 1];               % transformation matrix 

% Transformation (Xb,Yb,Zb)->(x,y)
f  = 1500;                                    % focal length       

% Transformation (X,Y,Z)->(Xb,Yb,Zb)
R  = Xmatrixr3(0,0,0);                        % rotation
t  = [-36 40 1000]';                          % translation
S  = [R t; 0 0 0 1];                          % transformation matrix

% Transformation (Xp,Yp,Zp)->(X,Y,Z)
Re = Xmatrixr3(0,0,pi/3);                     % rotation
te = [0 0 0]';                                % translation
Se = [Re te; 0 0 0 1];                        % transformation matrix

% Ellipsoid's axes
abc = [3.5 4.5 2.5];                          % a, b, c 

I = Xsimdefect(I,K,S*Se,f,abc,var_mu,xmax,1); % simulation

