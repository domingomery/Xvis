% ShadingCorrection.m

R1 = fspecial('Gaussian',256,80); R1=R1/max(R1(:))*0.8; % X-ray image of a thin plate
i1 = 0.8;                                               % ideal gray value for R1
R2 = fspecial('Gaussian',256,60); R2=R2/max(R2(:))*0.6; % X-ray image of a thick plate
i2 = 0.4;                                               % ideal gray value for R2

X  = fspecial('Gaussian',256,70); X=X/max(X(:))*0.7;    % simulation of a X-ray image
X(30:80,30:80)  = X(30:80,30:80)*1.5;                   % with a square cacity

figure(1)
imshow(X,[])                                            % input image
figure(2)
Y = Xshading(X,R1,R2,i1,i2);                            % output image
imshow(Y,[])
