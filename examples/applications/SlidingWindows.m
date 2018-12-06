% SlidingWindows.m

% X-ray image and Ground Truth for training and testing
I             = Xloadimg('W',1,1,1);
J             = Xloadimg('W',2,1,1);
Itrain        = I(:,1650:2399);         % Training image
GTtrain       = J(:,1650:2399);         % Ground truth of training image
Itest         = I(:,900:1649);          % Testing image
GTtest        = J(:,900:1649);          % Testing image

% Feature Extraction
options.opf.b = Xfxbuild({'basicint',...
                          'lbpri'});    % Basic intensity features
options.selec = 0;                      % all features
options.m     = 24;                     % size of a window mxm
options.n0    = 400;                    % number of 0 windows
options.n1    = 400;                    % number of 1 windows
options.th0   = 0.02;                   % threshold for 0
options.th1   = 0.02;                   % threshold for 1
options.show  = 1;
options.roi   = Xsegbimodal(Itrain);    % weld segmentation
[X,d,Xn]      = Xfxrandompatches(...    % extraction of patches
                Itrain,GTtrain,options);% and feature extraction

% Feature Selection
sc            = Xfclean(X);             % delete constant and correlated features  
Xc            = X(:,sc);                % sc = indices of selected features
Xcn           = Xn(sc,:);
opsfs.show    = 1;                      % display results
opsfs.p       = 15;                     % 15 features will be selected
sx            = Xsfs(Xc,d,opsfs);       % using SFS
selec         = sc(sx);
fx            = X(:,selec);             % selec = indices of selected features

% Training
opc.name      = 'qda';                  % LDA classifier 
opc.options.p = [];
opc           = Xclassify(fx,d,opc);

% Detection
options.opc   = opc;
options.nm    = 6;                     % shifted by 24/6=4 pixels
options.Dth   = 24;                    % 24x24 pixels
options.selec = selec;
options.roi   = Xsegbimodal(Itest);    % weld segmentation
[Dmap,Dbin]   = Xsegsliwin(Itest,options);
figure                                 % output
imshow(Itest);title('Detection');
hold on
[yd,xd]   = find(bwperim(Dbin)); 
plot(xd,yd,'r.')
[ygt,xgt]   = find(bwperim(GTtest)); 
plot(xgt,ygt,'g.')
legend({'detection','ground truth'})
