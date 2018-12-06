% DminExample.m
close all
load datasim                    % simulated data (2 classes, 2 features)
                                % Xtrain,dtrain features and labels for training
                                % Xtest, dtest  features and labels for testing
subplot(1,2,1);
Xplotfeatures(Xtrain,dtrain)    % plot feature space for training data
subplot(1,2,2);
Xplotfeatures(Xtest,dtest)      % plot feature space for testing data
opc = [];                       % options of the classifier
par = Xdmin(Xtrain,dtrain,opc); % Euclidean distance classifier - training
ds  = Xdmin(Xtest,par);         % Euclidean distance classifier - testing
                                % ds = predicted labels for testing data
acc = Xaccuracy(ds,dtest)       % accuracy on test data