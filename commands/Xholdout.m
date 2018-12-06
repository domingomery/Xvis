% [acc,CMatrix] = Xholdout(X,d,options)
%
% Toolbox Xvis
%    Holdout evaluation of a classifier.
%
%    X is a matrix with features (columns)
%    d is the ideal classification for X
%
%    options.c is a Xvis classifier or several classifiers (see example)
%    options.s is the portion of data used for training, e.g. s=0.75.
%    options.strat = 1 means the portion is stratified.
%
%    Confusion matrix is given file by file for each group in matrix CMatrix.
%    The accuracy in each group is given vector acc.
%
%    Example for one classifier:
%       load datasim                              % simulated data (2 classes, 2 features)
%       X = [Xtrain; Xtest]; d = [dtrain; dtest]; % all data
%       Xplotfeatures(X,d)                        % plot feature space
%       c.name = 'knn'; c.options.k = 5;          % knn with 5 neighbors
%       op.c = c; op.strat = 1;op.s = 0.75;       % stratify with 75% train
%       [acc,CMatrix] = Xholdout(X,d,op)          % holdout
%
%    Example for more classifiers:
%       load datasim                                                          % simulated data (2 classes, 2 features)
%       X = [Xtrain; Xtest]; d = [dtrain; dtest];                             % all data
%       k = 0;
%       k=k+1;c(k).name = 'knn';   c(k).options.k = 5;                        % KNN with 5 neighbors
%       k=k+1;c(k).name = 'knn';   c(k).options.k = 7;                        % KNN with 7 neighbors
%       k=k+1;c(k).name = 'knn';   c(k).options.k = 9;                        % KNN with 9 neighbors
%       k=k+1;c(k).name = 'lda';   c(k).options.p = [];                       % LDA
%       k=k+1;c(k).name = 'qda';   c(k).options.p = [];                       % QDA
%       k=k+1;c(k).name = 'svm';   c(k).options.kernel = '-t 2';              % rbf-SVM
%       k=k+1;c(k).name = 'dmin';  c(k).options = [];                         % Euclidean distance
%       k=k+1;c(k).name = 'maha';  c(k).options = [];                         % Mahalanobis distance
%       op.c = c; op.strat = 1; op.s = 0.75;                                  % stratify with 75% train
%       [acc,CMatrix] = Xholdout(X,d,op)                                      % holdout

function [acc,CMatrix] = Xholdout(X,d,options)

strat = options.strat;
c     = options.c;
s     = options.s;

if isfield(options,'show')
    show = options.show;
else
    show = 0;
end


if (strat)
    [XX,dd,XXt,ddt] = Xstratify(X,d,s);
else
    [XX,dd,XXt,ddt] = Xnostratify(X,d,s);
end

[dds,op] = Xclassify(XX,dd,XXt,c);

nn   = min(d):max(d);
m = length(nn);
n    = length(c);
CMatrix = zeros(m,m,n);
acc = zeros(n,1);

for i=1:n
    [TT,pp] = Xconfusion(ddt,dds(:,i),nn);
    CMatrix(:,:,i) = TT;
    acc(i) = pp;
    if show
        s = op(i).options.string;
        fprintf('%3d) %s  %5.2f%% \n',i,s,acc(i)*100);
    end


end

