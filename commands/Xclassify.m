% ds      = Xclassify(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xclassify(Xtrain,dtrain,options)        Training only
% ds      = Xclassify(Xtest,options)                Testing only
%
% Toolbox Xvis:
%    Classification using Xvis classifier(s) defined in structure c.
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options is a Xvis classifier structure b with
%          c.name      = Xvis classifier's name
%          c.options   = options of the classifier
%
%       c can define one or more classifiers (see example).
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data (one column per classifier)
%
%    Example: Training & Test together:
%       load datasim                                                          % simulated data (2 classes, 2 features)
%       c(1).name = 'knn';   c(1).options.k = 5;                              % KNN with 5 neighbors
%       c(2).name = 'knn';   c(2).options.k = 7;                              % KNN with 7 neighbors
%       c(3).name = 'knn';   c(3).options.k = 9;                              % KNN with 9 neighbors
%       c(4).name = 'lda';   c(4).options.p = [];                             % LDA
%       c(5).name = 'qda';   c(5).options.p = [];                             % QDA
%       c(6).name = 'maha';  c(6).options = [];                               % Mahalanobis distance
%       c(7).name = 'libsvm';c(7).options.kernel = '-t 2';                    % rbf-SVM
%       c(8).name = 'dmin';  c(8).options = [];                               % Euclidean distance
%       ds = Xclassify(Xtrain,dtrain,Xtest,c);                                % ds has 8 columns
%       acc = Xaccuracy(ds,dtest)                                             % acc has 8 accuracies
%       Xdecisionline(Xtrain,dtrain,Xn,c);
%
%
%    Example: Training only
%       load datasim                                                          % simulated data (2 classes, 2 features)
%       c(1).name = 'knn';   c(1).options.k = 5;                              % KNN with 5 neighbors
%       c(2).name = 'knn';   c(2).options.k = 7;                              % KNN with 7 neighbors
%       c(3).name = 'knn';   c(3).options.k = 9;                              % KNN with 9 neighbors
%       c(4).name = 'lda';   c(4).options.p = [];                             % LDA
%       c(5).name = 'qda';   c(5).options.p = [];                             % QDA
%       c(6).name = 'maha';  c(6).options = [];                               % Mahalanobis distance
%       c(7).name = 'libsvm';c(7).options.kernel = '-t 2';                    % rbf-SVM
%       c(8).name = 'dmin';  c(8).options = [];                               % Euclidean distance
%       options = Xclassify(Xtrain,dtrain,c);                                 % Training only
%
%    Example: Testing only (after training only example):
%       ds = Xclassify(Xtest,options);                                        % Testing only
%       acc  = Xaccuracy(ds,dtest)
%       Xdecisionline(Xtrain,dtrain,Xn,options);

function [ds,options] = Xclassify(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});

c = options;
n = length(c); % number of classifiers

if train
    for i=1:n
        if c(i).name(1) == 'X'
            Cname = c(i).name;
        else
            Cname = ['X' c(i).name];
        end
        c(i).options = feval(Cname,Xtrain,dtrain,c(i).options);
    end
    options = c;
    ds = options;
end
if test
    nt = size(Xtest,1);
    ds3 = zeros(nt,n,2);
    d3 = 0;
    for i=1:n
        if c(i).name(1) == 'X'
            Cname = c(i).name;
        else
            Cname = ['X' c(i).name];
        end
        dsi = feval(Cname,Xtest,c(i).options);
        ds3(:,i,1) = dsi(:,1);
        if size(dsi,2)==2
            ds3(:,i,2) = dsi(:,2);
            d3 = 1;
        end
    end
    if d3
        ds = ds3;
    else
        ds = ds3(:,:,1);
    end
end

