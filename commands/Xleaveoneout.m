% [T,p] = Xleaveoneout(X,d,options)
%
% Toolbox Xvis
%    Jackknife evaluation of a classifier.
%
%    v-fold Cross Validation in v groups of samples X, where v is the
%    number of samples (i.e., v = size(X,1)). The training will be in X 
%    without sample i and testing in sample i. ci is the confidence interval.
%
%    X is a matrix with features (columns)
%    d is the ideal classification for X
%
%    options.c is a Xvis classifier or several classifiers (see example)
%    options.p is the probability of the confidence intervale.
%    options.show displays results.
%
%    The mean performance of classifier k is given in acc(k), and the
%    confidence intervals for c*100% are in ci(k,:).
%
%    Example for one classifier:
%       load datasim                              % simulated data (2 classes, 2 features)
%       X = [Xtrain; Xtest]; d = [dtrain; dtest]; % all data
%       Xplotfeatures(X,d)                        % plot feature space
%       c.name = 'knn'; c.options.k = 5;          % knn with 5 neighbors
%       op.c = c; op.p = 0.90; op.show = 0;       % confidence intervale for 90
%       [acc,ci] = Xleaveoneout(X,d,op)           % leaveoneout
%
%    Example for more classifiers:
%       load datagauss                                           % simulated data (2 classes, 2 features)
%       k = 0;
%       k=k+1;c(k).name = 'knn';   c(k).options.k = 5;           % KNN with 5 neighbors
%       k=k+1;c(k).name = 'knn';   c(k).options.k = 7;           % KNN with 7 neighbors
%       k=k+1;c(k).name = 'knn';   c(k).options.k = 9;           % KNN with 9 neighbors
%       k=k+1;c(k).name = 'lda';   c(k).options.p = [];          % LDA
%       k=k+1;c(k).name = 'qda';   c(k).options.p = [];          % QDA
%       k=k+1;c(k).name = 'svm';   c(k).options.kernel = '-t 2'; % rbf-SVM
%       k=k+1;c(k).name = 'dmin';  c(k).options = [];            % Euclidean distance
%       k=k+1;c(k).name = 'maha';  c(k).options = [];            % Mahalanobis distance
%       op.c = c; op.p = 0.95; op.show = 0;                      % confidence intervale for 90
%       [acc,ci] = Xleaveoneout(X,d,op);                         % leaveoneout

function [acc,ci] = Xleaveoneout(X,d,options)
options.v = size(X,1);
options.strat = 0;
[acc,ci] = Xcrossval(X,d,options);
