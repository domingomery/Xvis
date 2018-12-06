% ManyClassifiersExample.m
close all; clear opc; clt
load datasim  % simulated data (2 classes, 2 features)
              % Xtrain,dtrain features and labels for training
              % Xtest, dtest  features and labels for testing
k = 0;
k=k+1;opc(k).name = 'dmin';  opc(k).options.p = [];           % Euclidean distance
k=k+1;opc(k).name = 'maha';  opc(k).options.p = [];           % Mahalanobis distance
k=k+1;opc(k).name = 'bayes'; opc(k).options.p = [];           % Bayes
k=k+1;opc(k).name = 'lda';   opc(k).options.p = [];           % LDA
k=k+1;opc(k).name = 'qda';   opc(k).options.p = [];           % QDA
k=k+1;opc(k).name = 'knn';   opc(k).options.k = 5;            % KNN with 5 neighbors
k=k+1;opc(k).name = 'knn';   opc(k).options.k = 15;           % KNN with 5 neighbors
k=k+1;opc(k).name = 'glm';   opc(k).options.method = 2; opc(k).options.iter = 12;   % GLM
k=k+1;opc(k).name = 'mlp';   opc(k).options.method = 2; opc(k).options.alpha = 0.2; % MLP
      opc(k).options.iter=12;opc(k).options.nhidden = 6;opc(k).options.ncycles = 60;
k=k+1;opc(k).name = 'svm';   opc(k).options.kernel = '-t 0';  % linear-SVM
k=k+1;opc(k).name = 'svm';   opc(k).options.kernel = '-t 1';  % polynomial-SVM
k=k+1;opc(k).name = 'svm';   opc(k).options.kernel = '-t 2';  % rbf-SVM
par = Xclassify(Xtrain,dtrain,opc);
ds = Xclassify(Xtest,par);      % Training & Testing
Xdecisionline(Xtrain,dtrain,Xn,par);
acc = Xaccuracy(ds,dtest);                    % Accuracy on test data
for i=1:k                                     % Output
    fprintf('%8s: %5.2f%%\n',opopc(i).name,100*acopc(i));
end