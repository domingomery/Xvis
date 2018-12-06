% AppleBasicGeoFeatures.m
I = Xloadimg('N',1,4)';                             % X-ray of apples
I = I(300:1000,100:2000);                           % input image
J = and(I>60,I<110);
K = imerode(bwfill(J,'holes'),ones(11,11));         % segmentation
[L,n]=bwlabel(K,4);                                 % regions

X = zeros(n,15);                                    % features
E = zeros(size(I));                                 % edges of the regions
imshow(I);hold on
for i=1:n
    Ri      = imdilate(L==i,ones(11,11));
    E       = or(E,bwperim(Ri));
    X(i,:)  = Xbasicgeo(Ri);                        % basic geo-features
    text(X(i,2),X(i,1),sprintf('%d',i),...
        'color','b','fontsize',12)                  % output
end
[ii,jj] = find(E==1); plot(jj,ii,'r.')              % display edges
X/1000                                              % features divided by 1000
