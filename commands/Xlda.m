% ds      = Xlda(Xtrain,dtrain,Xtest,[])  Training & Testing together
% options = Xlda(Xtrain,dtrain,[])        Training only
% ds      = Xlda(Xtest,options)           Testing only
%
% Toolbox Xvis:
%    LDA (linear discriminant analysis) classifier.
%    We assume that the classes have a common covariance matrix
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.p is the prior probability, if p is empty,
%       it will be estimated proportional to the number of samples of each
%       class.
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.dmin contains min(dtrain).
%       options.Cw1 is inv(within-class covariance).
%       options.mc contains the centroids of each class.
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'lda     ').
%
%    Reference:
%       Hastie, T.; Tibshirani, R.; Friedman, J. (2009): The Elements of
%       Statistical Learning, Springer (Section 4.3)
%
%    Example: Training & Test together:
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.p = [0.75 0.25];                  % prior probability for each class
%       ds  = Xlda(Xtrain,dtrain,Xtest,op);  % LDA classifier
%       acc = Xaccuracy(ds,dtest)            % performance on test data
%
%    Example: Training only
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.p = [0.75 0.25];                  % prior probability for each class
%       op = Xlda(Xtrain,dtrain,op);         % LDA - training
%
%    Example: Testing only (after training only example):
%       ds = Xlda(Xtest,op);                 % LDA - testing
%       acc = Xaccuracy(ds,dtest)            % accuracy on test data



function [ds,options] = Xlda(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});

options.string = 'lda     ';
if train
    dmin = min(dtrain);
    dmax = max(dtrain);
    dtrain    = dtrain-dmin+1;
    N = length(dtrain);   % number of samples
    K = dmax-dmin+1; % number of classes

    pest = isempty(options.p);

    if pest
        p = zeros(K,1);
    else
        p = options.p;
    end

    m   = size(Xtrain,2);
    L   = zeros(K,1);
    Cw = zeros(m,m);

    mc = zeros(m,K);
    for k=1:K
        ii   = find(dtrain==k); % index of rows of class k
        if isempty(ii)
            error('Xlda: There is no class %dtrain in the data.',k+dmin-1)
        end
        L(k)      = length(ii); % number of samples in class k
        Xk        = Xtrain(ii,:);    % samples of class k
        mc(:,k)  = mean(Xk)';   % mean of class k
        Ck        = cov(Xk);    % covariance of class k
        Cw = Cw + Ck*(L(k)-1);  % within-class covariance
        if pest
            p(k) = L(k)/N;
        end
    end

    Cw = Cw/(N-K);
    options.Cw1  = inv(Cw);
    options.dmin = dmin;
    options.mc   = mc;
    options.p    = p;
    ds = options;
end

if test
    K  = size(options.mc,2);
    Nt = size(Xtest,1);
    D  = zeros(Nt,K);
    for k=1:K
        C1 = options.Cw1*options.mc(:,k);
        C2 = (-0.5*options.mc(:,k)'*C1 + log(options.p(k)))*ones(Nt,1);
        D(:,k) = Xtest*C1+C2;
    end
    [i,j]=max(D,[],2);
    sc = ones(size(i))./(abs(i)+1e-5);
    ds = j + options.dmin - 1;
    ds = Xoutscore(ds,sc,options);
end

