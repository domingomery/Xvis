% function [X,Xn] = Xfourierdes(R,options)
%
% Toolbox Xvis: Computes the Fourier descriptors of a binary image R.
%
%    options.show = 1 display mesagges.
%    options.Nfourierdes number of descriptors.
%
%    X is the feature vector
%    Xn is the list of feature names.
%
%    Reference:
%    Zahn, C; Roskies, R.: Fourier Descriptors for Plane
%    Closed Curves, IEEE Trans on Computers, C21(3):269-281, 1972
%
%   Example:
%      I = imread('fruit.png'); % input image
%      R = Xsegbimodal(I);      % segmentation
%      imshow(R);
%      options.show = 1;
%      [X,Xn] = Xfourierdes(R); % Fourier descriptors
%      Xprintfeatures(X,Xn)

function [X,Xn] = Xfourierdes(R,options)

if ~exist('options','var')
    options.show = 0;
    options.Nfourierdes = 16;
end

if options.show == 1
    disp('--- extracting Fourier descriptors...');
end

N    = options.Nfourierdes;

jj   = sqrt(-1);

B    = bwboundaries(R,'noholes');
g    = B{1};
V    = g(:,2)+jj*g(:,1);
m    = size(g,1);

r    = zeros(m,1);
phi  = zeros(m,1);
dphi = zeros(m,1);
l    = zeros(m,1);
dl   = zeros(m,1);

r(1) = V(1)-V(m);
for i=2:m
    r(i)   = V(i)-V(i-1);
end
for i=1:m
    dl(i)  = abs(r(i));
    phi(i) = angle(r(i));
end
for i=1:m-1
    dphi(i) = mod(phi(i+1)-phi(i)+pi,2*pi)-pi;
end
dphi(m) = mod(phi(1)-phi(m)+pi,2*pi)-pi;

for k=1:m
    l(k) = 0;
    for i=1:k
        l(k) = l(k) + dl(i);
    end
end

L = l(m);

A  = zeros(N,1);
for n=1:N
    an = 0;
    bn = 0;
    for k = 1:m
        an = an + dphi(k)*sin(2*pi*n*l(k)/L);
        bn = bn + dphi(k)*cos(2*pi*n*l(k)/L);
    end
    an = -an/n/pi;
    bn =  bn/n/pi;
    imagi = an + jj*bn;
    A(n) = abs(imagi);
end

X  = A';
Xn = char(zeros(N,24));
for i = 1:N
    Xn(i,:)  = sprintf('Fourier-des %2d          ',i);
end

