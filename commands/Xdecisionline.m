% Xdecisionline(X,d,op)
%
% Toolbox Xvis:
%
%    Diaplay a 2D feature space and decision line.
%
%    X: Sample data
%    d: classification of samples
%    op: output of a trained classifier.
%
%    Example:
%       load datasim                                           % simulated data (2 classes, 2 features)
%       k = 0;
%       k=k+1;c(k).name = 'dmin';     c(k).options.p = [];           % Euclidean distance
%       k=k+1;c(k).name = 'maha';     c(k).options.p = [];           % Mahalanobis distance
%       k=k+1;c(k).name = 'bayes';    c(k).options.p = [];           % Bayes
%       k=k+1;c(k).name = 'lda';      c(k).options.p = [];           % LDA
%       k=k+1;c(k).name = 'qda';      c(k).options.p = [];           % QDA
%       k=k+1;c(k).name = 'knn';      c(k).options.k = 5;            % KNN with 5 neighbors
%       k=k+1;c(k).name = 'knn';      c(k).options.k = 15;           % KNN with 5 neighbors
%       k=k+1;c(k).name = 'glm';      c(k).options.method = 2;     c(k).options.iter = 12;   % GLM
%       k=k+1;c(k).name = 'mlp';      c(k).options.method = 2;     c(k).options.alpha = 0.2; % MLP 
%             c(k).options.iter = 12; c(k).options.nhidden = 6;    c(k).options.ncycles = 60;
%       k=k+1;c(k).name = 'svm';      c(k).options.kernel = '-t 0';  % linear-SVM
%       k=k+1;c(k).name = 'svm';      c(k).options.kernel = '-t 1';  % polynomial-SVM
%       k=k+1;c(k).name = 'svm';      c(k).options.kernel = '-t 2';  % rbf-SVM
%       options = Xclassify(Xtrain,dtrain,c);
%       close all
%       Xdecisionline(Xtrain,dtrain,Xn,options);

function Xdecisionline(X,d,Xn,op)
if size(X,2)~=2
    error('Xdecisionline works for two features only.')
end
clf
Xplotfeatures(X,d,Xn);
n = length(op);
hold on
ax = axis;
sx=(ax(2)-ax(1))/100;
sy=(ax(4)-ax(3))/100;
x = ax(1):sx:ax(2);
nx = length(x);
y = ax(3):sy:ax(4);
ny = length(y);
rx = ones(ny,1)*x;
ry = y'*ones(1,nx);
XXt = [rx(:) ry(:)];
op = Xclassify(X,d,op);
dt = Xclassify(XXt,op);

dmin = min(d);
dmax = max(d);
scol = 'yccwkbr';
col = 'gbrcmykbgrcmykbgrcmykbgrcmykgbrcmykbgrcmykbgrcmykbgrcmykgbrcmykbgrcmykbgrcmykbgrcmyk';
mar = 'ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^ox+v^';

close all
for k=1:n
    figure; 
    Xplotfeatures(X,d,Xn);
    title(op(k).options.string)
    for i=dmin:dmax
        ii = find(dt(:,k)==i);
        plot(XXt(ii,1),XXt(ii,2),[scol(i-dmin+1) '.']);
        ii = find(d==i);
        plot(X(ii,1),X(ii,2),[col(i-dmin+1) mar(i-dmin+1)]);
    end
end
