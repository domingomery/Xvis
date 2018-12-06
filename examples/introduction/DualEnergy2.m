close all

figure(1)
%I1 = int16(Xloadimg('B',60,1,1))+1;
I1 = Xloadimg('B',60,1,0);
I1 = int16(Xlinimg((double(I1)+1)))+1;
imshow(I1,[])

hold on
figure(2)
%I2 = int16(Xloadimg('B',60,2,1))+1;
I2 = Xloadimg('B',60,2,0);
I2 = int16(Xlinimg(log(double(I2)+1)))+1;
imshow(I2,[])


M = zeros(256,256);
for i=1:256;
    for j=1:256;
        M(i,j)=(log(i)+log(j))^2;
    end;
end

M = M/max2(M);

J = zeros(size(I1));

[n,m] = size(J);

for i=1:n
    for j=1:m
        J(i,j) = M(I2(i,j),I1(i,j));
    end
end

figure(3)
imshow(J*64,parula)
colorbar

figure(4)
mesh(M)

figure(5)
contour(M)
hold on

c = 'bgyrmckbgyrmckbgyrmckbgyrmck';
i = 1;
while (1)
    figure(1)
    p = round(ginput(1));
    plot(p(1),p(2),[c(i) 'x']);
    plot(p(1),p(2),[c(i) 'o']);
    
    figure(5)
    x = I1(p(2),p(1));
    y = I2(p(2),p(1));
    plot(x,y,[c(i) 'x']);
    plot(x,y,[c(i) 'o']);
    
    i = i+1;
end