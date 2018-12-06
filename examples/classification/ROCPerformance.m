% ROCPerformance.m
clt
n = 4;
p(n).areamin = 0;
show = 0;
for i=1:n
    p(i).gaussianmask = 5;
    p(i).medianmask   = 23;
    p(i).threshold    = 8+4*i;
    p(i).areamin      = 20;
    p(i).dilationmask = 17;
end
pascalth = 0.5;
[TP,FP,P,N] = Xdetectionstats('C',21,'ground_truth.txt',...
              1:37,'MedianDetection',p,pascalth,show);
TPR = TP./P;
FPR = FP./N;
Xplotroc(FPR,TPR)