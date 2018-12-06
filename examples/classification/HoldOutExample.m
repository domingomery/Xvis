% HoldOutExample.m
load datasim                         % simulated data (2 classes, 2 features)
X = Xtrain; d = dtrain;              % data selection
c.name = 'knn'; c.options.k = 5;     % knn with 5 neighbors
op.c = c; op.strat = 1;op.s = 0.75;  % stratify with S=75% for training
acc = Xholdout(X,d,op)               % holdout