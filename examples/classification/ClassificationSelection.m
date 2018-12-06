% ClassificationSelection.m
close all 
imagesdir  = Xgdxdir('N',2);                     % directory of series N0002 of GDX
opf.b      = Xfxbuild({'basicint','gabor',...    % features to be extracted
                       'lbpri','haralick'});     
[X0,Xn0]   = Xfxtractor(imagesdir,'png',opf);    % feature extraction
[X,Xn]     = Xnorotation(X0,Xn0);                % only rotation invariant features
d          = Xloaddata('N',2,'labels.txt');      % labels
fs         = {'sfs-fisher','mRMR','rank-ttest'}; % Feature selectors to be tested
cl         = {'dmin','maha','lda','qda',...      % Classifiers to be tested
              'glm1','glm2','pnn','svm2'};       
options.Xn = Xn;                                 % Feature names
options.p  = 20;                                 % Maximal number of selected features
figure
[bcs,selec,acc] = Xclsearch(X,d,cl,fs,options);  % Feature and classifier selection
