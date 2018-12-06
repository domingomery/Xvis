% ConfusionMatrixExample.m
close all;
load datasim  % simulated data (2 classes, 2 features)
              % Xtrain,dtrain features and labels for training
              % Xtest, dtest  features and labels for testing
op1.p = [0.5 0.5];                        % priors for LDA         
ds1   = Xlda(Xtrain,dtrain,Xtest,op1);    % LDA classifier
T1    = Xconfusion(dtest,ds1)             % Confusion Matrix
figure(1);
Xshowconfusion(T1,1);title('lda')         % Display confusion matrix
op2.kernel = '-t 2';                      % SVM parameter for RBF kernel
ds2   = Xsvm(Xtrain,dtrain,Xtest,op2);    % SVM classifier
T2    = Xconfusion(dtest,ds2)             % Confusion Matrix
figure(2);
Xshowconfusion(T2,1);title('svm-rbf')     % Display confusion matrix