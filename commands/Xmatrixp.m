% function P = Xmatrixp(f)
%
% Toolbox Xvis: Perspective proyection matrix 3D->2D.
%
% It returns the 3x4 perspective proyection matrix depending on focal 
% distance f.
%
%    P =  [f 0 0 0
%          0 f 0 0
%          0 0 1 0]
%
% Example:
%
%    f = 10;              % focal distance
%    P = Xmatrixp(f);     % Perspective matrix
%    X = 1; Y = 2; Z = 3; % 3D point
%    M = [X Y Z 1]';      % 3D point in homogeneous coordinates
%    m = P*M;             % 2D point in homogeneous coordinates
%    x = m(1)/m(3)        % x coordinate of 2D projected point
%    y = m(2)/m(3)        % y coordinate of 2D projected point
%
% See also Xmatrixr2, Xmatrixr3.

function P = Xmatrixp(f)
P = [f 0 0 0;0 f 0 0;0 0 1 0];
