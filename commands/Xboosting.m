% ds      = Xboosting(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xboosting(Xtrain,dtrain,options)     Training only
% ds      = Xboosting(Xtest,options)      Testing only
%
% Toolbox Xvis
%    Boosting classifier.
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.s portion of samples to be selected to design classifier C1.
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'boosting').
%       options.op1,op2,op3 contains training information about the three
%       classifiers used as weak classifiers.
%       options.dmin is min(dtrain).
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%
%    See reference (Fig. 7):
%    Polikar, R. (2006): Ensemble Based Systems in Decision Making. IEEE
%    Circuits ans Systems Magazine, Third Quarter, 21-45.
%
%    Example: Training & Test together:
%       load datasim                            % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)            % plot feature space
%       op.s = 0.3;
%       ds = Xboosting(Xtrain,dtrain,Xtest,op); % Boosting with s = 0.30
%       p = Xaccuracy(ds,dtest)                 % performance on test data
%
%    Example: Training only
%       load datasim                            % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)            % plot feature space
%       op.s = 0.3;
%       op = Xboosting(Xtrain,dtrain,op);       % Boosting with s = 0.30
%
%    Example: Testing only (after training only example):
%       ds = Xboosting(Xtest,op);               % Boosting with s = 0.30
%       p = Xaccuracy(ds,dtest)                 % performance on test data

function [ds,options] = Xboosting(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = 'boosting';
if train
    s = options.s;
    if s>1
        error('Xboosting: s must be less than 1');
    end
    N = size(Xtrain,1);
    dmin = min(dtrain);
    N1 = fix(s*N);
    dtrain = dtrain-dmin+1;
    op.p = [];

    % 1. Select N1 < N samples without replacement from Xtrain to create X1
    rn    = rand(N1,1);
    [~,j] = sort(rn);
    X1    = Xtrain(j,:);
    d1    = dtrain(j);

    % 2. Tarining of C1 with X1
    op1 = Xlda(X1,d1,op);
    ds1 = Xlda(Xtrain,op1);

    % 3. Definition of dataset X2
    rn    = rand(N,1);
    [~,j] = sort(rn);
    Xr    = Xtrain(j,:);
    dr    = dtrain(j);
    drs1  = ds1(j);

    i0 = find(drs1~=dtrain);
    i1 = find(drs1==dtrain);

    n2 = min([length(i0) length(i1)]);

    ii = [i0(1:n2);i1(1:n2)];

    X2 = Xr(ii,:);
    d2 = dr(ii);

    % 4. Training of classifier C2 using X2
    op2 = Xlda(X2,d2,op);
    ds2 = Xlda(Xtrain,op2);

    % 5. Definition of dataset X3
    ii = find(ds1~=ds2);
    if not(isempty(ii))
        X3 = Xr(ii,:);
        d3 = dr(ii);
        op3 = Xlda(X3,d3,op);
    else
        op3 = [];
    end
    options.op1 = op1;
    options.op2 = op2;
    options.op3 = op3;
    options.dmin = dmin;
    ds = options;
end
if test
    op1  = options.op1;
    op2  = options.op2;
    op3  = options.op3;
    dmin = options.dmin;
    dt1  = Xlda(Xtest,op1);
    dt2  = Xlda(Xtest,op2);
    if not(isempty(op3))
        dt3 = Xlda(Xtest,op3);
        ds = dt1;
        ii = find(dt1~=dt2);
        if not(isempty(ii))
            ds(ii) = dt3(ii);
        end
    end
    ds   = ds+dmin-1;
end

