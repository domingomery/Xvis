function [TP,FP,P,N] = Xdetectionstats(group,series,GTfile,imgs,fdetection,params,pascalth,show)

n = length(params);
m = max(imgs);
TP = zeros(n,1);
FP = zeros(n,1);
P  = zeros(n,1);
N  = zeros(n,1);

GT = Xloaddata(group,series,GTfile);


for i=1:n
    i
    p = params(i);
    TPk = zeros(m,1);
    FPk = zeros(m,1);
    Pk  = zeros(m,1);
    Nk  = zeros(m,1);
    if ~isfield(p,'areamin')
        s = 2;
    else
        s = sqrt(p.areamin);
    end
    for k=imgs
        ii = GT(:,1)==k;
        bb = GT(ii,2:end);
        I = Xloadimg(group,series,k);
        R = feval(fdetection,I,p);
        E = edge(I,'log',1e-8,s);
        [~,r] = bwlabel(not(E),4);
        [TPk(k),FPk(k),Pk(k)] = Xpascalstats(I,R,bb,0,pascalth,show);
        Nk(k) = r-Pk(k);
    end
    TP(i) = sum(TPk);
    FP(i) = sum(FPk);
    P(i)  = sum(Pk);
    N(i)  = sum(Nk);
end