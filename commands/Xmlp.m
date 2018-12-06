% ds      = Xmlp(Xtrain,dtrain,Xtest,[])    Training & Testing together
% options = Xmlp(Xtrain,dtrain,[])          Training only
% ds      = Xmlp(Xtest,options)             Testing only
%
% Toolbox Xvis:
%
%    Multi Layer Perceptron
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.method = '1, 2, 3 for 'linear','logistic' or 'softmax' (default=3)
%       options.iter is the number of iterations used in the IRLS algorithm
%       op.nhidden is number of hidden units
%       op.ncycles is the number of training cycles
%       op.alpha is the weight decay
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.net contains information about the neural network
%       options.dmin contains min(dtrain).
%       options.string is a 8 character string that describes the performed
%       classification (e.g., 'mlp,3   ' means softmax - neural network).
%
%    Example: Training & Test together:
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.method = 2;                       % 'logistic'
%       op.iter = 12;                        % number of iterations
%       op.nhidden = 6;                      % number of hidden units
%       op.ncycles = 60;                     % Number of training cycles
%       op.alpha = 0.2;                      % Weight decay
%       ds = Xmlp(Xtrain,dtrain,Xtest,op);   % MLP - neural network
%       acc = Xaccuracy(ds,dtest)            % performance on test data
%
%    Example: Training only
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.method = 2;                       % 'logistic'
%       op.iter = 12;                        % number of iterations
%       op.nhidden = 6;                      % number of hidden units
%       op.ncycles = 60;                     % Number of training cycles
%       op.alpha = 0.2;                      % Weight decay
%       op = Xmlp(Xtrain,dtrain,op);         % logistic - neural network - training
%
%    Example: Testing only (after training only example):
%       ds = Xmlp(Xtest,op);                 % logistic - neural network - testing
%       acc = Xaccuracy(ds,dtest)            % performance on test data
%
%
%    This implementation need NetLab Toolbox:
%    http://www.ncrg.aston.ac.uk/netlab/index.php
%    http://www.mathworks.com/matlabcentral/fileexchange/2654-netlab
%    Copyright (c) 1996-2001, Ian T. Nabney, All rights reserved.
%
%    Nabney, I.T. (2003): Netlab: Algorithms for Pattern Recognition,
%    Advances in Pattern Recognition, Springer.

function [ds,options] = Xmlp(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = sprintf('mlp,%d   ',options.method);
if train
    
    switch options.method
        case 1
            smethod = 'linear';
        case 2
            smethod = 'logistic';
        case 3
            smethod = 'softmax';
        otherwise
            error('Xmlp: method must be 1, 2 or 3 and not %dtrain',method');
    end
    
    nout         = 1;
    nhidden      = options.nhidden;
    alpha        = options.alpha;	
    ncycles      = options.ncycles;	
    dmin         = min(dtrain);
    dmax         = max(dtrain);
    target       = dtrain-dmin;
    k            = dmax-dmin+1;
    if k~=2
        error('Xmlp works only for two classes.');
    end
    m            = size(Xtrain,2);
    net          = mlp(m, nhidden, nout,smethod, alpha);
    opmlp        = foptions;
    opmlp(1)     = 0;                 % Don't print out error values
    opmlp(14)    = ncycles;
    
    options.net  = netopt(net, opmlp, Xtrain, target, 'quasinew');
    options.dmin = dmin;
    ds           = options;
end
if test
    dmin         = options.dmin;
    net          = options.net;
    yt           = mlpfwd(net, Xtest);
    ds           = (yt>0.5)+dmin;
end

