% function Iseq = Xshowseries(group,series,ii,n,NM)
%
% Toolbox Xvis: Display X-ray images of a series
%
%      Iseq  : output image with all thumb
%      group : first letter of group images
%              'C' for Castings,
%              'N' for Natural objects,
%              'W' for Welds,
%              'B' for Baggages,
%              'S' for Settings.
%      series: number of the series
%      ii    : images
%      n     : number of images per row
%      NM    : resize of the images
%
% Example:
%
%    Xshowseries('C',1,1:72,9,[50 70]);

function II = Xgdxrandom(T,n,m,NM)

q = size(T,1);

x = rand(q,1);
[~,jj] = sort(x);

Ts = T(jj(1:n*m),:);

gr = 'CBNWS';

t = 0;
II = [];
for i=1:n
    JJ = [];
    for j=1:m
        t = t+1;
        J = Xloadimg(gr(Ts(t,1)),Ts(t,2),Ts(t,3));
        [N,M,P] = size(J);
        if P==3
            J = rgb2gray(J);
        end
        if N>M
            i1 = round((N-M)/2);
            J = J(i1:i1+M-1,:);
        end
        if M>N
            j1 = round((M-N)/2);
            J = J(:,j1:j1+N-1);
        end
        JJ = [JJ imresize(J,NM)];
    end
    II = [II;JJ];
end