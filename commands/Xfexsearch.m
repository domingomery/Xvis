% selec = Xfexsearch(X,d,options)
%
% Toolbox Xvis:
%    Feature selection using exhaustive search for fatures X according to 
%    ideal classification d. optins.p features will be selected.
%    options.b.method = 'fisher' uses Fisher objetctive function.
%    options.b.method = 'sp100' uses as criteria Sp @Sn=100%.
%    options.b can be any Xvis classifier structure (see example).
%    options.show = 1 display results.
%    selec is the indices of the selected features.
%
% Example 1: Exhaustive search from using Fisher dicriminant
%    load datafish
%    s1 = [81 28 53 4 84 62 34 77 35 3]; % indices using Example of Xsfs
%    X1 = X(:,s1);                       % preselected features
%    Xn1 = Xn(s1,:);                     % names of the preselected features
%    op.p = 3;                           % 3 features will be selected
%    op.show = 1;                        % display results
%    op.b.name = 'fisher';               % Fisher criterion
%    s = Xfexsearch(X1,d,op);            % index of selected features
%    X2 = X1(:,s);                       % selected features
%    Xn2 = Xn1(s,:)                      % list of feature names
%
% Example 2: Exhaustive serach using a KNN classifier
%    load datafish
%    s1 = [81 28 53 4 84 62 34 77 35 3]; % indices using Example of Xsfs
%    X1 = X(:,s1);                       % preselected features
%    Xn1 = Xn(s1,:);                     % names of the preselected features
%    op.p = 4;                           % 3 features will be selected
%    op.show = 1;                        % display results
%    op.b.name = 'knn';                  % SFS with KNN
%    op.b.options.k = 5;                 % 5 neighbors
%    s = Xfexsearch(X1,d,op);            % index of selected features
%    X2 = X1(:,s);                       % selected features
%    Xn2 = Xn1(s,:)                      % list of feature names

function selec = Xfexsearch(X,d,options)

p = options.p;


if ~isfield(options,'show')
   options.show = 0;
end

if ~isfield(options,'b')
   options.b.name = 'fisher';
end


show = options.show;

M = size(X,2);

N = nchoosek(M,p);

if (N>10000)
    ok = input(sprintf('Exhaustive Search needs %d evaluations... continue [yes=1/no=0]?',N));
    if not(ok)
        error('Exhaustive search for feature selection interrupted.')
    end
end

T = nchoosek(1:M,p);

Jmax = 0;
for i=1:N
    fs = X(:,T(i,:));
    Js = Xfscore(fs,d,options);
    if (Js>Jmax)
        Jmax = Js;
        ks = i;
        if show
           fprintf('step=%2d/%d J=%X\n',i,N,Jmax)
        end
    end
end
selec = T(ks,:)';
