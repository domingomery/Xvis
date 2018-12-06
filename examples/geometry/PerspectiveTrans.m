% PerspectiveTrans.m
f = 100;         % Focal distance in cm
X = 20;          % X coordinate in cm
Y = 30;          % Y coordinate in cm
Z = 50;          % Z coordinate in cm
M = [X Y Z 1]';  % 3D point in homogeneous coordinates
P = Xmatrixp(f); % Rotation matrix
m = P*M;         % Transformation M -> m
x = m(1)/m(3)    % X coordinate
y = m(2)/m(3)    % Y coordinate
