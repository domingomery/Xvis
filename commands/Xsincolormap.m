% map = Xsincolormap(k,a,w,th)
%
% Toolbox Xvis: sin color map for pseudo coloring.
%
%    Input data:
%       X    : Xray image.
%       scale: X is resized using command imresize. This parameter
%              corresponds to parameter SCALE or [NUMROWS NUMCOLS] of imreize.
%       pos  : 1 for positive 3D representation, 0 for negative.
%
%    Output:
%       Y: Output image.
%
%    Example:
%       w   = ones(3,1)*4*pi/3/255;
%       k   = 0.5*ones(3,1);
%       a   = 0.5*ones(3,1);
%       th = [0 -2*pi/3 -4*pi/3];
%       map = Xsincolormap(k,a,w,th);
%       I = Xloadimg('C',3,2,1);
%       Xpseudocolor(I,map);


function map = Xsincolormap(k,a,w,th)

map = zeros(256,3);

x = 1:256;

map(:,1) = abs(a(1)+k(1)*(cos(w(1)*x + th(1))));
map(:,2) = abs(a(2)+k(2)*(cos(w(2)*x + th(2))));
map(:,3) = abs(a(3)+k(3)*(cos(w(3)*x + th(3))));

