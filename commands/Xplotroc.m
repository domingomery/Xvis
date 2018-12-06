% [AUC,TPRs,FPRs,TPR05] = Xplotroc(x,y,col_line,col_point)
%
% Toolbox Xvis: Plot ROC curve and fit to an exponetial curve
%
% Example:
%
% th = 3;x = 0:0.05:1; y = 1-exp(-3*x)+randn(1,21)*0.05;
% Xplotroc(x,y)

function [AUC,TPRs,FPRs,TPR05] = Xplotroc(x,y,col_line,col_point)

if ~exist('col_line','var')
    col_line = 'b';
end

if ~exist('col_point','var')
    col_point = 'r.';
end

% clf
plot(x,y,col_point)
dx = 0.005;
ths = fminsearch(@thest,[1 exp(1) 0.5],[],x,y);
xs = 0:dx:1;
ys = fyest(xs,ths);
AUC = sum(ys)*dx;

hold on
plot(xs,ys,col_line)

d = xs.*xs + (1-ys).*(1-ys);

[~,ii] = min(d);

TPRs = ys(ii(1));
FPRs = xs(ii(1));

ii = find(xs==0.05);
TPR05 = ys(ii(1));

plot(FPRs,TPRs,[col_point(1) '*'])
plot(FPRs,TPRs,[col_point(1) 'o'])

xlabel('FPR')
ylabel('TPR')
text(0.6,0.1,sprintf('AUC = %6.4f',AUC),'fontsize',14);
grid on
end



function err = thest(th,x,y)
ys  = fyest(x,th);
err = norm(y-ys);
end

function ys = fyest(x,th)
g = th(1);
a = th(2);
b = th(3);
ys=(1-a.^(g*x.^b))/(1-a^(g));
end




