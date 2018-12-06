% PencaseGradient.m

close all
X   = Xloadimg('B',2,1);                             % input image
X   = imresize(X,0.25);                              % resize of input image
figure(1)
imshow(X); title('input image');

hs  = fspecial('sobel')';                            % sobel operator
hp  = fspecial('prewitt')';                          % prewitt operator
hg  = conv2(fspecial('gaussian',9,1),[-1 1],'same'); % gaussian operator

Gs  = Ximgrad(X,hs);                                 % Gradient for sobel
Gp  = Ximgrad(X,hp);                                 % ... prewitt
Gg  = Ximgrad(X,hg );                                % ... gaussian  

G   = [Xlinimg(Gs) Xlinimg(Gp) Xlinimg(Gg)];         % output image
figure(2)
imshow(G); title('Original and Gradients (Sobel, Prewitt and Gaussian )')

figure(3)
Y = log(Gg+1);                                       % log representation            
mesh(Y(5:end-5,end-5:-1:5)); title('3D representation of Gaussian output');
colorbar; view(-178,74); axis off

figure(4)
imshow(Y>3); title('Edge detection');                % edge detection
