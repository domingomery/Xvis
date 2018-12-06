% [J,R] = Xsimdefect(I,K,SSe,f,abc,var_mu,xmax,show)
%
% Toolbox Xvis: Simulation of defects
%
%    I     : original image
%    K     : 3x3 matrix of Transformation (x,y)->(u,v)
%    SSe   : S*Se
%    S     : 4x4 matrix of Transformation (X,Y,Z)->(Xb,Yb,Zb)
%    Se    : 4x4 matrix of Transformation (Xp,Yp,Zp)->(X,Y,Z)
%    f     : focal distance
%    abc   : [a b c] half axes of the ellipsoid or
%          : r radius of a sphere
%    var_mu: linear absorption coefficient 
%    xmax  : maximal thickness where gray values are minimal
%    show  : display results
%
%   Reference;
%      Mery, D. (2001): A new Algorithm for Flaw Simulation in Castings by 
%      Superimposing Projections of 3D Models onto X-Ray Images. XXI 
%      International Conference of the Chilean Computer Science Society, 
%      IEEE Computer Science Press, pp. 193-202, Nov. 5-9, Punta Arenas.
%
%   Example:
%   I = imread('wheel.png');                          % Input image
%   K  = [1.1 0 235; 0 1.1 305; 0 0 1];               % Transformation (x,y)->(u,v)
%   S  = [Xmatrixr3(0,0,0) [-36 40 1000]'; 0 0 0 1];  % Transformation (X,Y,Z)->(Xb,Yb,Zb)
%   Se = [Xmatrixr3(0,0,pi/3) [0 0 0]'; 0 0 0 1];     % Transformation (Xp,Yp,Zp)->(X,Y,Z)
%   J  = Xsimdefect(I,K,S*Se,1500,[3 4 3],0.1,400,1); % Simulation

function [J,R] = Xsimdefect(I,K,SSe,f,abc,var_mu,xmax,show)

if ~exist('show','var')
    show = 0;
end

I     = double(I);
J     = I;
[N,M] = size(I);

R = zeros(N,M); % ROI of simulated defect

invK  = inv(K);

if length(abc)==3
    a     = abc(1); b = abc(2); c = abc(3); % elliposoid
else
    a     = abc(1); b = abc(1); c = abc(1); % sphere
end
% Computation of the 3 x 3 matrices Phi and L
H     = inv(SSe);
Hs    = [H(1,1:3)'/a H(2,1:3)'/b H(3,1:3)'/c];
hd    = [H(1,4)/a H(2,4)/b H(3,4)/c]';
Phi   = Hs*Hs';
L     = Hs*(hd*hd')*Hs'+(1-hd'*hd)*Phi;

% Location of the superimposed area
A     = L(1:2,1:2);
mc    = [-f*(A\L(1:2,3)); 1];
C     = eig(A);
la    = eig(A);
a00   = det(L)/det(A);
ae    = f*sqrt(-a00/la(1));
be    = f*sqrt(-a00/la(2));
al    = atan(C(2,1)/C(1,1));
ra    = [ae*cos(al); ae*sin(al); 0];
rb    = [be*cos(al+pi/2); be*sin(al+pi/2); 0];
u1    = funcf(mc+ra,K);
u2    = funcf(mc+rb,K);
u3    = funcf(mc-ra,K);
u4    = funcf(mc-rb,K);
uc    = funcf(mc,K);
e1    = u1+u2-uc;
e2    = u1+u4-uc;
e3    = u3+u2-uc;
e4    = u3+u4-uc;
E     = [e1 e2 e3 e4];
Emax  = max(E,[],2);
Emin  = min(E,[],2);
umin  = max([fix(Emin(1)) 1]);
vmin  = max([fix(Emin(2)) 1]);
umax  = min([fix(Emax(1)+1) N]);
vmax  = min([fix(Emax(2)+1) M]);
q  = 255/(1-exp(var_mu*xmax));
R(umin:umax,vmin:vmax) = 1;
R = imdilate(R,ones(3,3));
for u = umin:umax
    for v = vmin:vmax
        m = funcg([u; v; 1],invK);
        m(1:2) = m(1:2)/f;
        p = m'*L*m;
        if p>0
            d = 2*sqrt(p)*norm(m)/(m'*Phi*m);
            J(u,v) = exp(var_mu*d)*(I(u,v)-q)+q;
        end
    end
end

if show
    figure(1)
    imshow(I/255); title('original image');
    figure(2)
    imshow(J/255); title('image with simulated defect');
    hold on
    d = 0.01*max([N M]);
    vmin = vmin-d; umin = umin-d; vmax = vmax+d; umax = umax+d; 
    plot([vmin vmin vmax vmax vmin],[umax umin umin umax umax],'r')
end
end

% transformation u = f(m) 
function u = funcf(m,K)
u = K*m;
end

% transformation m = g(u) 
function m = funcg(u,invK)
m = invK*u;
end



