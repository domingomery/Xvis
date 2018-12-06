function bcl = Xclbuild(varargin)

v = varargin;
n = nargin;
if iscell(v)
    v = v{1};
    n = length(v);
end


bcl(n).name = ' ';
for k=1:n
    s = lower(char(v(k)));
    ok = 0;
    if strcmp(s(1:3),'knn')
        bcl(k).name = 'knn';
        bcl(k).options.k = str2num(s(4:end));
        ok = 1;
    end
    
    if strcmp(s(1:3),'svm')
        bcl(k).name = 'svm';
        bcl(k).options.kernel = ['-t ' s(4)];
        ok = 1;
    end
    
    if strcmp(s(1:3),'glm')
        bcl(k).name = 'glm';
        bcl(k).options.method = str2num(s(4:end));
        bcl(k).options.iter   = 12;
        ok = 1;
    end
    if strcmp(s(1:3),'mlp')
        bcl(k).name = 'glm';
        bcl(k).options.method = str2num(s(4:end));
        bcl(k).options.iter   = 12;
        bcl(k).options.nhidden = 6;
        bcl(k).options.ncycles = 60;
        bcl(k).options.alpa = 0.2;
        ok = 1;
    end
    
    if not(ok)
        switch lower(s)
            case 'lda'
                bcl(k).name = 'lda';
                bcl(k).options.p = [];
                
            case 'qda'
                bcl(k).name = 'qda';
                bcl(k).options.p = [];
            case 'maha'
                bcl(k).name = 'maha';
                bcl(k).options = [];
            case 'dmin'
                bcl(k).name = 'dmin';
                bcl(k).options = [];
            case 'pnn'
                bcl(k).name = 'pnn';
                bcl(k).options.p = [];
            case 'adaboost'
                bcl(k).name = 'adaboost';
                bcl(k).options.iter = 10;
            case 'boosting'
                bcl(k).name = 'boosting';
                bcl(k).options.s = 0.3;
            otherwise
                error('Xclbuild does not recognize %s as a classifier method.',s)
        end
    end
end

