% [X,d] = Xgaussgen(m,s,n)
%
% Toolbox Xvis
% 
%    Gaussian Random Sample Generator.
%    m matrix qxp. m(i,j) is mean of class i for feature j
%    s matrix qxp. s(i,j) is std of class i for feature j
%    n vector qx1. n(i) is number of samples of class i
%
%    Example for two classes and two features:
%       [X,d] = Xgaussgen([10 1;1 10],4*ones(2,2),500*ones(2,1));
%       Xplotfeatures(X,d)
%
%    Example for three classes and two features:
%       [X,d] = Xgaussgen([2 1;1 2;2 2],ones(3,2)/4,500*ones(3,1));
%       Xplotfeatures(X,d)

function [X,d] = Xgaussgen(m,s,n)

q = length(n); % number of classes
p = size(m,2); % number of features
N = sum(n);    % number of samples
X = zeros(N,p);
d = zeros(N,1);
t = 1;
for i=1:q
    d(t:t+n(i)-1) = i;
    x = zeros(n(i),p);
    for j=1:p
        x(:,j) = s(i,j)*randn(n(i),1)+m(i,j);
    end
    X(t:t+n(i)-1,:) = x;
    t = t+n(i);
end
