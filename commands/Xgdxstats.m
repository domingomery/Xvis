% function [T,C] = Xgdxstats()
%
% Toolbox Xvis: Count number of X-ray images on GDXray database 
%
%      T     : table one row per group: group # of series, #of images/group 
%      S     : table one row per image: group series image #rows and #columns 
%
% Example: Bounding boxes
%
%    [X,T,S] = Xgdxstats;
gdx_groups = 'CWBNS';

n = length(gdx_groups);

S = zeros(15000,5);

T = zeros(1000,3);
X = zeros(n,4);
t = 0;
q = 0;
for i=1:n
   group = gdx_groups(i); 
   ok = 0;
   k = 0;
   sum_series = 0;
   sum_images = 0;
   sum_bytes  = 0;
   while not(ok)
        k = k + 1;
        st = Xgdxdir(group,k)
        if exist(st,'dir')
            t = t+1;
            d1 = dir([st '*.png']); n1 = length(d1);
            T(t,:) = [i k n1];
            sum_series = sum_series + 1;
            sum_images = sum_images + n1 ;
            sum_bytes  = sum_bytes + sum(cat(1,d1.bytes));
            if n1>0
                for j=1:n1
                    I = imread([st d1(j).name]);
                    [N,M,P] = size(I);
                    q = q+1;
                    S(q,:) = [i k j N M];
                end
            end
        else
            ok = 1;
        end
   end
   X(i,:) = [i sum_series sum_images sum_bytes/1e6];
end
T = T(1:t,:);
S = S(1:q,:);
Y = [X; sum(X)];
col_names = {'Groups   ','Series','X-ray images','Memory (MB)'};
row_names = {'Castings','Welds   ','Baggages','Nature  ','Settings','Total   '};
fmt = {'%6d','%6d','%6.1f'};
Bio_latextable(row_names,col_names,fmt,Y(:,2:end))
