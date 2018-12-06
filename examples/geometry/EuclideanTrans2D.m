% EuclideanTrans2D.m
th = 35/180*pi;     % Rotation in radians
t  = [4.1 3.2]';    % Translation tx,ty in cm
R  = Xmatrixr2(th); % Rotation matrix
H  = [R t; 0 0 1];  % Euclidean transformation matrix
x  = 4.9;           % x coordinate
y  = 5.5;           % y coordinate
m  = [x y 1]';      % 2D point in homogeneous coordinates
mp = inv(H)*m;      % Transformation m -> mp
xp = mp(1)/mp(3)    % x' coordinate
yp = mp(2)/mp(3)    % y' coordinate

