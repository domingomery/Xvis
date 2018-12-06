% AppleBasicIntFeatures.m
close all
I = Xloadimg('N',1,4)';                             % X-ray of apples
I = I(300:1000,100:2000);                           % input image
J = and(I>60,I<110);
K = imerode(bwfill(J,'holes'),ones(11,11));         % segmentation
[L,n]=bwlabel(K,4);                                 % regions

X = zeros(n,6);                                     % features
E = zeros(size(I));                                 % edges of the regions
imshow(I);hold on
op.mask = 15; op.show = 0;
for i=1:n
    Ri      = imdilate(L==i,ones(11,11));
    E       = or(E,bwperim(Ri));
    X(i,:)  = Xbasicint(I,Ri,op);                   % basic int-features
    c       = Xcentroid(Ri);                        % centroid
    text(c(2),c(1),sprintf('%d',i),...
        'color','b','fontsize',12)                  % output
end
[ii,jj] = find(E==1); plot(jj,ii,'r.')              % display edges
X                                                   % features