% [bcs,selec,acc,ci,sp] = Xclsearch(X,d,cl,fs,options)
%
% Toolbox Xvis
%    Feature and classifier selection tool.
%    Exhaustive search of the best classifier of the classifiers given in
%    cl structure using the features selected by feature selection
%    algorithms given in fs structure.
%
%    X features
%    d ideal      classification
%    cl          structure of classifiers
%    fs          structure of feature selectors
%    options.Xn   name of the features (optional)
%    options.v    cross validation folder (default = 10)
%    options.c    cross validation confidence interval (default = 0.95)
%    options.m    maximum number of features to be selected
%    options.show display results (deafult = 1)
%
%    bcs: selected classifier
%    selec: selected features
%    acc: best accuracy 
%    ci: confidence interval
%    sp is a Nc x m x Nq matrix with information about the performance
%    sp(i,j,q) contains cross validation information obtained by classifier
%    cl(i), using the first j select features given by feature selection
%    algorithm q.
%
% Example:
% load datareal % f & fn is loaded
%
% cl(1).name = 'knn';   cl(1).options.k = 5;      % KNN with 5 neighbors
% cl(2).name = 'knn';   cl(2).options.k = 7;      % KNN with 7 neighbors
% cl(3).name = 'knn';   cl(3).options.k = 9;      % KNN with 9 neighbors
% cl(4).name = 'lda';   cl(4).options.p = [];     % LDA
% cl(5).name = 'qda';   cl(5).options.p = [];     % QDA
% cl(6).name = 'svm';   cl(6).options.kernel = 4; % rbf-SVM
% cl(7).name = 'maha';  cl(7).options = [];       % Euclidean distance
% cl(8).name = 'dmin';  cl(8).options = [];       % Mahalanobis distance
%
%
% fs(1).name = 'sfs';   fs(1).options.b.name    = 'fisher';
% fs(2).name = 'sfs';   fs(2).options.b.name    = 'knn'; fs(2).options.b.options.k = 5;
% fs(3).name = 'sfs';   fs(3).options.b.name    = 'sp100';
% fs(4).name = 'sfs';   fs(4).options.b.name    = 'knn'; fs(4).options.b.options.k = 7;
% fs(5).name = 'frank';  fs(5).options.criterion = 'roc';
%
% options.Xn   = fn;
% options.cl  = cl;
% options.fs  = fs;
% options.p    = 10;
%
% [bcs,selec,acc,ci] = Xclsearch(f,d,cl,fs,options);

function [bcs,selec,acc,ci,sp] = Xclsearch(X,d,cl,fs,options)

if ~isfield(options,'opcv')
    options.opcv.v = 10;
    options.opcv.p = 0.95;
    options.opcv.strat = 1;
    options.opcv.show = 1;
end



if nargin == 3
    options = cl;
    fs = options.fs;
    cl = options.cl;
end

% if ~isfield(options,'v')
%     options.v = 10;
% end

if ~isfield(options,'sub')
    options.sub = 1;
end

if ~isfield(options,'outfile')
    options.outfile = 'Xseldata';
end

if ~isfield(options,'show')
    options.show = 1;
    % close all
end

if iscell(fs)
    fs = Xfsbuild(fs);
end

if iscell(cl)
    cl = Xclbuild(cl);
end


f    = X;
fn   = options.Xn;
mmax = options.p;
show = options.show;
options.opcv.c = cl;

if show
    disp(' ');
    disp(' ');
    disp('Feature and Classifier Selection Tool:')
    disp('======================================')
    % clf
    fsb = statusbar('Feature selection');
end


f_original = f;
d_original = d;

if options.sub <1
    [f,d] = Xstratify(f,d,options.sub);
end

s0      = Xfclean(f);
X0      = Xfnorm(f(:,s0),0);
m       = min(mmax,size(X0,2));
n       = length(cl);   % number of classifiers
nq      = length(fs);   % number od feature selectors
P       = zeros(n,m,nq);
mf      = 0;             % number of features
qs      = 0;             % number of feature selection algorithm
op.b    = cl;
op.show = 0;
sq      = zeros(m,nq);
Sqname  = [];

X = X0;

for q = 1:nq
    if show
        fsb = statusbar(q/nq,fsb);
    end
    fs(q).options.p    = m;
    fs(q).options.show = 0;
    ss = fs(q).name;
    ft = 0;
    %     if compare(ss(1:3),'Bfs')
    %         if compare(ss(1:3),'Bft')==0
    %             ft = 1;
    %             fxname = ss;
    %         else
    %             fxname = ['X' ss];
    %         end
    if ss(1) == 'X'
        fxname = ss;
    else
        fxname = ['X' ss];
    end
    %     else
    %         fxname = ss;
    %
    %     end
    opf = fs(q).options;
    if isfield(opf,'b')
        ss = [num2str(q) ':' ss '-' opf.b.name];
    else
        ss = [num2str(q) ':' ss ];
    end
    ss = [ss '                 '];
    ss = ss(1:16);
    if show
        fprintf('\nSelecting %d from %d features (in %d samples) using algorithm %s...\n',m,size(X0,2),size(X0,1),ss)
    end
    if ft==0
        s1 = feval(fxname,X0,d,fs(q).options);
    else
        Xs1 = feval(fxname,X0,d,fs(q).options);
        Mx = size(X,2);
        Mf = size(f,2);
        Mx1 = size(Xs1,2);
        X = [X Xs1];
        f = [f Xs1];
        s1 = (Mx+1:Mx+Mx1)';
        sf = (Mf+1:Mf+Mx1)';
        s0 = [s0;sf];
        for i=1:Mx1
            si = [fxname '-' num2str(i) '                             '];
            fn = [fn;si(1:24)];
        end
    end
    fprintf('> %d features selected.\n',length(s1))
    s1 = [s1;zeros(1000,1)];
    Sqname = [Sqname; ss];
    sq (:,q) = s1(1:m);
    save(options.outfile,'Sqname','sq','fs','options');
