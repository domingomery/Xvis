% SeparationExample.m
clt
dir_obj1 = Xgdxdir('B',49);                       % directory of guns (class 1)
dir_obj2 = Xgdxdir('B',50);                       % directory of shuriken (class 2)
dir_obj3 = Xgdxdir('B',51);                       % directory of razor blades (class 3)
opf.b    = Xfxbuild({'basicgeo','fitellipse','flusser','fourierdes',...
                     'gupta','hugeo'});           % features to be extracted
opf.segmentation = 'Xsegbimodal';                 % segmentation approach
[X1,X1n] = Xfxtractor(dir_obj1,'png',opf);        % feature extraction of class 1 
[X2,X2n] = Xfxtractor(dir_obj2,'png',opf);        % feature extraction of class 2 
[X3,X3n] = Xfxtractor(dir_obj3,'png',opf);        % feature extraction of class 3
N1 = size(X1,1); N2 = size(X2,1); N3 = size(X3,1);% number of samples per class
d = [ones(N1,1); 2*ones(N2,1); 3*ones(N3,1)];     % labels
X0 = [X1;X2;X3]; X0n = X1n;                       % features of all classes
[Xa,Xan] = Xnorotation(X0,X0n);                   % only rotation invariant
[Xb,Xbn] = Xnotranslation(Xa,Xan);                % only translation invariant
[Xc,Xcn] = Xnoscale(Xb,Xbn);                      % only scale invariant
s0 = Xfclean(Xc);                                 % cleaning
Xd = Xc(:,s0); Xdn = Xcn(s0,:);
op.p = 3; op.show = 1;                            % 3 features will be selected
f = Xfnorm(Xd,1);                                 % normalization
s = Xsfs(f,d,op);                                 % SFS with Fisher cirterion.
Xs = f(:,s); Xns = Xdn(s,:);                      % selected features
figure
Xplotfeatures(Xs,d,Xns);                          % feature space