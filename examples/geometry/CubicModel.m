% CubicModel.m
close all

I    = Xloadimg('S',2,1);                   % input image of a plate
Data = Xloaddata('S',2,'points');           % centers of mass of the holes
figure
imshow(I,[]);
hold on
um  = Data.ii(:);                            % u coordinate of measured holes
vm  = Data.jj(:);                            % v coordinate of measured holes
plot(vm,um,'go')
xb  = repmat((-6.5:6.5),[11 1]); xb = xb(:); % x bar coordinate of holes in cm
yb  = repmat((-5:5)'   ,[1 14]); yb = yb(:); % y bar coordinate of holes in cm
n   = length(xb);
XX  = [ones(n,1) xb yb xb.*yb xb.^2 yb.^2 yb.*xb.^2 xb.*yb.^2 xb.^3 yb.^3];
a   = regress(um,XX);                        % linear regression for a
b   = regress(vm,XX);                        % linear regression for b
us  = XX*a;                                  % reprojected coordinate u
vs  = XX*b;                                  % reprojected coordinate v
iis = zeros(size(Data.ii)); iis(:) = us;
jjs = zeros(size(Data.jj)); jjs(:) = vs;
plot(vs,us,'r+')
legend({'Detected points','Reprojected points'})
d   = [um-us vm-vs];
plot(jjs,iis,'r:')
plot(jjs',iis','r:')
axis on
err = mean(sqrt(sum(d.*d,2)))                % mean error in pixels
