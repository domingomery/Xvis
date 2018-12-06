% Xplotepipolarline(F,m1,col)
%
% Toolbox Xvis: Plot epipolar line.
%
% It computes the eipolar line in second view from fundamental matrix
%    F and point m1 in first view. The line is drawn using color col.
%
%    Example:
%       A = rand(3,4);                      % Projection matrix for view 1
%       B = rand(3,4);                      % Projection matrix for view 2
%       F = Xfundamental(A,B,'tensor');     % Fundamental matrix using tensors
%       M = [1 2 3 1]';                     % 3D point (X=1,Y=2,Z=3)
%       m1 = Xh2nh(A*M);                    % projection point in view 1
%       m2 = Xh2nh(B*M);                    % projection point in view 2
%       figure; clf
%       plot(m2(1),m2(2),'rx')
%       Xplotepipolarline(F,m1,'g')         % epipolar constraint must be zero

function Xplotepipolarline(F,m1,col)
hold on
if length(m1) == 2
    m1 = [m1; 1];
end
ell = F*m1;
ax  = axis;
x   = ax(1:2)';
a   = ell(1);
b   = ell(2);
c   = ell(3);
y   = -(c+a*x)/b;
plot(x,y,col)
