% BayesExample.m
close all; clear opc
load datasim  % simulated data (2 classes, 2 features)
              % Xtrain,dtrain features and labels for training
              % Xtest, dtest  features and labels for testing
Xplotfeatures(Xtrain,dtrain)          % plot feature space
op.p = [0.5 0.5];                     % prior probability
op.show = 1;                          % display results
ds = Xbayes(Xtrain,dtrain,Xtest,op);  % Bayes classifier
acc = Xaccuracy(ds,dtest)             % accuracy on test data