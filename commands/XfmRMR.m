% selec = XfmRMR(X,d,options)
%
% Toolbox Xvis:
%    Feature selection using Criteria of Max-Dependency, Max-Relevance, and
%    Min-Redundancy after Peng et al. (2005)
%
%    X extracted features (NxM): N samples, M features
%    d ideal classification (Nx!) for the N samples
%    options.m number of selected features
%    options.p a priori probability of each class (if not given, is
%    estimated using the ratio samples per class to N.
%
% References:
%   Peng, H.; Long, F.; Ding, C. (2005): Feature Selection Based on Mutual 
%   Information: Criteria of Max-Dependency, Max-Relevance, and Min-
%   Redundancy. IEEE Trans. on Pattern Analysis and Machine Intelligence, 
%   27(8):1226-1238.
%
%   Z. I. Botev, J. F. Grotowski, and D. P. Kroese (2010): Kernel density 
%   estimation via diffusion Annals of Statistics, 38(5):2916-2957. 
%
% NOTE:
%    The pdf's are estimated using Kernel Density Estimations programs 
%    kde.m and kde2d.m after Botev et al. (2010) implemented by Botev. 
%    These files are in Xvis directory 'misc'. They can also be downloaded 
%    from www.mathwork.com (c) Zdravko Botev. All rights reserved.
%
% Example (comparison between SFS-Fisher and mRMR): 
%
%    load datafish
%    s = Xfclean(X,1);
%    X = X(:,s);
%    k = 0;
%    k=k+1;c(k).name = 'knn';     c(k).options.k = 9;               % KNN with 9 neighbors
%    k=k+1;c(k).name = 'lda';     c(k).options.p = [];              % LDA
%    k=k+1;c(k).name = 'qda';     c(k).options.p = [];              % QDA
%    k=k+1;c(k).name = 'dmin';    c(k).options = [];                % Euclidean distance
%    k=k+1;c(k).name = 'maha';    c(k).options = [];                % Mahalanobis distance
%    k=k+1;c(k).name = 'svm';     c(k).options.kernel = '-t 2';     % rbf-SVM
%
%    op.strat=1; op.c = c; op.v = 10; op.show = 1; op.p = 0.95;     % 10 groups cross-validation
%
%    msel1 = 8;
%    msel2 = 8;
%    
%    op1.p = 8;op1.show=1;op1.b.name='fisher';
%    s1    = Xsfs(X,d,op1);
%    X1    = X(:,s1);
%    disp('Performances using SFS-Fisher:')
%    p1    = Xcrossval(X1(:,1:msel2),d,op);
%    
%    op2.p = 8;op2.show=1;                    
%    s2    = XfmRMR(X1,d,op2);
%    disp(' ')
%    disp('Performances using SFS-mRMR:')
%    p2 = Xcrossval(X1(:,s2),d,op); 
%    disp(' ')
%    disp('Comparison of performances and mean of performances:')
%    [p1 p2], mean([p1 p2])

function s = XfmRMR(X,d,options)

if ~isfield(options,'p')
    dn = max(d)-min(d)+1; % number of classes
    p = ones(dn,1)/dn;
else
    p = options.p;
end

if ~isfield(options,'show')
    show = 0;
else
    show = options.show;
end

% T = 100;

M  = size(X,2);
n  = options.p;
s  = zeros(n,1);
t  = ones(M,1);
h  = zeros(n,1);
ff = statusbar('XfmRMR');

Ic = zeros(M,1);
m  = 1;
for j=1:M
    Ic(j) = Xparzen2([X(:,j) d],1,p); % see in paper I(xj;c)
end
ff = statusbar(1/n,ff);
Ic = real(Ic);
[Icmax,jsel] = max(Ic);
if show
    clf
    h(m) = Icmax;
    bar(h);
end

s(m)    = jsel;
t(jsel) = 0;


MI = zeros(M,M);

if n>1
    for m=2:n
        
        Jmax = -Inf;
        for j=1:M
            if t(j)==1 % if yes, feature j is not selected 
                xj = X(:,j);
                sumI = 0;
                for i=1:m-1
                    xi = X(:,s(i));
                    if MI(s(i),j)==0;
                        mij = Xparzen2([xj xi]);
                        MI(s(i),j) = mij;
                        MI(j,s(i)) = mij;
                    else
                        mij = MI(s(i),j);
                    end
                    sumI = sumI + mij; % see in paper I(xj;xi)
                end
                Jj = real(Ic(j)/(sumI/(m-1)));
                if Jj>Jmax
                    Jmax = real(Jj);
                    jsel = j;
                end
            end
        end
        s(m)    = jsel;
        t(jsel) = 0;
        if show
            h(m) = Jmax;
            bar(h)
        end
    ff = statusbar(m/n,ff);
    end
end
delete(ff)


