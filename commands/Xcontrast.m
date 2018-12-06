% [X,Xn] = Xcontrast(I,R,options)
% [X,Xn] = Xcontrast(I,options)
%
% Toolbox XVis: Contrast features.
%
%    X is the features vector, Xn is the list of feature names(see Example
%    to see how it works).
%
%    References:
%    Mery, D.; Filbert: Classification of  Potential Defects in
%    Automated Inspection of Aluminium Castings Using  Statistical Pattern
%    Recognition. In Proceedings of 8th European Conference on Non-
%    Destructive Testing (ECNDT 2002), Jun. 17-21, 2002, Barcelona, Spain.
%
%    Kamm, K.-F. Ewen, K. (ed.): Grundlagen der Roentgenabbildung Moderne
%    Bildgebung: Physik, Ger?tetechnik, Bildbearbeitung und -kommunikation,
%    Strahlenschutz, Qualitaetskontrolle, Georg Thieme Verlag, 1998, 45-62
%
%   Example:
%      options.show    = 1;                    % display results
%      options.neighbor = 2;                   % neigborhood is imdilate
%      options.param    = 5;                   % with 5x5 mask
%      I = imread('cast_defect.png');
%      figure(1);imshow(I);title('test image');
%      [F,m] = Xseglogfeat(I,I<230,[200 2000],[0 150],[1.10 2],3.4);
%      figure(2);imshow(F,[]);title('segmented image');
%      X = zeros(m,5);
%      for i=1:m
%          Ri = F==i;
%          X(i,:) = Bfx_contrast(I,Ri,options);     % contrast features
%      end
%      X

function [X,Xn] = Xcontrast(I,R,options)

I = double(I);

if nargin==2;
    options = R;
    R = ones(size(I));
end

if ~isfield(options,'show')
    options.show = 0;
end

if options.show == 1
    disp('--- extracting contrast features...');
end


s = options.param;

switch options.neighbor
    case 1
        [N,M] = size(R);
        [ii,jj] = find(R==1);
        i_m = mean(ii);
        j_m = mean(jj);
        id = (double(max(ii)-min(ii)+1)*s/2);
        jd = (double(max(jj)-min(jj)+1)*s/2);
        i1 = max([1 round(i_m-id)]);
        i2 = min([N round(i_m+id)]);
        j1 = max([1 round(j_m-jd)]);
        j2 = min([M round(j_m+jd)]);
        Rn = zeros(size(R));
        Rn(i1:i2,j1:j2)=1;
    case 2
        Rn = imdilate(R,ones(s,s));
        [ii,jj] = find(Rn==1);
        i1 = min(ii);
        i2 = max(ii);
        j1 = min(jj);
        j2 = max(jj);
end

Rn = and(Rn,not(R));

if sum(Rn(:)) > 0
    MeanGr = mean(I(R==1));
    MeanGn = mean(I(Rn==1));        
    K1 = (MeanGr-MeanGn)/MeanGn;            % contrast after Kamm, 1999
    K2 = (MeanGr-MeanGn)/(MeanGr+MeanGn);   % modulation after Kamm, 1999
    K3 = log(MeanGr/MeanGn);                % film-contrast after Kamm, 1999
else
    K1 = -1;
    K2 = -1;
    K3 = -1;
end
[Ks,K] = contrast2002(I(i1:i2,j1:j2));  % contrast after Mery Barcelona 2002 XRA0152

X = [K1 K2 K3 Ks K];

Xn = [ 'contrast-K1             '
    'contrast-K2             '
    'contrast-K3             '
    'contrast-Ks             '
    'contrast-K              '];
end



% [Ks,K] = contrast2002(I)
%
%    Contrast features after Mery & Filbert, 2002.
%
function [Ks,K] = contrast2002(I)

[nI,mI] = size(I);

n1 = fix(nI/2)+1;
m1 = fix(mI/2)+1;

P1    = I(n1,:);                   % Profile in i-Direction
P2    = I(:,m1)';                  % Profile in j-Direction

Q1    =  rampefr(P1);              % Profile P1 without ramp
Q2    =  rampefr(P2);              % Profile P2 without ramp

Q     = [Q1 Q2];                   % Fusion of profiles

Ks    = std(Q);                    % Contrast Ks
K     = log(max(Q)-min(Q)+1);      % Contrast K

end

% Q = rampefr(P)
%
%    Eliminate ramp of profile P (used to compute contrast features).
%
function Q = rampefr(P)
k = length(P);
m = (P(k)-P(1))/(k-1);
b = P(1)-m;
Q = P - (1:k)*m - b*ones(1,k);
end