% function R = Xmatrixr3(wx,wy,wz)
%
% Toolbox Xvis: 3D rotation matrix.
%
% It returns the 3D rotation matrix given by a rotation arround z, y and x 
% axes where the rotation angles are wz, wy, and wx respectively. The 
% angles are given in radians.
%
% R = Xmatrixr3(wx,wy,wz) is equal to Rx*Ry*Rz where 
%    
%    Rz = [  cos(wz)  sin(wz)    0
%           -sin(wz)  cos(wz)    0
%             0         0       1];
%
%    Ry = [ cos(wy)     0     -sin(wy)
%              0        1       0
%           sin(wy)     0      cos(wy)]; 
%
%    Rx = [    1        0        0
%              0      cos(wx)  sin(wx)
%              0     -sin(wx)  cos(wx)];
%
% Example:
%
%    R  = Xmatrixr3(pi/2,-pi,0);        % Rotation matrix for theta = pi/3
%    X  = 1; Y = 0; Z = 1;              % 3D point given in original coordinate system
%    M  = [X Y Z]';                     % 3D point as vector
%    Mt = R*M;                          % Transformed 2D point as vector
%    Xt = Mt(1), Yt = Mt(2), Zt = Mt(3) % 2D point given in new coordinate system
%
% See also Xmatrixr2, Xmatrixp.

function R = Xmatrixr3(wx,wy,wz)

R = [
cos(wy)*cos(wz)                          cos(wy)*sin(wz)                         -sin(wy) 
sin(wx)*sin(wy)*cos(wz)-cos(wx)*sin(wz)  sin(wx)*sin(wy)*sin(wz)+cos(wx)*cos(wz)  sin(wx)*cos(wy) 
cos(wx)*sin(wy)*cos(wz)+sin(wx)*sin(wz)  cos(wx)*sin(wy)*sin(wz)-sin(wx)*cos(wz)  cos(wx)*cos(wy)];


