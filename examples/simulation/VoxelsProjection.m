close all
II = [];
for kk=1:8
Nv = 1800;
i0 = Nv/2; j0 = Nv/2;
V = false(Nv,Nv,Nv);

% two cubes
%V(45:54,45:54,45:64) = 1;
%V(50:59,50:59,50:69) = 1;

% a ring
% for i=1:Nv
%     for j=1:Nv
%         r = sqrt((i-50)^2+(j-50)^2);
%         if abs(r-30)<5
%             V(i,j,45:54) = 1;
%         end
%     end
% end


% a cilinder: z:k1,..., k2, radius r1
r1 = Nv*0.35; k1=0.40*Nv; k2=0.59*Nv;
for i=1:Nv
    for j=1:Nv
        r = sqrt((double(i)-i0)^2+(double(j)-j0)^2);
        if r<r1
            V(i,j,k1:k2) = true;
        end
    end
end

r5 = 0.02*Nv;
for i=1:Nv
    for j=1:Nv
        for k=k1:k2
            r = sqrt((double(i)-(i0+0.33*Nv))^2+(double(j)-j0)^2+(double(k)-0.50*Nv)^2);
            if r<r5
                V(i,j,k) = false;
            end
        end
    end
end

disp('*')


[X,Y,Z] = ind2sub(size(V),find(V==1));
r2 = 0.30*Nv; k1p = 0.48*Nv; k2p = 0.51*Nv;
for i=1:length(X)
    if or(Z(i)>k2p,Z(i)<k1p)
        r = sqrt((X(i)-i0)^2+(Y(i)-j0)^2);
        if r<r2
            V(X(i),Y(i),Z(i)) = false;
        end
    end
end

[X,Y,Z] = ind2sub(size(V),find(V==1));

for i=1:length(X)
    %    if or(Z(i)>k2p,Z(i)<k1p)
    cp = X(i)-i0 +sqrt(-1)*(Y(i)-j0);
    r = abs(cp);
    a = (angle(cp)+pi)/2/pi;
    an = round(a*16);
    if round(an/2)*2==an
        if and(r<r2,r>10)
            V(X(i),Y(i),Z(i)) = false;
        end
    end
    %    end
end

[X,Y,Z] = ind2sub(size(V),find(V==1));

X = X/7; Y = Y/7; Z = Z/7;

n = length(X);

% Transformation (x,y)->(u,v)
u0 = 235; v0 = 305; ax = 1.1; ay = 1.1;       % translation and scaling
K  = [ax 0 u0; 0 ay v0; 0 0 1];               % transformation matrix

% Transformation (Xb,Yb,Zb)->(x,y)
f  = 1500;                                    % focal length
B  = [f 0 0 0; 0 f 0 0; 0 0 1 0];

% Transformation (X,Y,Z)->(Xb,Yb,Zb)
R  = Xmatrixr3(0,pi/2,0);                        % rotation
t  = [150 150 1000]';                          % translation
S  = [R t; 0 0 0 1];                          % transformation matrix

% Transformation (Xp,Yp,Zp)->(X,Y,Z)
Re = Xmatrixr3(-pi/4,0.15*kk,pi/3);                     % rotation
te = [0 0 0]';                                % translation
Se = [Re te; 0 0 0 1];                        % transformation matrix

P = K*B*S*Se;

M = [X'; Y' ; Z'; ones(1,n)];

w = Xh2nh(P*M);
figure(1)
plot(w(1,:),w(2,:),'r.')

figure(2)
plot3(X,Y,Z,'.')
axis([0 Nv 0 Nv 0 Nv])

N = 512; M = 512;

I = zeros(N,M);

%h = ones(7,7);
h = fspecial('gaussian',3,0.5);
%h = ones(3,3);
h = h/max2(h);
m = size(h,1);
m2 = floor(m/2);


for i=1:n
    i1 = floor(w(1,i)); j1 = floor(w(2,i));
    if i1>0 && j1>0 && i1<N && j1<M
        i2 = i1+1;          j2 = j1+1;
        a1 = w(1,i)-i1;     b1 = w(2,i)-j1;
        a2 = 1-a1;          b2 = 1-b1;
        I(i1,j1) = I(i1,j1) + a2*b2;
        I(i1,j2) = I(i1,j2) + a2*b1;
        I(i2,j1) = I(i2,j1) + a1*b2;
        I(i2,j2) = I(i2,j2) + a1*a1;
    end
end





% w = round(w);
%
% w1 = w(1,:); w2= w(2,:);
% i1 = and(w1>m2,w1<=(N-m2));
% j1 = and(w2>m2,w2<=(M-m2));
% ii = find(and(i1,j1)==1);
% n = length(ii);
%
% for i=1:n
%     i1 = w(1,ii(i))-m2;i2 = w(1,ii(i))+m2;
%     j1 = w(2,ii(i))-m2;j2 = w(2,ii(i))+m2;
%     I(i1:i2,j1:j2) = I(i1:i2,j1:j2)+h;
% end
%
% % for i=1:n
% %     i1 = w(1,i)-m2;i2 = w(1,i)+m2;
% %     j1 = w(2,i)-m2;j2 = w(2,i)+m2;
% %     if i1>m2 && j1>m2 && i2<=(N-m2) && j2<=(M-m2)
% %     I(i1:i2,j1:j2) = I(i1:i2,j1:j2)+h;
% %     end
% % end






II = [II I];
save II II
figure(3);
imshow(exp(-0.001*II),[])
drawnow
end


