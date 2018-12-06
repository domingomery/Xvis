% ds      = Xsparsecl(Xtrain,dtrain,Xtest,[])  Training & Testing together
% options = Xsparsecl(Xtrain,dtrain,[])        Training only
% ds      = Xsparsecl(Xtest,options)           Testing only
%
% Toolbox Xvis:
%    Classifier using sparse representations
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
%
%    Options:
%       options.newdictionary = 0 do not built a new dictionary, it takes
%       the original signal as dictionary (as SRC*)
%       options.newdictionary = 1 built a new dictionary using SPAMS
%       library (mexTrainDL).
%       options.K, options.lambda, options.numThreads,options.batchsize,
%       options.L, options.iter are parameters of mexTrainDL and mexOMP
%       from SPAMS library.
%
%    Reference *
%       Wright, J., Yang, A.Y., Ganesh, A., Sastry, S.S., Ma, Y.: Robust 
%       face recognition via sparse representation. IEEE Transactions on 
%       Pattern Analysis and Machine Intelligence 31(2), 210-227 (2009)
%
%    Example: Training & Test together:
%       load datafish
%       s0 = Xfclean(X);
%       f = X(:,s0); fn = Xn(s0,:);
%       op.p = 20;                      % 20 features will be selected
%       op.show = 0;                    % display results
%       f = Xfnorm(f,1);                % Normalization
%       s = Xsfs(f,d,op);               % SFS with Fisher cirterion. s is index of selected features
%       fs = f(:,s);                    % selected features
%       Xs = Xuninorm(fs);
%       [X1,d1,X2,d2] = Xstratify(Xs,d,0.90); % 90% for training 10% for testing
%       op.K          = 50;  op.lambda     = 0;     op.numThreads = -1;
%       op.batchsize  = 400; op.L          = 8; op.iter       = 100;
%       op.newdictionary = 0;
%       ds  = Xsparsecl(X1,d1,X2,op);        % Sparse classification
%       acc = Xaccuracy(ds,d2)               % accuracy on test data
%
%    Example: Training only
%       load datafish
%       s0 = Xfclean(X);
%       f = X(:,s0); fn = Xn(s0,:);
%       op.p = 20;                      % 20 features will be selected
%       op.show = 0;                    % display results
%       f = Xfnorm(f,1);                % Normalization
%       s = Xsfs(f,d,op);               % SFS with Fisher cirterion. s is index of selected features
%       fs = f(:,s);                    % selected features
%       Xs = Xuninorm(fs);
%       [X1,d1,X2,d2] = Xstratify(Xs,d,0.90); % 90% for training 10% for testing
%       op.K          = 50;  op.lambda     = 0;     op.numThreads = -1;
%       op.batchsize  = 400; op.L          = 8; op.iter       = 100;
%       op.newdictionary = 0;
%       op  = Xsparsecl(X1,d1,op);        % Sparse classification
%
%    Example: Testing only (after training only example):
%       ds  = Xsparsecl(X2,op);        % Sparse classification
%       acc = Xaccuracy(ds,d2)               % accuracy on test data

function ds = Xsparsecl(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});

options.string = 'sparsecl';
if train
    dmin = min(dtrain);
    dmax = max(dtrain);
    dtrain    = dtrain-dmin+1;
    n    = dmax-dmin+1;
    D = cell(n);
    for i=1:n
        Yi = Xtrain(dtrain==i,:);
        if options.newdictionary==1
            D{i} = (mexTrainDL(Yi',options));
        else
            D{i} = Yi';
        end
        
    end
    options.dmin = dmin;
    options.D     = D;
    ds = options;
end
if test
    D = options.D;
    n  = length(D);
    e = zeros(size(Xtest,1),n);
    for i=1:n
        Xt = full(mexOMP(Xtest',D{i},options))';
        R = (Xtest'-D{i}*Xt')';
        e(:,i) = sqrt(sum(R.*R,2));
    end
    [~,j] = min(e,[],2);
    ds = j+options.dmin-1;
end


