% ROCPerformance.m
close all;
GT = Xloaddata('C',21,'ground_truth.txt');

ok = 0;
n = 37;
TP = zeros(n,1);
FP = zeros(n,1);
D  = zeros(n,1);

for k=1:n
    fprintf('Processing image %2d/%2d...\n',k,n);
    I = Xloadimg('C',21,k);
    ii = find(GT(:,1)==k);
    bb = GT(ii,2:end);
    X  = Ximgaussian(I,5);                            % low pass filtering
    Y0 = Ximmedian(X,23);
    Y1 = abs(double(X)-double(Y0));
    Y2 = Y1>8;
    Y3 = bwareaopen(Y2,20);
    Y = imclearborder(imdilate(Y3,ones(17,17)));
    [TP(k),FP(k),D(k),A] = Xpascalstats(X,Y,bb,0,0.5,0);
    drawnow
end