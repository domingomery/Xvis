% SimpleClassifiersExample.m
close all; clear opc;
load datasim  % simulated data (2 classes, 2 features)
              % Xtrain,dtrain features and labels for training
              % Xtest, dtest  features and labels for testing
pc = [0.5 0.5];                              % priors for each class
opc(1).name = 'maha';opc(1).options.p = pc;  % Mahalanobis distance
opc(2).name = 'lda'; opc(2).options.p = pc;  % LDA
opc(3).name = 'qda'; opc(3).options.p = pc;  % QDA
ds = Xclassify(Xtrain,dtrain,Xtest,opc);     % Training & Testing
acc = Xaccuracy(ds,dtest);                   % Accuracy on test data
for i=1:3                                    % Output
    fprintf('%8s: %5.2f%%\n',opc(i).name,100*acc(i));
end