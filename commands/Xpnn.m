% ds      = Xpnn(X,d,Xt,options)  Training & Testing together
% options = Xpnn(X,d,options)     Training only
% ds      = Xpnn(Xt,options)      Testing only
%
% Toolbox Xvis
%    Probabilistic neural network (Neural Network Toolbox required).
%
%    Design data:
%       X is a matrix with features (columns)
%       d is the ideal classification for X
%       options must be [] (it is for future purposes)
%
%    Test data:
%       Xt is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.dmin contains min(d).
%       options.net contains information about the neural network
%       (from function newpnn from Nueral Network Toolbox).
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'pnn     ').
%
%    Example: Training & Test together:
%       load datasim             % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)       % plot feature space
%       ds = Xpnn(Xtrain,dtrain,Xtest,[]); % pnn classifier
%       p = Xaccuracy(ds,dtest)            % performance on test data
%
%    Example: Training only
%       load datasim                       % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)       % plot feature space
%       op = Xpnn(X,d,[]);                 % pnn - training
%
%    Example: Testing only (after training only example):
%       ds = Xpnn(Xtest,op);               % pnn - testing
%       p = Xaccuracy(ds,dtest)            % performance on test data


function [ds,options] = Xpnn(varargin)
if isempty(ver('nnet'))
    error('Xpnn requires the Neural Network Toolbox.');
end
[train,test,X,d,Xt,options] = Xconstruct(varargin{:});
options.string = 'pnn     ';
if train
    dmin = min(d);
    options.dmin = dmin;
    d    = d-dmin+1;
    T    = ind2vec(d');
    options.net  = newpnn(X',T,1);
    ds = options;
end
if test
    A    = sim(options.net,Xt');
    ds   = vec2ind(A)'+options.dmin-1;
end
