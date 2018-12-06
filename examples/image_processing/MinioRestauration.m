% MinioRestauration.m
F  = Xloadimg('B',46,90);                        % original image
n  = 128;                                        % amount of blur in pixels
h  = ones(1,n)/n;                                % PSF
G  = conv2(double(F),h,'valid');                 % degradation
Fs = Xresminio(G,h);                             % restoration
figure(1)
imshow(F,[]) ;title('original image');
figure(2)
imshow(G,[]) ;title('degraded image');
figure(3)
imshow(Fs,[]);title('restored image');
