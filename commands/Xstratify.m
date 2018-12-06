% [X1,d1,X2,d2] = Xstratify(X,d,s)
%
% Toolbox Xvis:
%
%    Data Stratification (without replacement)
%
%    input: (X,d) means features and ideal classification
%    Xstratify takes randomily a portion s (s between 0 and 1) of each class
%    from (X,d) to build (X1,d1). The samples not used in (X1,d1) are
%    stored in (X2,d2).

function [X1,d1,X2,d2,i1,i2] = Xstratify(X,d,s)


dmin = int8(min(d));
dmax = int8(max(d));

i1 = [];
i2 = [];

for k=dmin:dmax
    ik = find(d==k);
    dk = d(ik);
    nk = length(dk);
    rk = rand(nk,1);
    [~,j] = sort(rk);
    sk = ceil(s*nk);
    if (sk>0)
        i1 = [i1; ik(j(1:sk))];
    end
    if (sk<nk)
        i2 = [i2; ik(j(sk+1:nk))];
    end
end

X1 = X(i1,:); d1 = d(i1);
X2 = X(i2,:); d2 = d(i2);


