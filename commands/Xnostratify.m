% [X1,d1,X2,d2] = Bds_nostratify(X,d,s)
%
% Toolbox Xvis
%
%    Data Sampling without Stratification (without replacement)
%
%    input: (X,d) means features and ideal classification
%    Bnostratify takes randomily a portion s (s between 0 and 1) of the
%    whole that without considering the portion of each class
%    from (X,d) to build (X1,d1). The samples not used in (X1,d1) are
%    stored in (X2,d2).

function [X1,d1,X2,d2] = Xnostratify(X,d,s)


N = size(X,1);
rn = rand(N,1);
[~,j] = sort(rn);
Xr = X(j,:);
dr = d(j);
r = fix(s*N);
R = [1 r;r+1 N];
X1 = Xr(R(1,1):R(1,2),:);
d1 = dr(R(1,1):R(1,2),:);
X2 = Xr(R(2,1):R(2,2),:);
d2 = dr(R(2,1):R(2,2),:);
