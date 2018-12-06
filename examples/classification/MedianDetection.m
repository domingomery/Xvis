function R = DetectionMedian(I,params)
Y0 = Ximgaussian(I,params.gaussianmask);
Y1 = Ximmedian(Y0,params.medianmask);
Y2 = abs(double(Y1)-double(Y0))>params.threshold;
Y3 = bwareaopen(Y2,params.areamin);
R  = imclearborder(imdilate(Y3,ones(params.dilationmask,params.dilationmask)));
