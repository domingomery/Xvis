% ds      = Xtree(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xtree(Xtrain,dtrain,options)        Training only
% ds      = Xtree(Xtest,options)                Testing only
%
% Toolbox Xvis
%    Classifier using a tree algorithm
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options is a strcuture containing a Balu classifier
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.n is the number of nodes
%       options.opt are the options of each classifier
%       options.im are the classes discriminated in each node
%       options.string is a 8 character string that describes the performed
%       classification (e.g., 'svm,4   ' means rbf-SVM).
%
%    Example: Training & Test together:
%       [Xtrain,dtrain] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       [Xtest,dtest]   = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       opc.name = 'knn';
%       opc.options.k=5;                     % KNN with 5 neighbors
%       ds = Xtree(Xtrain,dtrain,Xtest,opc); % tree
%       p = Xaccuracy(ds,dtest)              % performance on test data
%
%    Example: Training only
%       [Xtrain,dtrain] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       [Xtest,dtest]   = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       opc.name = 'knn';
%       opc.options.k=5;                     % KNN with 5 neighbors
%       opc = Xtree(Xtrain,dtrain,opc);      % tree
%
%    Example: Testing only (after training only example):
%       ds = Xtree(Xtest,opc);               % KNN with 5 neighbors
%       p = Xaccuracy(ds,dtest)              % performance on test data
%
%    Test the examples using a rbf-SVM classifier:
%       [Xtrain,dtrain] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       [Xtest,dtest]   = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       opc.name = 'svm'; 
%       opc.options.kernel = '-t 2';         % svm-rbf
%       opc = Xtree(Xtrain,dtrain,opc);      % tree with svm (training)
%       ds = Xtree(Xtest,opc);               % tree with svm (test)
%       p = Xaccuracy(ds,dtest)              % performance on test data

function [ds,options] = Xtree(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = 'tree    ';
if train
    d1 = min(dtrain);
    d2 = max(dtrain);
    n = d2-d1+1;

    XX = Xtrain;
    dd = dtrain;

    im = zeros(n-1,1);
    t = 1;
    for k=n:-1:2
            perimax = -1;
            for i=1:n
                if sum(dd==i)>0
                    di = not(dd==i)+1;
                    [dsi,opi] = Xclassify(XX,di,XX,options);
                    peri = Xaccuracy(dsi,di);
                    if peri>perimax
                        perimax = peri;
                        imax = i;
                        opx = opi;
                        opx.name = options.name;
                    end
                end
            end
            ii = find(dd==imax);
            XX(ii,:) = [];
            dd(ii)   = [];
            im(t) = imax;
            opt(t) = opx; %#ok<AGROW>
            t = t+1;
    end
    options.im = im;
    options.n   = n;
    options.opt = opt;
    ds = options;
end
if test
    XXt = Xtest;
    im = options.im;
    n = options.n;
    ds = zeros(size(Xtest,1),1);
    for i=1:n-1
        opi = options.opt(i);
        dsi = Xclassify(XXt,opi);
        ii = and(dsi==1,ds==0);
        ds(ii) = im(i);
    end
    ii = ds==0;
    h = (1:n)';
    h(im) = 0;
    jj = h>0;
    ds(ii) = h(jj);
end
