% ds      = Xdmin(Xtrain,dtrain,Xtest,[])  Training & Testing together
% options = Xdmin(Xtrain,dtrain,[])        Training only
% ds      = Xdmin(Xtest,options)           Testing only
%
% Toolbox Xvis:
%    Classifier using Euclidean minimal distance
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
%       options.dmin contains min(dtrain).
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'dmin    ').
%
%    Example: Training & Test together:
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       ds  = Xdmin(Xtrain,dtrain,Xtest,[]); % Euclidean distance classifier
%       acc = Xaccuracy(ds,dtest)            % accuracy on test data
%
%    Example: Training only
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op = Xdmin(Xtrain,dtrain,[]);        % Euclidean distance classifier - training
%
%    Example: Testing only (after training only example):
%       ds  = Xdmin(Xtest,op);                % Euclidean distance classifier - testing
%       acc = Xaccuracy(ds,dtest)             % accuracy on test data

function ds = Xdmin(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});

options.string = 'dmin    ';
if train
    m    = size(Xtrain,2);
    dmin = min(dtrain);
    dmax = max(dtrain);
    dtrain    = dtrain-dmin+1;
    n    = dmax-dmin+1;
    mc   = zeros(n,m);
    for i=1:n
        mc(i,:) = mean(Xtrain(dtrain==i,:),1);
    end
    options.mc   = mc;
    options.dmin = dmin;
    ds = options;
end
if test
    mc = options.mc;
    n  = size(mc,1);
    Nt = size(Xtest,1);
    ds = zeros(Nt,1);
    sc = zeros(Nt,1);
    for q=1:Nt
        D     = ones(n,1)*Xtest(q,:)-mc;
        D2    = D.*D;
        e     = sum(D2,2);
        [i,j] = min(e);
        ds(q) = j;
        sc(q) = i;
    end
    ds = ds+options.dmin-1;
    ds = Xoutscore(ds,sc,options);
end


