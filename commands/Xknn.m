% ds      = Xknn(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xknn(Xtrain,dtrain,options)        Training only
% ds      = Xknn(Xtest,options)                Testing only
%
% Toolbox Xvis:
%    KNN (k-nearest neighbors) classifier using randomized kd-tree
%    forest from FLANN. This implementation requires VLFeat Toolbox.
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.k is the number of neighbors (default=10)
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.kdtree contains information about the randomized kdtree
%       (from function vl_kdtreebuilf of VLFeat Toolbox).
%       options.string is a 8 character string that describes the performed
%       classification (e.g., 'knn,10  ' means knn with k=10).
%
%    Example: Training & Test together:
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.k = 10;
%       ds  = Xknn(Xtrain,dtrain,Xtest,op);  % knn with 10 neighbors
%       acc = Xaccuracy(ds,dtest)            % performance on test data
%
%    Example: Training only
%       load datasim                         % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)         % plot feature space
%       op.k = 10;
%       op = Xknn(Xtrain,dtrain,op);         % knn with 10 neighbors
%
%    Example: Testing only (after training only example):
%       ds = Xknn(Xtest,op);                 % knn with 10 neighbors - testing
%       acc = Xaccuracy(ds,dtest)            % accuracy on test data


function [ds,options] = Xknn(varargin)

if ~exist('vl_kdtreequery','file')
    error('Xknn: This function requires the VLFeat Toolbox.');
end

[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = sprintf('knn,%2d  ',options.k);
if train
    options.kdtree = vl_kdtreebuild(Xtrain');
    options.Xtrain      = Xtrain;
    options.dtrain      = dtrain;
    ds = options;
end
if test
    [i,dist] = vl_kdtreequery(options.kdtree,options.Xtrain',Xtest','NumNeighbors',options.k);
    if (options.k > 1)
        ds       = mode(options.dtrain(i))';
    else % for 1-KNN (modification by Carlos Mena)
        ds       = options.dtrain(i);
    end
    
    if isfield(options,'output')
        ns = length(ds);
        sc = zeros(ns,1);
        for q=1:ns
            j = find(options.dtrain(i(:,q))==ds(q));
            sc(q) = min(dist(j,q));
        end
        ds = Xoutscore(ds,sc,options);
    end
end
