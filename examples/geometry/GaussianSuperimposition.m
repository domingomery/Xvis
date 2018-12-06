% This function is called by program Calibration.m
% It is an example that shows how to superimpose a 3D Gaussian bell
% onto an image I. The 3x4 projection matrix is given by P

function GaussianSuperimposition(I,P,squareSize)

Xmax   = 10; Ymax = 10;
HH     = fspecial('gaussian',5*Xmax+1,5*1.5);
H      = -5*HH/max2(HH);

MM = [[0    0   Xmax Xmax 0
       Ymax 0   0    Ymax Ymax
       0    0   0    0    0]*squareSize
       1    1   1    1    1];

me = Xh2nh(P*MM);

figure
imshow(I,[]);
hold on


A  = 0:5*Xmax;
B  = ones(1,5*Xmax+1);
for a=A
    % X lines of 3D Gaussian bell
    XX = A; YY = B*a; ZZ = H(XX+1,a+1)';
    m = Xh2nh(P*[squareSize*[XX/5; YY/5; ZZ]; B]);
    plot(m(1,:),m(2,:),'r')
    % Y lines of 3D Gaussian bell
    XX = B*a; YY = A; ZZ = H(a+1,YY+1);
    m = Xh2nh(P*[squareSize*[XX/5; YY/5; ZZ]; B]);
    plot(m(1,:),m(2,:),'r')
end

plot(me(1,:),me(2,:),'m')
text(me(1,3),me(2,3),'X');text(me(1,1),me(2,1),'Y');
text(me(1,2),me(2,2),'O')
