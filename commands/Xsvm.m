% ds      = Xsvm(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xsvm(Xtrain,dtrain,options)        Training only
% ds      = Xsvm(Xtest,options)                Testing only
%
% Toolbox Xvis
%    Support Vector Machine approach using the LIBSVM(*).
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%
%       options.kernel is a string that defines the options of LIBSVM as 
%       follows:
%
%          -s svm_type : set type of SVM (default 0)
%                  0 -- C-SVC
%                  1 -- nu-SVC
%                  2 -- one-class SVM
%                  3 -- epsilon-SVR
%                  4 -- nu-SVR
%          -t kernel_type : set type of kernel function (default 2)
%                  0 -- linear: u'*v
%                  1 -- polynomial: (gamma*u'*v + coef0)^degree
%                  2 -- radial basis function: exp(-gamma*|u-v|^2)
%                  3 -- sigmoid: tanh(gamma*u'*v + coef0)
%          -dtrain degree : set degree in kernel function (default 3)
%          -g gamma : set gamma in kernel function (default 1/num_features)
%          -r coef0 : set coef0 in kernel function (default 0)
%          -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
%          -n nu : set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
%          -p epsilon : set the epsilon in loss function of epsilon-SVR (default 0.1)
%          -m cachesize : set cache memory size in MB (default 100)
%          -e epsilon : set tolerance of termination criterion (default 0.001)
%          -h shrinking: whether to use the shrinking heuristics, 0 or 1 (default 1)
%          -b probability_estimates: whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
%          -wi weight: set the parameter C of class i to weight*C, for C-SVC (default 1)%
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.svmStruct contains information about the trained classifier
%       (from function svmtrain of Bioinformatics Toolbox).
%       options.string is a 8 character string that describes the performed
%       classification (e.g., 'svm -t 2' means rbf-SVM).
%
%    Example: Training & Test together:
%       load datasim                          % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)          % plot feature space
%       op.kernel = '-t 2';
%       ds = Xsvm(Xtrain,dtrain,Xtest,op);    % rbf-SVM classifier
%       acc = Xaccuracy(ds,dtest)             % performance on test data
%
%    Example: Training only
%       load datasim                          % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)          % plot feature space
%       op.kernel = '-t 2';
%       op = Xsvm(Xtrain,dtrain,op);          % rbf-SVM classifier training
%
%    Example: Testing only (after training only example):
%       ds = Xsvm(Xtest,op);                  % rbf-SVM classifier testing
%       acc = Xaccuracy(ds,dtest)             % performance on test data
% 
% Reference:
%    Chang, Chih-Chung and Lin, Chih-Jen (2011): LIBSVM: A library for 
%    support vector machines, ACM Transactions on Intelligent Systems and 
%    Technology, 2(3):27:1--27:27.
%    http://www.csie.ntu.edu.tw/~cjlin/libsvm
%
%    WARNING: When installing libsvm you must rename the compiled files
%    svmtrain and svmpredict (in libsvmxxx/matlab folder) as
%    libsvmtrain and libsvmpredict. Additionally, libsvmxxx/matlab folder  
%    must be included in the matlab path.

function [ds,options] = Xsvm(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string      = ['svm ' options.kernel];
if train
    s = options.kernel;
    options.model   = libsvmtrain(dtrain,Xtrain,s);
    
    outp = 0;
    if isfield(options,'output')
       outp = options.output;
    end
    if outp == 3
       [~,~,sc]     = libsvmpredict(ones(size(Xtrain,1),1),Xtrain,options.model);
       [~,param]   = Xsigmoid(sc,dtrain);
       options.param = param;
    end
    ds              = options;
end
if test
    [ds,~,sc] = libsvmpredict(ones(size(Xtest,1),1),Xtest,options.model);
    ds = Xoutscore(ds,sc,options);
end


end

% function [param]=fitSigmoid2Scores(posFeats, negFeats, classifier, display)
% original de A.Soto
% nPosExamples=size(posFeats,1);
% nNegExamples=size(negFeats,1);
%
% [predict_label, accuracy, posScores]=svmpredict31EchoOff(ones(nPosExamples,1), posFeats, classifier);
% [predict_label, accuracy, negScores]=svmpredict31EchoOff(ones(nNegExamples,1), negFeats, classifier);
%
% Modificado por D.Mery
%
function [ysc,param] = Xsigmoid(sc,dtrain,show)

if ~exist('show','var')
    show = 0;
end


if length(dtrain)>2 % searching for fit

    dneg         = min(dtrain);
    dpos         = max(dtrain);

    posScores    = sc(dtrain==dpos);
    negScores    = sc(dtrain==dneg);

    nPosExamples = length(posScores);
    nNegExamples = length(negScores);

    x            = [negScores; posScores];

    y            = [zeros(nNegExamples,1); ones(nPosExamples,1)];

    param        = nlinfit(x,y,@fsig,[-1 0.05]);
else
    x            = sc;
    param        = dtrain;
end

ysc              = fsig(param,x);


if show
    figure;
    plot(x,y,'bo');
    hold;
    plot(posScores,fsig(param,posScores),'g*');
    plot(negScores,fsig(param,negScores),'r*');
    [~,j] = sort(ysc);
    plot(x(j),ysc(j),'k')
end;


end


function y = fsig(param,x)

y = 1./(1 + exp(param(1)*x+param(2)));

end

%param=fit(x,y,'1./ (1 + exp(a*x+b))','start',[0 20]);