% SIFTmatching.m

I1 = single(Xloadimg('B',2,1));          % image 1
I2 = single(Xloadimg('B',2,2));          % image 2
figure(1); imshow(I1,[]); hold on
figure(2); imshow(I2,[]); hold on
[f1,d1] = vl_sift(I1);                   % SIFT descriptors for image 1
[f2,d2] = vl_sift(I2);                   % SIFT descriptors for image 2
[mt,sc] = vl_ubcmatch(d1,d2);            % matching points
[ii,jj] = sort(sc);                      % sort of scores
mt = mt(:,jj); sc = sc(:,jj);
n = 25;                                  % the best 25 matchings are selected

figure(1)                                % display results on image 1
h1 = vl_plotsiftdescriptor(d1(:,mt(1,1:n)),f1(:,mt(1,1:n))) ;
set(h1,'color','g') ;
for i=1:n
    plot(f1(1,mt(1,i)),f1(2,mt(1,i)),'ro')
    text(f1(1,mt(1,i))+5,f1(2,mt(1,i)),num2str(i),'fontsize',15)
end

figure(2)                                % display results on image 2
h2 = vl_plotsiftdescriptor(d2(:,mt(2,1:n)),f2(:,mt(2,1:n))) ;
set(h2,'color','g') ;
for i=1:n
    plot(f2(1,mt(2,i)),f2(2,mt(2,i)),'ro')
    text(f2(1,mt(2,i))+5,f2(2,mt(2,i)),num2str(i),'fontsize',15)
end
