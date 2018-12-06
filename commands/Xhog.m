% [X,Xn] = Xhog(I,options)
%
% Toolbox Xvis:
%    Histogram of Orientated Gradients features using Vlfeat Toolbox.
%
%    X is the features vector, Xn is the list of feature names (see Example
%    to see how it works).
%
%    options.cellsize  : size of the cells in pixels
%    options.variant   : 1 for UoCTTI, 2 for Dalal-Triggs
%    options.show      : 1 shows oriented histograms
%
%     Example:
%        options.cellsize = 32;          % 32 x 32 
%        options.variant  = 1;           % UoCTTI
%        options.show  = 1;              % show results
%        I = Xloadimg('N',5,1);          % input image
%        J = I(1100:1849,200:949);       % crop of fruit
%        imshow(J)
%        [X,Xn] = Xhog(J,options);       % HOG features (see gradients
%                                        % arround perimeter).

function [X,Xn,options] = Xhog(I,R,options)

if nargin==2;
    options = R;
    R = ones(size(I));
end

if ~isfield(options,'variant')
    options.varian = 1;
end

if ~isfield(options,'show')
    options.show = 1;
end

if options.variant == 1
    varname = 'UoCTTI';
else
    varname = 'DalalTriggs';
end

options.hog = vl_hog(im2single(I),options.cellsize,'variant',varname);
if options.show==1
    figure
    options.Ir = vl_hog('render',options.hog);
    imshow(Xlinimg(options.Ir),jet);
end
X = options.hog(:)';
n = length(X);
Xn = zeros(n,24);







