%function Xshowconfusion(T,normalize)
%
% Toolbox Xvis
%    Show confusion matrix T in a color 2D representation.
%    If normalize==1 each row of T is normalized so that sum(T(i,:))=1
%
% Example:
%
% % Simulation of a 10x10 confussion matrix
% T = rand(10,10)+2*eye(10);T = T/max(T(:));
% Xshowconfusion(T)


function Xshowconfusion(C,normalize)

[N,M] = size(C);

if N~=M
    error('Matrix should be square.')
end

if exist('normalize','var')
    if normalize==1
        for i=1:N
            C(i,:)=C(i,:)/sum(C(i,:));
        end
    end
end



minC = min(C(:));
maxC = max(C(:));


if minC<0
    error('There are negative values.');
end

if maxC>100
    error('Maximal value of C should be 100.')
end



if maxC<=1
    C = 100*C;
end

jet100 = imresize(jet,[100 3],'nearest');


clf;
T = 256;
imshow(imresize(round(C),[T T],'nearest'),jet100)
axis off
hold on

sq = 256/N;

for i=1:N
    y = T*i/N-sq/2;
    for j=1:N
        x = T*j/N-0.75*sq;
        text(x,y,num2str(round(C(i,j))))
    end
end
colorbar
        