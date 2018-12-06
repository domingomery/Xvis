% FeatureSelectionSFS.m
close all
gdx_dir      = Xgdxdir('N',2);                  % directory of series N0002 of GDX
opf.b        = Xfxbuild({'basicint','gabor',... % features to be extracted
                         'lbpri','haralick'});  % rotation invariant for LBP
[X0,Xn0]     = Xfxtractor(gdx_dir,'png',opf);   % feature extraction
[X,Xn]       = Xnorotation(X0,Xn0);             % only rotation invariant features
d            = Xloaddata('N',2,'labels.txt');   % labels
sc           = Xfclean(X);                      % delete constant and correlated features  
figure                                             
Xc           = X(:,sc);                         % sc = indices of selected features
Xcn          = Xn(sc,:);
opsfs.show   = 1;                               % display results
opsfs.p      = 15;                              % 15 features will be selected
s1           = Xsfs(Xc,d,opsfs);                % using SFS
Y1           = Xc(:,s1);                        % s1 = indices of selected features
Y1n          = Xcn(s1,:);
opexs.show   = 1;                               % display results
opexs.p      = 3;                               % 3 (from 15) features will be selected
s2           = Xfexsearch(Y1,d,opexs);          % using exhaustive search
Y2           = Y1(:,s2);
Y2n          = Y1n(s2,:);
figure
Xplotfeatures(Y2,d,Y2n)                         % plot of feature space
grid on; view(-25,30)
