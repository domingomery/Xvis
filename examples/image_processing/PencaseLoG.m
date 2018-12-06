% PencaseLoG.m

close all
X = Xloadimg('B',2,1);                            % input image
X = imresize(X,0.5);                              % resize of input image
X = X(595:714,1:120);                             % selected area
figure(1)
imshow(X); title('input image');

threshold = [1e-8 1e-6 1e-5 1e-3 1e-2]            % different threshold values
sigma     = [0.5 1 2 3 4 6 8]                     % different sigma values

II = [];
for t = threshold                                 % for all thresholds
    JJ = [];
    for s=sigma                                   % for all simgas
        E = edge(X,'log',t,s);                    % edge detection
        JJ = [JJ E];                              % row of edge images
    end
    II = [II;JJ];                                 % rows concatenation
end
figure(2)
imshow(II,[])
xlabel('sigma'); ylabel('threshold')