% function R = Xmatrixr3(wx,wy,wz)
%
% Toolbox Xvis: 3D->2D transformation using hyperbolic model.
%
%
% Reference: Mery, D.; Filbert, D. (2002): Automated Flaw Detection in 
% Aluminum Castings Based on The Tracking of Potential Defects in a 
% Radioscopic Image Sequence. IEEE Transactions on Robotics and Automation, 
% 18(6):890-901. 
%
% Example:
%
%

function w = Xhyperproj(M,pa,Hp)



alpha = pa(1);
u0    = pa(2);
v0    = pa(3);
f     = pa(4);
a     = pa(5);
b     = pa(6);
kx    = pa(7);
ky    = pa(8);

A = [kx*cos(alpha) ky*sin(alpha) u0
    -kx*sin(alpha) ky*cos(alpha) v0
    0              0             1];

% t  = [P(k,1) P(k,2) P(k,3)]';
B  = [f 0 0 0;0 f 0 0;0 0 1 0];
% Rp = Xmatrixr3(P(k,4),P(k,5),P(k,6));
% Hp = [Rp t;0 0 0 1];
Pp = B*Hp;


m   = Pp*M;
xp  = m(1)/m(3); yp=m(2)/m(3);
c   = 1/sqrt(1-xp^2/a^2-yp^2/b^2);
mpp = [c*xp c*yp 1]';
w  = A*mpp;




