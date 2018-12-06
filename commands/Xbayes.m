% ds      = Xbayes(Xtrain,dtrain,Xtest,options)  Training & Testing together
% options = Xbayes(Xtrain,dtrain,options)        Training only
% ds      = Xbayes(Xtest,options)                Testing only
%
% Toolbox Xvis:
%    This implemention of Bayes classifier is ONLY for two features and two classes
%
%    Design data:
%       Xtrain is a matrix with features (columns)
%       dtrain is the ideal classification for Xtrain
%       options.p is the prior probability, if p is not given, it will be estimated
%         proportional to the number of samples of each class.
%       options.show = 1 displays results.
%
%    Test data:
%       Xtest is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data
%       options.dmin contains min(dtrain).
%       options.string is a 8 character string that describes the performed
%       classification (in this case 'bayes2  ').
%       options.max_X, in_X, pw1x, pw2x are parameters of the classifier.
%
% NOTE:
%    The pdf's are estimated using Kernel Density Estimations programs 
%    kde.m and kde2d.m after Botev et al. (2010) implemented by Botev. 
%    These files are in Xvis directory 'misc'. They can also be downloaded 
%    from www.mathwork.com (c) Zdravko Botev. All rights reserved.
%
%    Example: Training & Test together:
%       load datasim                          % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)          % plot feature space
%       op.p = [];                            % prior probability
%       op.show = 1;                          % display results
%       ds = Xbayes(Xtrain,dtrain,Xtest,op);  % Bayes classifier
%       acc = Xaccuracy(ds,dtest)             % accuracy on test data
%
%    Example: Training only
%       load datasim                          % simulated data (2 classes, 2 features)
%       Xplotfeatures(Xtrain,dtrain)          % plot feature space
%       op.p = [];                            % prior probability
%       op.show = 1;                          % display results
%       op = Xbayes(Xtrain,dtrain,op);        % Bayes classifier
%
%    Example: Testing only (after training only example):
%       ds = Xbayes(Xtest,op);               % Bayes classifier
%       acc = Xaccuracy(ds,dtest)            % accuracy on test data


function [ds,options] = Xbayes(varargin)
[train,test,Xtrain,dtrain,Xtest,options] = Xconstruct(varargin{:});
options.string = 'bayes   ';
T = 128;

if ~isfield(options,'show')
    show = 0;
else
    show = options.show;
end

if train
    dmin = min(dtrain);
    dmax = max(dtrain);
    c = dmax-dmin+1;
    if or(c~=2,size(Xtrain,2)~=2)
        error('This implemention of Bayes classifier is ONLY for two features and two classes.');
    end
    dtrain    = dtrain-dmin+1;
    min_X = min(Xtrain);
    max_X = max(Xtrain);
    dX    = max_X-min_X;
    min_X = min_X-0.1*dX;
    max_X = max_X+0.1*dX;
    
    if dmin == 0;
        w1 = 'p(\omega_0|x)'; w2 = 'p(\omega_1|x)';
        bt = 'both p(\omega_0|x),p(\omega_1|x)';
    else
        w1 = 'p(\omega_1|x)'; w2 = 'p(\omega_2|x)';
        bt = 'both p(\omega_1|x),p(\omega_2|x)';
    end

    
    
    i1 = find(dtrain==1);
    i2 = find(dtrain==2);
    if isempty(options.p)
        p  = [length(i1) length(i2)]'/length(dtrain);
    else
        p = options.p;
    end
    X1 = Xtrain(i1,:);
    X2 = Xtrain(i2,:);
    
    % Xn = ['X1';'X2'];
    [~,pdf1,x1,x2] = kde2d(X1,T,min_X,max_X);
    [~,pdf2]       = kde2d(X2,T,min_X,max_X);
    
    pw1x = pdf1*p(1);
    pw2x = pdf2*p(2);
    
    if show
        pmax = max2([pw1x;pw2x]);
        
        figure
        mesh(x1,x2,pw1x)
        axis([min_X(1) max_X(1) min_X(2) max_X(2) 0 pmax])
        title(w1)
        
        figure
        mesh(x1,x2,pw2x)
        axis([min_X(1) max_X(1) min_X(2) max_X(2) 0 pmax])
        title(w2)
        
        figure;clf
        mesh(x1,x2,pw1x); hold on
        mesh(x1,x2,pw2x)
        axis([min_X(1) max_X(1) min_X(2) max_X(2) 0 pmax])
        title(bt)
        
    end
    options.dmin  = dmin;
    options.max_X = max_X;
    options.min_X = min_X;
    options.pw1x  = pw1x;
    options.pw2x  = pw2x;
    ds = options;
end

if test
    max_X = options.max_X;
    min_X = options.min_X;
    pw1x  = options.pw1x;
    pw2x  = options.pw2x;
    
    m1 = (T-1)/(max_X(1)-min_X(1));
    b1 = T-m1*max_X(1);
    m2 = (T-1)/(max_X(2)-min_X(2));
    b2 = T-m2*max_X(2);
    x1d = round(Xtest(:,1)*m1+b1);
    x2d = round(Xtest(:,2)*m2+b2);
    
    x1d(x1d<1) = 1; x1d(x1d>T) = T;
    x2d(x2d<1) = 1; x2d(x2d>T) = T;
    
    
    n = size(Xtest,1);
    ds = zeros(n,1);
    sc0 = zeros(n,1);
    for i=1:n
        ds(i) = double(pw1x(x2d(i),x1d(i))<pw2x(x2d(i),x1d(i)))+1;
        sc0(i) = abs(double(pw1x(x2d(i),x1d(i))-pw2x(x2d(i),x1d(i))));
    end
    
    ds = ds + options.dmin - 1;
    sc = ones(size(sc0))./(abs(sc0)+1e-5);
    ds = Xoutscore(ds,sc,options);
    
end



