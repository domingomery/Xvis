% EuclideanTrans3D.m
w  = 35/180*pi;        % Rotation wX in radians
t  = [1 3 2]';         % Translation tX,tY,tZ in mm
R  = Xmatrixr3(w,0,0); % Rotation matrix
H  = [R t; 0 0 0 1];   % Euclidean transformation matrix
Xp = 0;                % Xp coordinate
Yp = 1;                % Yp coordinate
Zp = 1;                % Zp coordinate
Mp = [Xp Yp Zp 1]';    % 3D point in homogeneous coordinates
M  = H*Mp;             % Transformation Mp -> M
X  = M(1)/M(4)         % X coordinate
Y  = M(2)/M(4)         % Y coordinate
Z  = M(3)/M(4)         % Y coordinate
