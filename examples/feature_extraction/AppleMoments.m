% AppleMoments.m
I = Xloadimg('N',1,4);                                     % X-ray of apples
I(  50: 249,1500:1599) = 90;
I(1500:1599,1550:1749) = 90;
I(  50: 449,1700:1899) = 90;
I(1800:1899,2050:2249) = 90;
I( 350: 749,2000:2199) = 90;
I(1050:1249,2000:2099) = 90;
imshow(I); hold on
J = and(I>60,I<110);
K = imerode(bwfill(J,'holes'),ones(11,11));                 % segmentation
[L,n]=bwlabel(K,4);                                         % regions
X = zeros(n,7);
for i=1:n
    Ri      = imdilate(L==i,ones(11,11));
    c       = Xcentroid(Ri);                                % mass center
    X(i,:)  = Xhugeo(Ri);                                   % Hu moments
    text(c(2)-55,c(1),sprintf('%4.0f',X(i,1)*1000),...
        'color','b','fontsize',12)                          % output
end
E = bwperim(K);
[ii,jj] = find(E==1); plot(jj,ii,'y.')                      % display edges
