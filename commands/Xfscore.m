function Js = Xfscore(X,d,options)

b      = options.b;
method = b.name;


switch lower(method)
    case 'mi' % mutual information
        if ~isfield(b,'param')
            dn = max(d)-min(d)+1; % number of classes

            p = ones(dn,1)/dn;
        else
            p = b.param;
        end
        Js = Xfmutualinfo(X,d,p);        
    case 'mr' % maximal relevance
        if ~isfield(b,'param')
            dn = max(d)-min(d)+1; % number of classes

            p = ones(dn,1)/dn;
        else
            p = b.param;
        end
        Js = Xfrelevance(X,d,p);        
    case 'mrmr' % minimal redundancy and maximal relevance
        if ~isfield(b,'param')
            dn = max(d)-min(d)+1; % number of classes

            p = ones(dn,1)/dn;
        else
            p = b.param;
        end
        Js = XfmRMR(X,d,p);        
    case 'fisher'
        if ~isfield(b,'param')
            dn = max(d)-min(d)+1; % number of classes

            p = ones(dn,1)/dn;
        else
            p = b.param;
        end
        Js = Xjfisher(X,d,p);
    case 'sp100'
        Js = Xfsp100(X,d);
    otherwise
        ds = Xclassify(X,d,X,b);
        Js = Xaccuracy(d,ds);
end
