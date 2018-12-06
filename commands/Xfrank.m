% selec = Xfrank(X,d,options)
%
% Toolbox Xvis:
%    Feature selection based on command rankfeatures (from MATLAB 
%    Bioinformatics Toolbox) that ranks ranks key features by class
%    separability criteria.
%
%    input: X feature matrix
%           options.m number of features to be selected
%           options.criterion can be:
%      'ttest' (default) Absolute value two-sample T-test with pooled
%                        variance estimate
%      'entropy'         Relative entropy, also known as Kullback-Lieber
%                        distance or divergence
%      'brattacharyya'   Minimum attainable classification error or
%                        Chernoff bound
%      'roc'             Area between the empirical receiver operating
%                        characteristic (ROC) curve and the random classifier
%                        slope
%      'wilcoxon'        Absolute value of the u-statistic of a two-sample
%                        unpaired Wilcoxon test, also known as Mann-Whitney
%      
%     Notes: 1) 'ttest', 'entropy', and 'brattacharyya' assume normal
%     distributed classes while 'roc' and 'wilcoxon' are nonparametric tests,
%     2) all tests are feature independent.
%
%    output: selec selected features
%
% Example:
%    load datafish
%    s0 = Xfclean(X);
%    f = X(:,s0); fn = Xn(s0,:);
%    op.p = 10;                      % 10 features will be selected
%    op.show = 1;                    % display results
%    op.criterion = 'roc';           % ROC criterion will be used
%    s = Xfrank(f,d,op);              % Feature selection, s is index of selected features
%    fs = f(:,s);                    % selected features
%    fns = fn(s,:)                   % list of feature names
%    op_lda.p = [];
%    ds = Xlda(fs,d,fs,op_lda);      % LDA classifier
%    p = Xaccuracy(d,ds)             % accuracy 

function selec = Xfrank(X,d,options)

m = options.p;
criterion = options.criterion;

dmin = min(d);
dmax = max(d);
k = dmax-dmin+1;

if not(exist('criterion','var'))
    criterion = 'ttest';
end

if k<2
    error('Xfrank: Number of classes of d must be greater than 1.');
end

if ~exist('rankfeatures','file')
    error('Xfrank: This function requires Bioinformatics Toolbox.');
end



if k==2;
    idx = rankfeatures(X',d,'criterion',criterion);
    selec = idx(1:m);
else
    [~,M] = size(X);
    S = zeros(M,k);
    for j=1:k
        dj = (d==j)+1;
        S(:,j) = rankfeatures(X',dj,'criterion',criterion);
    end    
    T = S';
    idx = T(:);
    i = 1;
    selec = zeros(m,1);
    selec(1) = idx(1);
    j=2;
    while i<=m
        if not(ismember(idx(j),selec))
            selec(i) = idx(j);
            i = i+1;
        end
        j = j + 1;
    end    
end


        
        
        
