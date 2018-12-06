% ds      = Xglm(Xtrain,dtrain,Xtest,[])    Training & Testing together
% options = Xglm(Xtrain,dtrain,[])          Training only
% ds      = Xglm(Xtest,options)             Testing only
%
% Toolbox Xvis:
%
%    Neural Network using a Generalized Linear Model
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.method = '1, 2, 3 for 'linear','logistic' or 'softmax' (default=3)
%       options.iter is the number of iterations used in the IRLS algorithm
%       (default=10).
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.net contains information about the neural network
%       (from function Bglmtrain).
%       options.dmin contains min(dtrain).
%       options.string is a 8 character string that describes the performed
%       classification (e.g., 'glm,3 ' means softmax - neural network).
%
%    Example: Training & Test together:
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.method = 2;
%       op.iter = 12;
%       ds = Xglm(Xtrain,dtrain,Xtest,op);   % logistic - neural network
%       acc = Xaccuracy(ds,dtest)            % performance on test data
%
%    Example: Training only
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.method = 2;
%       op.iter = 12;
%       op = Xglm(Xtrain,dtrain,op);         % logistic - neural network - training
% 
%    Example: Testing only (after training only example):
%       ds = Xglm(Xtest,op);                 % logistic - neural network - testing
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

function [ds,options] = Xglm(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = sprintf('glm,%d   ',options.method);
if train
    switch options.method
        case 1
            smethod = 'linear';
        case 2
            smethod = 'logistic';
        case 3
            smethod = 'softmax';
        otherwise
            error('Xglm: method must be 1, 2 or 3 and not %dtrain',method');
    end

    dmin = min(dtrain);
    dmax = max(dtrain);
    d1 = dtrain-dmin+1;
    k = dmax-dmin+1;
    m = size(Xtrain,2);
    id = eye(k);
    targets = id(d1,:);
    net = glm(m, k, smethod);
    ops = foptions;
    ops(1) = 0;
    ops(14) = options.iter;
    options.net = glmtrain(net, ops, Xtrain, targets);
    options.dmin = dmin;
    ds = options;    
end
if test
    Z = glmfwd(options.net, Xtest);
    [~ , class] = max(Z,[],2);
    ds = class+options.dmin-1;
end

end


