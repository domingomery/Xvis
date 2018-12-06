function [X,d,Xn] = Xfxseqpatches(dir_name,fmt,GT,options,yn)

d = dir([dir_name '/*.' fmt]);
n = length(d);

gtflag = false;
if ~isempty(GT)
    GTdata = load([dir_name '/' GT]);
    GTdata = round(GTdata);
    gtflag = true;
end

if ~isfield(options,'show');
    options.show = 0;
end


if yn==0
    X0 = []; d0 = [];
    ff = statusbar('extracting patches 0');
    for i=1:n
        ff = statusbar(i/n,ff);
        st = [dir_name '/' d(i).name];
        I = imread(st);
        R = ones(size(I));
        if gtflag
            ii = find(GTdata(:,1)==i);
            ni = length(ii);
            for j=1:ni
                R(GTdata(ii(j),4):GTdata(ii(j),5),GTdata(ii(j),2):GTdata(ii(j),3)) = 0;
            end
            if isfield(options,'segmentation');
                op0.roi = and(R,feval(options.segmentation,I));
            else
                op0.roi = R;
            end
            op0.opf.b = options.opf.b;
            op0.m     = options.m;
            op0.n1    = options.n0;
            op0.th1   = options.th0;
            op0.show  = options.show;
            [Xi,di,Xn] = Xfxrandompatches(I,R,op0);
            X0 = [X0;Xi];
            d0 = [d0;zeros(options.n0,1)];
        end
    end
    
    X = X0;
    d = d0;
else
    X1 = []; d1 = [];
    ff = statusbar('extracting patches 1');
    for i=1:n
        ff = statusbar(i/n,ff);
        st = [dir_name '/' d(i).name];
        I = imread(st);
        R = ones(size(I));
        if gtflag
            ii = find(GTdata(:,1)==i);
            ni = length(ii);
            for j=1:ni
                Ij = imresize(I(GTdata(ii(j),4):GTdata(ii(j),5),GTdata(ii(j),2):GTdata(ii(j),3)),options.resize);
                [Xj,Xn] = Xfxint(Ij,[],options.opf);
                X1 = [X1;Xj];
                d1 = [d1;1];
            end
        end
    end
    X = X1;
    d = d1;
    
end
delete(ff)

