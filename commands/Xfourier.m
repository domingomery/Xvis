% [X,Xn,Xu] = Xfourier(I,R,options)
% [X,Xn,Xu] = Xfourier(I,options)
%
% Toolbox Xvis: Fourier features
%
%    X is the features vector, Xn is the list of feature names (see Example 
%    to see how it works).
%
%   Example:
%      options.Nfourier  = 64;                % imresize vertical
%      options.Mfourier  = 64;                % imresize horizontal
%      options.mfourier  = 2;                 % imresize frequency vertical
%      options.nfourier  = 2;                 % imresize frequency horizontal
%      options.show    = 1;                   % display results
%      I = double(imread('fruit.png'));       % input image
%      R = Xsegbimodal(I);                    % segmentation
%      J = double(I)/256;                     % normalized intensity
%      [X,Xn] = Xfourier(J,R,options);        % Fourier features
%      Xprintfeatures(X,Xn)

function [X,Xn] = Xfourier(I,R,options)

if nargin==2;
    options = R;
    R = ones(size(I));
end

I(R==0) = 0;

N  = options.Nfourier;
M  = options.Mfourier;
n  = options.nfourier;
m  = options.mfourier;

N2 = round(N/2);
M2 = round(M/2);

if options.show
    disp('--- extracting Fourier features...');
end


Im  = imresize(double(I),[N M]);
FIm = fft2(Im);
x   = abs(FIm);
F   = imresize(x(1:N2,1:M2),[n m]); 
x   = angle(FIm);
A   = imresize(x(1:N2,1:M2),[n m]); 

LS = 2*n*m;
X  = zeros(1,LS);
Xn = char(zeros(LS,24));
k = 0;
for i=1:n
    for j=1:m
        k = k + 1;
        s = sprintf('Fourier Abs (%d,%d)              ',i,j);
        Xn(k,:)  = s(1:24);
        X(k) = F(i,j);
    end
end
for i=1:n
    for j=1:m
        k = k + 1;
        s = sprintf('Fourier Ang (%d,%d)[rad]         ',i,j);
        Xn(k,:)  = s(1:24);
        X(k) = A(i,j);
    end
end
