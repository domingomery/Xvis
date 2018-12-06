% AritmeticAverage.m

close all
S  = double(Xloadimg('N',4,1));                          % S = image 1
n = 20;
for k=2:n
    Xk = double(Xloadimg('N',4,k));                      % image k
    imshow(Xk,[]);
    title(['image with noise ' num2str(k)])
    pause(0.25);
    S = S + Xk;                                          % S = S + image k
end
Y = S/n;                                                 % average

figure(2);
imshow(Y,[]);title('filtered image')

figure(3)
plot([Xk(100,:)' Y(100,:)'])                             % profile of row 100
legend({'original','filtered'})
    