% [X,d,Xn,x] = Xfxrandompatches(I,J,options)
%
% Toolbox Xvis
%
%    Feature extraction of random sliding windows.
%    This program select automatically detection windows sized mxm
%    with label '1' and lable '0'. For each window intensity features 
%    are extracted.
%
%    Input:
%    I             original image (more than one channel is allowed)
%    J             ideal segmentation
%    options.opf   feature extraction options (see example)
%    options.selec selected features, selec = 0 means all features
%    options.m     sliding window size in pixels (mxm)
%    options.n0    number of '0' windows
%    options.n1    number of '1' windows
%    options.ROI   region of interest where the windows are extracted
%    options.th0   if the number of '1' in detection window/m^2 < th0 a '0'
%                  sample is selected
%    options.th1   if the number of '1' in detection window/m^2 >=th1 a '1'
%                  sample is selected
%    options.show  display detected windows
%
%    Output:
%    X     feature values
%    Xn    feature names
%    d     ideal classification (0 or 1) of each sample
%    x     ceter of mass (j,i) of each patch
% Example:
% % X-ray image and Ground Truth for training and testing
% I             = Xloadimg('W',1,1,1);
% J             = Xloadimg('W',2,1,1);
% Itrain        = I(:,1650:2399);         % Training image
% GTtrain       = J(:,1650:2399);         % Ground truth of training image
% Itest         = I(:,900:1649);          % Testing image
% GTtest        = J(:,900:1649);          % Testing image
% 
% % Feature Extraction
% options.opf.b = Xfxbuild({'basicint','lbpri'}); % Basic intensity features
% options.selec = 0;                      % all features
% options.m     = 24;                     % size of a window mxm
% options.n0    = 400;                    % number of 0 windows
% options.n1    = 400;                    % number of 1 windows
% options.th0   = 0.02;                   % threshold for 0
% options.th1   = 0.02;                   % threshold for 1
% options.show  = 1;
% options.roi   = Xsegbimodal(Itrain);    % weld segmentation
% [X,d,Xn]      = Xfxrandompatches(...    % extraction of patches
%                 Itrain,GTtrain,options);% and feature extraction
% 
% % Feature Selection
% sc            = Xfclean(X);             % delete constant and correlated features  
% Xc            = X(:,sc);                % sc = indices of selected features
% Xcn           = Xn(sc,:);
% opsfs.show    = 1;                      % display results
% opsfs.p       = 15;                     % 15 features will be selected
% sx            = Xsfs(Xc,d,opsfs);       % using SFS
% selec         = sc(sx);
% fx            = X(:,selec);             % selec = indices of selected features
% 
% % Training
% opc.name      = 'qda';                  % LDA classifier 
% opc.options.p = [];
% opc           = Xclassify(fx,d,opc);
% 
% % Detection
% options.opc   = opc;
% options.nm    = 6;                     % shifted by 24/6=4 pixels
% options.Dth   = 24;                    % 24x24 pixels
% options.selec = selec;
% options.roi   = Xsegbimodal(Itest);    % weld segmentation
% [Dmap,Dbin]   = Xsegsliwin(Itest,options);
% figure                                 % output
% imshow(Itest);title('Detection');
% hold on
% [yd,xd]   = find(bwperim(Dbin)); 
% plot(xd,yd,'r.')
% [ygt,xgt]   = find(bwperim(GTtest)); 
% plot(xgt,ygt,'g.')
% legend({'detection','ground truth'})


function [X,d,Xn,x] = Xfxrandompatches(I,J,options)

warning off

opf   = options.opf;
% selec = options.selec;
m     = options.m;     % size of a window mxm
if isfield(options,'n0');
    n0    = options.n0;
else
    n0 = 0;
end
if isfield(options,'n1');
    n1    = options.n1;
else
    n1 = 0;
end

show  = options.show;

if isfield(options,'win');
    win   = options.m;
else
    win = 30;
end

if isfield(options,'roi');
    ROI   = options.roi;
    if isempty(ROI)
       ROI = ones(size(I));
    end        
else
    ROI = ones(size(I));
end

if isfield(options,'selec');
    selec  = options.selec;
else
    selec = 0;
end



[N,M]=size(I(:,:,1));

if show==1
    close all
    figure(1)
    imshow(I(:,:,1),[]);title('Original');
    pause(0)
    hold on
    figure(2)
    imshow(J);title('Ground truth');
    figure(1)
end


m1  = m-1;
md  = (m1-1)/2;
m2  = m*m;
R   = ones(m,m);

if show>0
    ff = statusbar('Extracting patches');
end

ft   = Xfxint(I(1:win,1:win),opf);
nf   = size(ft,2);

% f   = [];
% x   = [];
nn = n0+n1;
f = zeros(nn,nf);
x = zeros(nn,2);
d = [zeros(n0,1); ones(n1,1)];

k = 0;


if n0>0
    th0   = options.th0;

    % Extracting features for '0' detection windows
    if show==1
        disp('Extracting features for 0 detection windows...');
    end
    i   = 0;
    while i<n0
        i1 = fix(rand*(N-m1))+1;
        j1 = fix(rand*(M-m1))+1;
        rj = sum2(ROI(i1:i1+m1,j1:j1+m1))/m2;
        if rj>0.90
            wj = J(i1:i1+m1,j1:j1+m1);
            t = sum(wj(:))/m2;
            if t<th0
                wij  = I(i1:i1+m1,j1:j1+m1,:);
                [ft,fn]   = Xfxint(wij,R,opf);
                % f = [f;ft 0];
                % x = [x;j1+md i1+md];
                k = k+1;
                f(k,:) = ft;
                x(k,:) = [j1+md i1+md];
                i = i+1;
                if show>0
                    ff = statusbar(k/nn,ff);
                end
                if show==1
                    % fprintf('0: %d/%d\n',i,n0);
                    plot([j1 j1 j1+m1 j1+m1 j1],[i1 i1+m1 i1+m1 i1 i1],'g')
                    drawnow
                end
            end
        end
    end
end

if n1>0
    th1   = options.th1;

    % Extracting features for '1' detection windows
    if show==1
        disp('Extracting features for 1 detection windows...');
    end
    i = 0;
    while i<n1
        i1 = fix(rand*(N-m1))+1;
        j1 = fix(rand*(M-m1))+1;
        rj = sum2(ROI(i1:i1+m1,j1:j1+m1))/m2;
        if rj>0.95
            wj = J(i1:i1+m1,j1:j1+m1);
            t = sum(wj(:))/m2;
            if t>=th1
                wij     = I(i1:i1+m1,j1:j1+m1,:);
                [ft,fn] = Xfxint(wij,R,opf);
                % f       = [f;ft 1];
                % x       = [x;j1+md i1+md];
                k = k+1;
                f(k,:) = ft;
                x(k,:) = [j1+md i1+md];
                i       = i+1;
                if show>0
                    ff = statusbar(k/nn,ff);
                end

                if show==1
                    % fprintf('1: %d/%d\n',i,n1);
                    plot([j1 j1 j1+m1 j1+m1 j1],[i1 i1+m1 i1+m1 i1 i1],'r')
                    drawnow
                end
            end
        end
    end
end
if sum(selec)==0
    X  = f;
    Xn = fn;
else
    X  = f(:,selec);
    Xn = fn(selec,:);
end
if show>0
    delete(ff);
end



