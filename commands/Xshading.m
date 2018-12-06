% Y = Xshading(X,R1,R2,i1,i2)
%
% Toolbox XVis: Shading correction.
%
%    There are two reference images: image R1, of a thin plate, image r2, 
%    of a thick plate. The gray values i1 and i2 are the ideal gray values 
%    for the first and second image, respectively. From r1, r2, i1 and i2, 
%    offset and gain, correction matrices A and B are calculated assuming a 
%    linear transformation between the original X-ray image X and 
%    corrected X-ray image y.
%
%    Example:
%    R1 = fspecial('Gaussian',256,80); R1=R1/max(R1(:))*0.8; % X-ray image of a thin plate
%    i1 = 0.8;                                               % ideal gray value for R1
%    R2 = fspecial('Gaussian',256,60); R2=R2/max(R2(:))*0.6; % X-ray image of a thick plate
%    i2 = 0.4;                                               % ideal gray value for R2
%    X  = fspecial('Gaussian',256,70); X=X/max(X(:))*0.7;    % simulation of a X-ray image
%    X(30:80,30:80)  = X(30:80,30:80)*1.5;                   % with a square cacity
%    Y = Xshading(X,R1,R2,i1,i2)                             % shading correction
%    figure(1);imshow(X,[])                                  % input image
%    figure(2);imshow(Y,[])                                  % output image

function [Y,A,B] = Xshading(X,R1,R2,i1,i2)
A = (i2-i1)./(R2-R1);
B = i1-R1.*A;
Y = A.*X+B;