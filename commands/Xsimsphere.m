% J = Xsimsphere(I,K,SSe,f,r,var_mu,xmax,show)
%
% Toolbox Xvis: Simulation of defects
%
%    I     : original image
%    K     : 3x3 matrix of Transformation (x,y)->(u,v)
%    SSe   : S*Se
%    S     : 4x4 matrix of Transformation (X,Y,Z)->(Xb,Yb,Zb)
%    Se    : 4x4 matrix of Transformation (Xp,Yp,Zp)->(X,Y,Z)
%    f     : focal distance
%    r     : radius of sphere
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
%   J  = Xsimsphere(I,K,S*Se,1500,3,0.1,400,1);       % Simulation

function I = Xsimsphere(I,K,SSe,f,r,var_mu,xmax,show)

if ~exist('show','var')
    show = 0;
end

I     = double(I);
J     = I;
[N,M] = size(I);

invK  = inv(K);

a = r; b = r; c = r;



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
q     = 255/(1-exp(var_mu*xmax));
c     = H(1,4)^2+H(2,4)^2+H(3,4)^2-r^2;
for u = umin:umax
    for v = vmin:vmax
        m = funcg([u; v; 1],invK);
        x = m(1); y = m(2);
        A1 = H(1,1:3)*[x y f]';
        A2 = H(2,1:3)*[x y f]';
        A3 = H(3,1:3)*[x y f]';
        
        a = A1^2+A2^2+A3^2;
        b = 2*(A1*H(1,4)+A2*H(2,4)+A3*H(3,4));
        D = b^2-4*a*c;
        if D>0
            Z1 = f*(-b+sqrt(D))/2/a; X1=x*Z1/f; Y1=y*Z1/f; M1= [X1 Y1 Z1];
            Z2 = f*(-b-sqrt(D))/2/a; X2=x*Z2/f; Y2=y*Z2/f; M2= [X2 Y2 Z2];
            d = norm(M1-M2);
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



