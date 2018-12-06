% [Xnew,a,b] = Xfnorm(X,normtype)
%
% Toolbox Xvis
%
%    Normalization of features X.
%    normtype = 1 for variance = 1 and mean = 0
%    normtype = 0 for max = 1, min = 0
%
%    Xnew = a*X + b
%
% Example:
%    load datafish
%    X = f(:,1:2);
%    figure(1); Xplotfeatures(X,d);
%    Xnew = Xfnorm(X,0); 
%    figure(2); Xplotfeatures(Xnew,d);

function [Xnew,a,b] = Xfnorm(X,normtype)

[N,M] = size(X);
if (normtype)
    mf    = mean(X);
    sf    = std(X);
    a     = ones(1,M)./sf;
    b     = -mf./sf;
else
    mi    = min(X);
    ma    = max(X);
    md    = ma-mi + (ma==mi);    
    a     = ones(1,M)./md;
    b     = -mi./md;
end
Xnew = X.*(ones(N,1)*a) + ones(N,1)*b;