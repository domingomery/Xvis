% ds      = Xclstruc(X,d,Xt,options)  Training & Testing together
% options = Xclstruc(X,d,options)     Training only
% ds      = Xclstruc(Xt,options)      Testing only
%
% Toolbox Xvis:
%    Classification using Xvis classifier(s) defined in structure b.
%
%    Design data:
%       X is a matrix with features (columns)
%       d is the ideal classification for X
%       options is a Xvis classifier structure b with
%          b.name      = Xvis classifier's name
%          b.options   = options of the classifier
%
%       b can define one or more classifiers (see example).
%
%    Test data:
%       Xt is a matrix with features (columns)
%
%    Output:
%       ds is the classification on test data (one column per classifier)
%
%    Example: Training & Test together:
%       load datagauss                                                        % simulated data (2 classes, 2 features)
%       b(1).name = 'knn';   b(1).options.k = 5;                              % KNN with 5 neighbors
%       b(2).name = 'knn';   b(2).options.k = 7;                              % KNN with 7 neighbors
%       b(3).name = 'knn';   b(3).options.k = 9;                              % KNN with 9 neighbors
%       b(4).name = 'lda';   b(4).options.p = [];                             % LDA
%       b(5).name = 'qda';   b(5).options.p = [];                             % QDA
%       b(6).name = 'nnglm'; b(6).options.method = 3; b(6).options.iter = 10; % Nueral network
%       b(7).name = 'svm';   b(7).options.kernel = 4;                         % rbf-SVM
%       b(8).name = 'maha';  b(8).options = [];                               % Euclidean distance
%       b(9).name = 'dmin';  b(9).options = [];                               % Mahalanobis distance
%       op = b;
%       ds = Xclstruc(X,d,Xt,op);                                        % ds has 9 columns
%       p = Xaccuracy(ds,dt)                                            % p has 9 performances
%
%
%    Example: Training only
%       load datagauss                                                        % simulated data (2 classes, 2 features)
%       b(1).name = 'knn';   b(1).options.k = 5;                              % KNN with 5 neighbors
%       b(2).name = 'knn';   b(2).options.k = 7;                              % KNN with 7 neighbors
%       b(3).name = 'knn';   b(3).options.k = 9;                              % KNN with 9 neighbors
%       b(4).name = 'lda';   b(4).options.p = [];                             % LDA
%       b(5).name = 'qda';   b(5).options.p = [];                             % QDA
%       b(6).name = 'nnglm'; b(6).options.method = 3; b(6).options.iter = 10; % Nueral network
%       b(7).name = 'svm';   b(7).options.kernel = 4;                         % rbf-SVM
%       b(8).name = 'maha';  b(8).options = [];                               % Euclidean distance
%       b(9).name = 'dmin';  b(9).options = [];                               % Mahalanobis distance
%       op = b;
%       op = Xclstruc(X,d,op);                                           % Training only
%
%    Example: Testing only (after training only example):
%       ds = Xclstruc(Xt,op);                                            % Testing only
%       p  = Xaccuracy(ds,dt)
function [ds,options] = Xclstruc(varargin)
%[train,test,X,d,Xt,options] = Xconstruct(varargin{:});

error('Change in last program Xclstruc by Xclassify!');



% b = options;
% n = length(b); % number of classifiers
% 
% if train
%     for i=1:n
%         Cname = b(i).name;
%         if Cname(1) ~= 'X'
%             Cname = ['X' Cname];
%         end
%         b(i).options = feval(Cname,X,d,b(i).options);
%     end
%     options = b;
%     ds = options;
% end
% if test
%     nt = size(Xt,1);
%     ds3 = zeros(nt,n,2);
%     d3 = 0;
%     for i=1:n
%         Cname = b(i).name;
%         if Cname(1) ~= 'X'
%             Cname = ['X' Cname];
%         end
%         dsi = feval(Cname,Xt,b(i).options);
%         ds3(:,i,1) = dsi(:,1);
%         if size(dsi,2)==2
%             ds3(:,i,2) = dsi(:,2);
%             d3 = 1;
%         end
%     end
%     if d3
%         ds = ds3;
%     else
%         ds = ds3(:,:,1);
%     end
% end
% 
