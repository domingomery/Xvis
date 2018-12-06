% Xdrawellipse(v,col)
%
% Toolbox Xvis: It draws n ellipses
%
%    v is a matrix of n x 5 elements, with parameters of n ellipses. The
%    parameters are the following ones:
%
%    mcx   = v(r,1);     % center in x-direction
%    mcy   = v(r,2);     % center in y-direction
%    ae    = v(r,3);     % major axis
%    be    = v(r,4);     % minor axis
%    theta = v(r,5);     % orientation in rad
%
%    col is the color of the ellipse

function Xdrawellipse(v,col)


% draw ellipse with N points
if not(exist('col','var'))
    col = 'b';
end

n = size(v,1);
hold on

for r=1:n
    ae    = v(r,3);
    be    = v(r,4);
    theta = v(r,5);
    mcx   = v(r,2);
    mcy   = v(r,1);

    if n>1
            text(mcx,mcy,num2str(r))
    end

    N = 100;
    dx = 2*pi/N;
    R = [ [ cos(theta) sin(theta)]', [-sin(theta) cos(theta)]'];
    X = zeros(N+1);
    Y = X;
    for i = 1:N
        ang = i*dx;
        x = ae*cos(ang);
        y = be*sin(ang);
        d1 = R*[x y]';
        X(i) = d1(1) + mcx;
        Y(i) = d1(2) + mcy;
    end
    X(N+1) = X(1);
    Y(N+1) = Y(1);
    plot(X,Y,col)

end