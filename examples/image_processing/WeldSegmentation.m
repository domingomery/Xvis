% WeldSegmentation.m

close all
I  = Xloadimg('W',1,1);                         % input image
figure(1) 
imshow(I);title('Input image');

R  = zeros(size(I));                            % initialization of segmentation

M  = size(I,2);                                 % width of the image
d1 = round(M/4);                                % 4 partitions
d2 = round(d1*1.5);                             % width of each partition
i1 = 1;                                         % first column of partition

while i1<M
    i2 = min([i1+d2 M]);                        % second column of partition
    Ii = I(:,i1:i2);                            % partition i
    Ri = Xsegbimodal(Ii);                       % segemntation of partition i
    R(:,i1:i2) = or(R(:,i1:i2),Ri);             % addition into whole segmentation
    i1 = i1+d1;                                 % update of first column
end
E = bwperim(R,4);                               % edge of segmentation
figure(2);
Xbinview(I,E,'r',5); title('Segmentation');     % boundary of the segmented region
