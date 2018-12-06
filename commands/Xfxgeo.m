% [X,Xn] = Xfxgeo(R,options)
% [X,Xn] = Xfxgeo(L,options)
%
% Toolbox Xvis: Geometric feature extraction.
%
%    This function calls gemetric feature extraction procedures of binary
%    image R or labelled image L.
%
%    X is the feature matrix (one feature per column, one sample per row),
%    Xn is the list with the names of these features (see Example
%    to see how it works).
%
%   Example 1: Extraction of one region image
%      b(1).name = 'hugeo';       b(1).options.show=1;         % Hu moments
%      b(2).name = 'flusser';     b(2).options.show=1;         % Flusser moments
%      b(3).name = 'fourierdes';  b(3).options.show=1;         % Fourier
%                                 b(3).options.Nfourierdes=12; % descriptors
%      options.b = b;
%      I = imread('fruit.png');                                % input image
%      R = Xsegbimodal(I);                                     % segmentation
%      [X,Xn] = Xfxgeo(R,options);                             % geometric features
%      Xprintfeatures(X,Xn)
%
%   Example 2: Extraction of multiple regions image
%      b(1).name = 'hugeo';       b(1).options.show=1;         % Hu moments
%      b(2).name = 'basicgeo';    b(2).options.show=1;         % basic geometric fetaures
%      b(3).name = 'fourierdes';  b(3).options.show=1;         % Fourier
%                                 b(3).options.Nfourierdes=12; % descriptors
%      options.b = b;
%      I = Xloadimg('N',5,1);                                 % input image
%      R = I>50;
%      [L,m] = bwlabel(R);
%      [X,Xn] = Xfxgeo(L,options);                            % geometric features
%      i = input('Region?');
%      imshow(L==i);
%      Xprintfeatures(X(i,:),Xn)

function [X,Xn] = Xfxgeo(R,options)


if isempty(R)
    disp('Xfxgeo: R is empty (there is no segmentation). Geometric features without segmentation has no sense.');
    X = [];
    Xn = [];
    return;
else
    b = options.b;
    n = length(b);
    m = int16(max(R(:)));
    X = [];
    for j=1:m
        Rj = R==j;
        Xj = [];
        Xnj = [];
        for i=1:n
            s = b(i).name;
            if s(1)~='X'
                s = ['X' s];
            end
            if  ~exist(s,'file')
                error('Xfxgeo: function %s does not exist.',b(i).name)
            end

            [Xi,Xni] = feval(s,Rj,b(i).options);
            Xj = [Xj Xi];
            Xnj = [Xnj; Xni];
        end
        X = [X;Xj];
    end
    Xn = Xnj;
end
