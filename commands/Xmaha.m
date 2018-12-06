% ds      = Xmaha(X,d,Xt,[])  Training & Testing together
% options = Xmaha(X,d,[])     Training only
% ds      = Xmaha(Xt,options) Testing only
%
% Toolbox Xvis:
%    Classifier using Mahalanobis minimal distance
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain (labels)
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.mc contains the centroids of each class.
%       options.dmin contains min(d).
%       options.Ck is covariance matrix of each class.
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'maha    ').
%
%    Example: Training & Test together:
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       ds  = Xmaha(Xtrain,dtrain,Xtest,[]); % Euclidean distance classifier
%       acc = Xaccuracy(ds,dtest)            % performance on test data
%
%    Example: Training only
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op = Xmaha(Xtrain,dtrain,[]);        % Euclidean distance classifier - training
%
%    Example: Testing only (after training only example):
%       ds  = Xmaha(Xtest,op);                % Euclidean distance classifier - testing
%       acc = Xaccuracy(ds,dtest)             % performance on test data

function [ds,options] = Xmaha(varargin)
[train,test,X,d,Xt,options] = Xconstruct(varargin{:});

options.string = 'maha    ';
if train
    m    = size(X,2);
    dmin = min(d);
    dmax = max(d);
    n    = dmax-dmin+1;
    d    = d-dmin+1;
    mc   = zeros(n,m);
    M    = size(X,2);
    Ck   = zeros(M,M,n);
    for i=1:n
        ii = find(d==i);
        mc(i,:) = mean(X(ii,:),1);
        CCk = cov(X(ii,:));      % covariance of class i
        Ck(:,:,i) = CCk;
    end
    options.mc   = mc;
    options.dmin = dmin;
    options.Ck    = Ck;
    ds = options;
end
if test
    mc    = options.mc;
    n     = size(mc,1);
    Nt    = size(Xt,1);
    ds    = zeros(Nt,1);
    sc    = ds;
    for k=1:n
        Ck(:,:,k) = inv(options.Ck(:,:,k));
    end
    for q=1:Nt
        dk = zeros(n,1);
        for k=1:n
            dx = Xt(q,:)-options.mc(k,:);
            dk(k) = dx*Ck(:,:,k)*dx';
        end
        [i,j] = min(dk);
        ds(q) = j;
        sc(q) = i;
    end
    ds = ds+options.dmin-1;
    ds = Xoutscore(ds,sc,options);
end

