% function R = Xmatrixr2(theta)
%
% Toolbox Xvis: 2D rotation matrix.
%
% It returns the 2D rotation matrix given by a rotation angle theta in
% radians.
%
%    R = [ cos(theta) -sin(theta)
%          sin(theta)  cos(theta)];
%
% Example:
%
%    R  = Xmatrixr2(pi/3);   % Rotation matrix for theta = pi/3
%    x  = 1; y = 0;          % 2D point given in original coordinate system
%    m  = [x y]';            % 2D point as vector
%    mt = R*m;               % Transformed 2D point as vector
%    xt = mt(1), yt = mt(2)  % 2D point given in new coordinate system
%
% See also Xmatrixr3, Xmatrixp.

function R = Xmatrixr2(theta)

R = [ cos(theta) -sin(theta)
      sin(theta)  cos(theta)];

