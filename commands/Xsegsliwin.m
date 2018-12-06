% [Dmap,Dbin] = Xsegsliwin(I,options)
%
% Toolbox Xvis
%
%    Segmentation using sliding windows
%
%    Input:
%    I             original image
%    options.opf   feature extraction options (see example)
%    options.opc   classifier options (see example)
%    options.selec selected features, selec = 0 means all features
%    options.m     sliding window size in pixels (mxm)
%    options.nm    shifted portion (shifted pixels = m/nm)
%    options.Dth   Threshold (if Dth==0 then Dth = (nm^2)/2-1)
%    options.show  display detected windows
%
%    Output:
%    Dbin          Binary image for the detection
%    Dmap          Detection map (Dbin = Dmap>options.Dth).
%
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
% [X,d,Xn]      = Xfxrandompatches(Itrain,...% extraction of patches
%                 GTtrain,options);       % and feature extraction
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

function [Dmap,Dbin] = Xsegsliwin(I,options)

opf   = options.opf;
opc   = options.opc;
selec = options.selec;
m     = options.m;
nm    = options.nm;
show  = options.show;
Dth   = options.Dth;

if isfield(options,'roi');
    ROI = options.roi;
else
    ROI = ones(size(I));
end

if isfield(options,'detection');
    dtec = options.detection;
else
    dtec = 1;
end


N = size(I,1);
M = size(I,2);

if show==1
    close all
    figure(1)
    imshow(I(:,:,1),[]);
    title('Original');
    drawnow
end


% Parameters
if Dth==0
    Dth   = nm*nm/2-1;
end
dm   = round(m/nm);            % overlapping
m1   = m-1;
m2   = m*m;
R    = ones(m,m);


% Feature Extraction of Sliding Windows
si1 = 1:dm:N-m;
sj1 = 1:dm:M-m;

wij = I(1:m,1:m,:);
ft  = Xfxint(wij,R,opf);
nft = length(si1)*length(sj1);
mft = length(ft);
fj  = zeros(nft,mft);
k1  = 1;
ff = statusbar('Sliding Windows');
for i1=1:dm:N-m
    ff = statusbar(i1/N,ff);
    if show
        fprintf('processing image row %d/%d...\n',i1,N-m)
    end
    for j1 = 1:dm:M-m
        rj = sum2(ROI(i1:i1+m1,j1:j1+m1))/m2;
        if rj>0.95
            fj(k1,:) = Xfxint(I(i1:i1+m1,j1:j1+m1,:),R,opf);
            k1       = k1+1;
        end
    end
end
delete(ff);

if sum(selec)==0
    X = fj;
else
    X = fj(:,selec);
end

% Classification of all Sliding Windows
dt      = Xclassify(X,opc);

% Detection Map
j = 0;
Dmap = zeros(N,M);
ff = statusbar('Detecting');
for i1=1:dm:N-m
    ff = statusbar(i1/N,ff);
    for j1 = 1:dm:M-m
        rj = sum2(ROI(i1:i1+m1,j1:j1+m1))/m2;
        if rj>0.95
            j = j+1;
            if dt(j)==dtec
                Dmap(i1:i1+m1,j1:j1+m1)=Dmap(i1:i1+m1,j1:j1+m1)+1;
            end
        end
    end
end
delete(ff);

% Binary Detection
Dbin = Dmap>Dth;

% Display Results
tini = 0;
if show
    figure(2)
    imshow(I(:,:,1),[]);
    title('Detected Sliding Windows');
    hold on
    j=0;
    for i1=1:dm:N-m
        for j1 = 1:dm:M-m
            rj = sum2(ROI(i1:i1+m1,j1:j1+m1))/m2;
            if rj>0.95
                j = j+1;
                if dt(j)==dtec
                    x = [j1 j1+m1 j1+m1 j1 j1];
                    y = [i1 i1 i1+m1 i1+m1 i1];
                    plot(x,y,'r')
                end
            end
        end
        if tini==0
            tini=1;
        end
    end
    % enterpause

    figure(3)
    % imshow(Dmap,[]);
    Dmap = log(abs(Dmap)+1);
    imshow(uint8(double(Dmap)/max2(Dmap)*63),jet);
    title('Detection Map');

    figure(4)
    drawnow
    hold on
    E = bwperim(Dbin);
    Xbinview(I(:,:,1),imdilate(E,ones(3,3)))
    title('Binary Detection');
end
