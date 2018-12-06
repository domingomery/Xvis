% TrifocalGeometry.m
close all

Data = Xloaddata('B',44,'Pmatrices');    % projection matrices

p = 1; q = 90; r = 170;                  % p, q and r indices
Ip = Xloadimg('B',44,p);
Iq = Xloadimg('B',44,q);
Ir = Xloadimg('B',44,r);
figure(1);imshow(Ip);title('Image p');hold on
figure(2);imshow(Iq);title('Image q');hold on
figure(3);imshow(Ir);title('Image r');hold on

Pp = Data.P(:,:,p);                      % projection matrix of view p
Pq = Data.P(:,:,q);                      % projection matrix of view q
Pr = Data.P(:,:,r);                      % projection matrix of view q

T   = Xtrifocal(Pp,Pq,Pr);               % trifocal tensors
disp('click a point mp in Figure 1...')
figure(1);
mp = [ginput(1) 1]';                     % click
plot(mp(1),mp(2), 'g*')
disp('click a point mp in Figure 2...')
figure(2);
mq = [ginput(1) 1]';                     % click
plot(mq(1),mq(2), 'g*')
mr = Xreproj3(mp,mq,T);                  % reprojection of mr from mp, mq and T
figure(3);
plot(mr(1),mr(2), 'g*')
