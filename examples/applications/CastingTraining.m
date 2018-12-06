% CastingTraining.m
sdir             = Xgdxdir('C',2);                        % directory of the images
sfmt             = 'png';                                 % format of the images
GT               = 'ground_truth.txt';                    % ground truth file
opx.opf.b        = Xfxbuild({'lbpri'});                   % LBP rotation invariant
opx.m            = 32;                                    % size of patches 0: 32x32
opx.n0           = 15;                                    % number of patche 0 per image
opx.th0          = 0.02;                                  % threshold for patch 0
opx.segmentation = 'Xsegbimodal';                         % wheel segmentation
opx.resize       = [32 32];                               % resize of patches 1: 32x32
[X0,d0,Xn]       = Xfxseqpatches(sdir,sfmt,GT,opx,0);     % Extracting patches 0
[X1,d1,Xn]       = Xfxseqpatches(sdir,sfmt,GT,opx,1);     % Extracting patches 1

X                = [X0;X1];                               % features if both classes
d                = [d0;d1];                               % labels of both classes

c.name           = 'knn';   c.options.k = 5;              % KNN with 5 neighbors
op.strat=1; op.c = c; op.v = 10; op.show = 1; op.p = 0.95;% 10 fold-cross-validation
[acc,ci]         = Xcrossval(X,d,op);