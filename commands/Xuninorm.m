% Xnew = Xuninorm(X)
%
% Toolbox Xvis
%
%    Normalization of features X: each row of Xnew has norm = 1
%
% Example:
%    load datafish
%    Xnew = Xuninorm(f);

function Xnew = Xuninorm(X)

[N,M] = size(X);
Xnew  = zeros(N,M);
for i=1:N
    Xnew(i,:) = X(i,:)/norm(X(i,:));
end
