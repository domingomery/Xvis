% ds      = Xsvmplus(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xsvmplus(Xtrain,dtrain,options)        Training only
% ds      = Xsvmplus(Xtest,options)                Testing only
%
% Toolbox Xvis
%    Classifier using Support Vector Machine approach (from LIBSVM)
%    It uses  atree algorithm when number of classes is
%    2 or more. For two classes Xsvmplus calls Xsvm. For more than 2
%    Xsvmplus calls Xtree.
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%
%       See help Xsvm to see options of Xsvmplus
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.string is a 8 character string that describes the performed
%       classification (e.g., 'svm+,4  ' means rbf-SVMplus).
%       options.svm = 1 means Bsvm was used.
%       options.svm = 0 means Btree with Bsvm was used.
%       See help Btree to see output options of Bsvmplus.
%
%    Example: Training & Test together:
%       [Xtrain,dtrain] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       [Xtest,dtest] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       Xplotfeatures(Xtrain,dtrain)           % plot feature space
%       op.kernel = '-t 2';                    % rbf
%       ds = Xsvmplus(Xtrain,dtrain,Xtest,op); % rbf-SVM
%       p = Xaccuracy(ds,dtest)                % performance on test data
%
%    Example: Training only
%       [Xtrain,dtrain] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       [Xtest,dtest] = Xgaussgen([2 1;1 2;2 2;1 1],ones(4,2)/4,500*ones(4,1));
%       Bio_plotfeatures(Xtrain,dtrain)        % plot feature space
%       op.kernel = 4;                         % rbf
%       op = Xsvmplus(Xtrain,dtrain,op);       % rbf-SVM
%
%    Example: Testing only (after training only example):
%       ds = Xsvmplus(Xtest,op);               % rbf-SVM classifier testing
%       p = Xaccuracy(ds,dtest)                % performance on test data


function [ds,options] = Xsvmplus(varargin)

[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = 'svmplus ';

% options.libsvm = 1;


if train
    dmin = min(dtrain);
    dmax = max(dtrain);
    dtrain    = dtrain-dmin+1;
    
    if (dmax-dmin)==1
        op = options;
        options = Xsvm(Xtrain,dtrain,op);
        options.svm = 1;
    else
        b.name = 'Xsvm';
        b.options.kernel = options.kernel;
        op = b;
        options = Xtree(Xtrain,dtrain,op);
        options.svm = 0;
        options.kernel = b.options.kernel;
    end
    options.string = sprintf('svm+,%dtrain  ',options.kernel);
    options.dmin = dmin;
    ds = options;
end
if test
    if options.svm
        ds = Xsvm(Xtest,options) + options.dmin - 1;
    else
        ds = Xtree(Xtest,options) + options.dmin - 1;
    end
end


