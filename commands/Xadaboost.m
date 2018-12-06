% ds      = Xadaboost(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xadaboost(Xtrain,dtrain,options)        Training only
% ds      = Xadaboost(Xtest,options)                Testing only
%
% Toolbox Xvis
%    AdaBoost.M2 classifier.
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.iter is the number of iterations.
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.mc contains the centroids of each class.
%       options.dmin contains min(dtrain).
%       options.C is the number of classes.
%       options.opth is a 1 x iter struct with Blda training.
%       options.Bt is a iter x iter matrix with Beta values.
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'adaboost').
%
%    See reference (Fig. 8):
%    Polikar, R. (2006): Ensemble Based Systems in Decision Making. IEEE
%    Circuits ans Systems Magazine, Third Quarter, 21-45.
%
%    Example: Training & Test together:
%       load datasim                            % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)            % plot feature space
%       op.iter = 10;                           % 10 iterartions
%       ds = Xadaboost(Xtrain,dtrain,Xtest,op); % AdaBoost classifier
%       p = Xaccuracy(ds,dtest)                 % performance on test data
%
%    Example: Training only
%       load datasim                      % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)      % plot feature space
%       op.iter = 10;                     % prior probability for each class
%       op = Xadaboost(Xtrain,dtrain,op); % AdaBoost - training
%
%    Example: Testing only (after training only example):
%       ds = Xadaboost(Xtest,op);  % AdaBoost - testing
%       p = Xaccuracy(ds,dtest)    % performance on test data

function [ds,options] = Xadaboost(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});

options.string = 'adaboost';
if train
    [N,m] = size(Xtrain);

    dmin = min(dtrain);
    dmax = max(dtrain);

    dtrain = dtrain-dmin+1;

    C = dmax-dmin+1; % number of classes

    D  = ones(N,1)/N;
    
    Bt = zeros(options.iter,1);
    Ns = fix(N*0.75);

    for t=1:options.iter

        % 1. Selection of training data subset drawn from the distribution D.
        rn = rand(N,1);
        [~,j] = sort(rn);
        Xr = Xtrain(j,:);
        dr = dtrain(j);

        Xsub = zeros(Ns,m);
        dsub = zeros(Ns,1);

        i = 1;
        j = 1;
        while(i<=Ns)
            ok = 0;
            while not(ok)
                r = rand;
                if r<D(j)
                    Xsub(i,:) = Xr(j,:);
                    dsub(i)   = dr(j);
                    ok = 1;
                else
                    j = j+1;
                    if j>N
                        j = 1;
                    end
                end
            end
            i = i+1;
        end

        % 2. Training of WeakLearn with selected subset
        op.p = [];
        h  = Xlda(Xsub,dsub,Xtrain,op);

        % 3. Error
        e = D'*(h~=dtrain);

        % 4. Factor beta
        betat = e/(1-e);
        if (e==0)
            betat = 1e-10;
        end
        Bt(:,t) = log(1/betat);

        % 5. Updating of distribution
        ii = find(h==dtrain);
        DD = ones(N,1);
        if not(isempty(ii))
            DD(ii) = betat;
        end
        D = D.*DD;
        D = D/sum(D);
        opht(t).op = Xlda(Xsub,dsub,op); %#ok<AGROW>
    end
    options.C    = C;
    options.dmin = dmin;
    options.opht = opht;
    options.Bt   = Bt;
    ds = options;
end
if test
    nt = size(Xtest,1);
    ht = zeros(nt,options.iter);
    for t = 1:options.iter
        ht(:,t) = Xlda(Xtest,options.opht(t).op);
    end
    C = options.C;
    V = zeros(nt,C);
    for j=1:C
        [ii,jj] = find(ht==j);
        if not(isempty(ii))
            for i=1:length(ii)
                V(ii(i),j) = V(ii(i),j) + options.Bt(jj(i));
            end
        end
    end
    [~,j]=max(V,[],2);
    ds = j+options.dmin-1;
end


