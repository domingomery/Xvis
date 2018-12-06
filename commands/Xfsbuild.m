function bfs = Xfsbuild(varargin)

v = varargin;
n = nargin;
if compare(class(v),'cell')==0
    v = v{1};
    n = length(v);
end

bfs(n).name = ' ';
for k=1:n
    s0 = lower(char(v(k)));
    s = [s0 '              '];
    ok = 0;
    if strcmp(s(1:7),'sfs-knn')
        bfs(k).name = 'sfs';
        bfs(k).options.b.name    = 'knn';
        bfs(k).options.b.options.k = str2num(s(8:end));
        ok = 1;
    end
    if strcmp(s(1:7),'sfs-svm')
        bfs(k).name = 'sfs';
        bfs(k).options.b.name    = 'svm';
        bfs(k).options.b.options.kernel = ['-t ' s(8)];
        ok = 1;
    end
    if strcmp(s(1:7),'sfs-glm')
        bfs(k).name = 'sfs';
        bfs(k).options.b.name    = 'glm';
        bfs(k).options.b.options.method = str2num(s(8:end));
        bfs(k).options.b.options.iter = 12;
        ok = 1;
    end
    
    if strcmp(s(1:7),'sfs-mlp')
        bfs(k).name = 'sfs';
        bfs(k).options.b.name    = 'mlp';
        bfs(k).options.b.options.method = str2num(s(8:end));
        bfs(k).options.b.options.iter = 12;
        bfs(k).options.b.options.nhidden = 6;
        bfs(k).options.b.options.ncycles = 60;
        bfs(k).options.b.options.alpa = 0.2;
        ok = 1;
    end
    
    if not(ok)
        switch s0
            case 'fosmod';
                bfs(k).name = 'fosmod';
                bfs(k).options = [];
                
            case 'lsef';
                bfs(k).name = 'lsef';
                bfs(k).options = [];
                
            case 'sfs-fisher';
                bfs(k).name = 'sfs';
                bfs(k).options.b.name    = 'fisher';
                
            case 'sfs-sp100';
                bfs(k).name = 'sfs';
                bfs(k).options.b.name    = 'sp100';
                
            case 'sfs-lda'
                bfs(k).name = 'sfs';
                bfs(k).options.b.name    = 'lda';
                bfs(k).options.b.options.p = [];
            case'sfs-qda'
                bfs(k).name = 'sfs';
                bfs(k).options.b.name    = 'qda';
                bfs(k).options.b.options.p = [];
            case 'rank-roc';
                bfs(k).name = 'frank';
                bfs(k).options.criterion = 'roc';
                
            case 'rank-ttest';
                bfs(k).name = 'frank';
                bfs(k).options.criterion = 'ttest';
                
            case 'rank-entropy';
                bfs(k).name = 'frank';
                bfs(k).options.criterion = 'entropy';
                
            case 'plsr';
                bfs(k).name = 'Xplsr';
                
            case 'pca';
                bfs(k).name = 'Xpca';
                
            case 'lsef-plsr';
                bfs(k).name = 'Xlsef';
                bfs(k).options.pca = 0;
                
            case 'lsef-pca';
                bfs(k).name = 'Xlsef';
                bfs(k).options.pca = 1;
                
            case 'mrmr';
                bfs(k).name = 'fmRMR';
                
            case 'all';
                bfs(k).name = 'Xfall';
                
            otherwise
                error('Xfsbuild does not recognize %s as feature selection method.',s)
                
        end
    end
end