% Y = Xcolorimg(X,scale,pos)
%
% Toolbox Xvis: Display 10 representations of image X.
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
%       I  = Xloadimg('B',2,4);
%       J  = I(250:399,340:529);
%       Y = Xcolorimg(J,[],0);

function Y = Xcolorimg(I,scale,pos)

if ~exist('scale','var')
    scale = [];
end

if ~isempty(scale)
    I = imresize(I,scale);
end
if pos==0
    N  = 255 - I;
else
    N = I;
end
figure

w       = ones(3,1)*4*pi/3/255;
k       = 0.5*ones(3,1);
a       = 0.5*ones(3,1);
th      = [0 -2*pi/3 -4*pi/3];
rainbow = Xsincolormap(k,a,w,th);


w       = [1.25*pi/255 1.25*pi/255 1.25*pi/255]';
k       = ones(3,1);
a       = zeros(3,1);
th      = [pi/3 pi/2 -4*pi/3];
sinmap  = Xsincolormap(k,a,w,th);

figure(2)
subplot(3,3,1); X1 = Xpseudocolor(I,gray)   ;imshow(X1);title('gray')
subplot(3,3,2); X2 = Xpseudocolor(I,jet)    ;imshow(X2);title('jet')
subplot(3,3,3); X3 = Xpseudocolor(I,hsv)    ;imshow(X3);title('hsv')
subplot(3,3,4); X4 = Xpseudocolor(I,parula) ;imshow(X4);title('parula')
subplot(3,3,5); X5 = Xpseudocolor(I,hot)    ;imshow(X5);title('hot')
subplot(3,3,6); X6 = Xpseudocolor(I,rainbow);imshow(X6);title('rainbow')
subplot(3,3,7); X7 = Xpseudocolor(I,sinmap) ;imshow(X7);title('sinmap')
subplot(3,3,8); X8 = Xpseudocolor(I,autumn) ;imshow(X8);title('autumn')
subplot(3,3,9); X9 = Xpseudocolor(I,spring) ;imshow(X9);title('spring')

Y = [X1 X2 X3; X4 X5 X6; X7 X8 X9];

figure
mesh(N); title('3D representation');
if pos
    zlabel('grayvalue')
else
    zlabel('255 - grayvalue')
end
view(-120,60)
colorbar