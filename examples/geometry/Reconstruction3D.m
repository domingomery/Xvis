% Reconstruction3D.m
close all

Data = Xloaddata('B',44,'Pmatrices'); % projection matrices

p = 1; q = 40; r = 90;                % p, q and r indices
Ip = Xloadimg('B',44,p);
Iq = Xloadimg('B',44,q);
Ir = Xloadimg('B',44,r);
figure(1);imshow(Ip);title('Image p');hold on
figure(2);imshow(Iq);title('Image q');hold on
figure(3);imshow(Ir);title('Image r');hold on

P1 = Data.P(:,:,p);                   % projection matrix of view p
P2 = Data.P(:,:,q);                   % projection matrix of view q
P3 = Data.P(:,:,r);                   % projection matrix of view q
P = [P1;P2;P3];                       % all projection matrices

figure(1);disp('click first and second points in Figure 1...')
m1 = [ginput(2) ones(2,1)]';          % click
plot(m1(1,:),m1(2,:), 'r*')
plot(m1(1,:),m1(2,:), 'g')

figure(2);disp('click first and second points in Figure 2...')
m2 = [ginput(2) ones(2,1)]';          % click
plot(m2(1,:),m2(2,:), 'r*')
plot(m2(1,:),m2(2,:), 'g')

figure(3);disp('click first and second points in Figure 3...')
m3 = [ginput(2) ones(2,1)]';          % click
plot(m3(1,:),m3(2,:), 'r*')
plot(m3(1,:),m3(2,:), 'g')

mm_1 = [m1(:,1) m2(:,1) m3(:,1)];     % first 2D point in each view
mm_2 = [m1(:,2) m2(:,2) m3(:,2)];     % second 2D point in each view
M1 = Bmv_reco3dn(mm_1,P);             % 3D reconstruction of first point
M2 = Bmv_reco3dn(mm_2,P);             % 3D reconstruction of second point

Md = M1(1:3)-M2(1:3);                 % 3D vector from 1st to 2nd point
dist = norm(Md)                       % length of 3D vector in mm

