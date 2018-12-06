function R = DetectionThreshold(I,params)

sig = params.threshold;

R = Xseglogfeat(I,I<230,[20 200],[0 200],[1.05 2],sig);



% B  = edge(J,'log',1e-10,sig);
% B  = imclearborder(not(B),4);
% [F,m]  = bwlabel(B,4);
% 
% Gmin = 20;
% Gmax = 240;
% Amin = 20;
% Amax = 400;
% D = zeros(size(J));
% for i=1:m
%     iR        = F==i;
%     Area     = sum(iR(:));
%     GrayR    = mean(J(iR));
%     if (Area>= Amin) && (Area<= Amax) && (GrayR>=Gmin) && (GrayR<=Gmax)
%         D = or(D,iR);
%     end
% end
% 
% [R,m] = bwlabel(D);
% fprintf('%d segmented regions.\n',m);
% 
