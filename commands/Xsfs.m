% ix = Xsfs(X,d,options)
%
% Toolbox Xvis:
%    Sequential Forward Selection for fatures X according to ideal
%    classification d. optins.p features will be selected.
%    options.b.method = 'fisher' uses Fisher objetctive function.
%    options.b.method = 'sp100' uses as criteria Sp @Sn=100%.
%    options.b can be any Xvis classifier structure (see example).
%    options.show = 1 display results.
%    ix is the indices of the selected features.
%
% Example 1: SFS using Fisher dicriminant
%    load datafish
%    s0 = Xfclean(X);
%    f = X(:,s0); fn = Xn(s0,:);
%    op.p = 10;                      % 10 features will be selected
%    op.show = 1;                    % display results
%    f = Xfnorm(f,1);                % Normalization
%    s = Xsfs(f,d,op);               % SFS with Fisher cirterion. s is index of selected features
%    fs = f(:,s);                    % selected features
%    fns = fn(s,:)                   % list of feature names
%    op_lda.p = [];
%    ds = Xlda(fs,d,fs,op_lda);      % LDA classifier
%    p = Xaccuracy(d,ds)             % accuracy with sfs 
%
% Example 2: SFS using a KNN classifier
%    load datafish
%    s0 = Xfclean(X);
%    f = X(:,s0); fn = Xn(s0,:);
%    op.p = 10;                      % 10 features will be selected
%    op.show = 1;                    % display results
%    op.b.name = 'knn';              % SFS with KNN
%    op.b.options.k = 5;             % 5 neighbors
%    f = Xfnorm(f,1);                % Normalization
%    s = Xsfs(f,d,op);               % index of selected features
%    fs = f(:,s);                    % selected features
%    fns = fn(s,:)                   % list of feature names
%    op_knn.k = 5;
%    ds = Xknn(fs,d,fs,op_knn);      % KNN classifier
%    p = Xaccuracy(d,ds)             % accuracy with sfs 

function ix = Xsfs(X,d,options)

p      = options.p;

if ~isfield(options,'show')
   options.show = 0;
end

if ~isfield(options,'b')
   options.b.name = 'fisher';
end

show   = options.show;

if ~isfield(options,'force')
   options.force = 0;
end
force = options.force;


f      = X;
N      = size(f,2);
ix  = []; %selected features
J      = zeros(p,1);
% Jmax   = 0;
k      = 0;

if show
    ff = statusbar('SFS progress');
end
while (k<p)
    if show
        ff = statusbar(k/p,ff);
    end
    fnew = 0;
    Jmax = -Inf;
    for i=1:N
        if (k==0) || (sum(ix==i)==0)
            s = [ix; i];
            fs = f(:,s);
            Js = Xfscore(fs,d,options);
            if (Js>=Jmax)
                ks = i;
                Jmax = Js;
                fnew = 1;
            end
        end
    end
    if (fnew)
        ix = [ix; ks];
        k = k + 1;
        J(k) = Jmax;
        if show
            clf
            bar(J)
            colormap([1 0.6 0])
            fprintf('Jmax = %8.4f\n',Jmax);
            hold on
            for i=1:length(ix)
                text(i-0.4,J(i)*1.05,sprintf('%d',ix(i)));
            end
            xlabel('Selected features');
            ylabel('Objective function J');
            pause(0)
        end
    else
        disp('Xsfs: no more improvement. Sequential search for feature selection is interrupted.');
        if and(force,(k<p))
           fprintf('Xsfs: Warning! %d random features were selected in order to have\n',p-k);
           fprintf('                  %d selected features (options.force is true).\n',p);
           t = 1:N;
           t(ix) = [];
           n = length(t);
           x = rand(n,1);
           [~,j] = sort(x);
           ix = [ix; t(j(1:p-k))' ];
         end

        k = 1e10;
    end
end
if show
    delete(ff);
end
