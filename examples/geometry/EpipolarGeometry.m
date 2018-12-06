% EpipolarGeometry.m
close all
Data = Xloaddata('B',44,'Pmatrices'); % projection matrices

p = 1; q = 82;                        % p and q indices
Ip = Xloadimg('B',44,p);
Iq = Xloadimg('B',44,q);
figure(1);imshow(Ip);title('Image p');hold on
figure(2);imshow(Iq);title('Image q');hold on

Pp = Data.P(:,:,p);                   % projection matrix of view p
Pq = Data.P(:,:,q);                   % projection matrix of view q

F = Xfundamental(Pp,Pq);              % fundamental matrix

col = 'bgrcmykw';                     % colors for each point-line pair

for i=1:8    
    disp('click a point mp in Figure 1...')
    figure(1);
    mp = ginput(1)';                  % click
    plot(mp(1),mp(2), [col(i) '*'])
    figure(2)
    Xplotepipolarline(F,mp,col(i));   % Epipolar line
end