end
delete(fsb);

xmf     = [];
ymf     = [];
c1f     = [];
c2f     = [];
STRclass=[];
pkmax   = 0;
if show
    fsb = statusbar('Classifier selection',fsb);
end
for k=1:m       % features
    if pkmax<1 % when p=100% no more testing!!!
        
        if show
            fsb = statusbar(k/m,fsb);
        end
        
        pqmax = 0;
        if show
            fprintf('\nComputing performances for the %d best feature(s) using...\n',k)
        end
        pnew = 0;
        for q=1:nq  % feature selection algorithms
            s = sq(1:k,q);
            s = s(s>0);
            if length(s)==k
                %            Xk = X(:,s);
                Xk = f_original(:,s0(s));
                if show
                    fprintf('> Feature Selection %s... ',Sqname(q,:))
                end
                
                [acc,ci] = Xcrossval(Xk,d_original,options.opcv);
                P(1:n,k,q) = acc;
                for i=1:n
                    cset = cl(i);
                    % cset.features = s0(s)';
                    cset.ci = ci(i,:);
                    cset.per = acc(i);
                    sp(i,k,q) = cset;
                end
                
                [i,j] = max(acc);
                if (i>pqmax)
                    pqmax = i;
                    js = j;
                    qs = q;
                    ssq = s;
                end
                if (pqmax>pkmax)
                    pnew = 1;
                    pkmax = pqmax;
                    c1 = ci(j,1);
                    c2 = ci(j,2);
                    strnclass = [cl(js).name '            '];
                    strnclass = [strnclass(1:12) ' ' Sqname(qs,:)];
                    mf = k;
                    qss = Sqname(qs,:);
                    ip = js;
                    kp = k;
                    qp = qs;
                    bcs = cl(js);
                    selec = s0(ssq);
                    st = '*** best ***';
                else
                    st = ' ';
                end
                if show
                    strj = [cl(j).name '              '];
                    fprintf(' Best classifier %s: Accuracy = %5.2f%% %s\n',strj(1:8),i*100,st);
                end
            end
        end
        
        if show
            xmf = [xmf; mf];
            ymf = [ymf;100*pkmax];
            c1f = [c1f;100*c1];
            c2f = [c2f;100*c2];
            
            plot(xmf,ymf,'b','LineWidth',2);
            plot(xmf,c1f,'r:');
            plot(xmf,c2f,'r:');
            xlabel('Number of features')
            ylabel('Accuracy [%]');
            axis([0 m 50 100])
            hold on
            pause(0)
            if pnew
                STRclass = [STRclass;sprintf('%3d) %s > %6.2f%%',xmf(end), strnclass,100*max(P(:)))];
            end
        end
        
    end
end





[~,bcs] = Xclassify(X,d,bcs);
if show
    delete(fsb);
    legend('Confidence Interval','Accuracy','Location','SouthEast')
    disp(' ');
    disp(' ');
    disp('Summary:');
    disp('========');
    disp(' ');
    disp('Accuracy vs. Number of features')
    for i=1:size(STRclass,1)
        fprintf('%s\n',STRclass(i,:))
    end
    
    disp(' ');
    if ~isempty(fn)
        fprintf('Selected features for the last classifier:\n')
        for i=1:length(selec)
            fprintf('%3d) %s\n',i,fn(selec(i),:))
        end
    end
    disp(' ');
    %fprintf('                 Accuracy: %5.2f%% in (%5.2f, %5.2f%%) with CI=%5.2f%%\n',P(ip,kp,qp)*100,sp(ip,kp,qp).ci(1)*100,sp(ip,kp,qp).ci(2)*100,options.opcv.p*100);
    fprintf('                 Accuracy: %5.2f%% in (%5.2f, %5.2f%%) with CI=%5.2f%%\n',P(ip,kp,qp)*100,sp(ip,kp,qp).ci(1)*100,sp(ip,kp,qp).ci(2)*100,options.opcv.p*100);
    fprintf('Folds of Cross Validation: %d\n',options.opcv.v);
    fprintf('               Classifier: %s\n',bcs.options.string);
    fprintf(' Feature Selection Method: %s\n',qss);
    fprintf('    %2d Selected Features: %s\n',length(selec),num2str(selec'));
    
end
ci = [sp(ip,kp,qp).ci(1) sp(ip,kp,qp).ci(2)];
acc = P(ip,kp,qp);

nq = strfind(qss,':');

bcs.fs_method = qss(nq+1:end);