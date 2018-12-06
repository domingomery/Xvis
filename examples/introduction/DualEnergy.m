% DualEnergy.m
close all
X1  = Xloadimg('B',60,1,0);               % low energy image
X2  = Xloadimg('B',60,2,0);               % high energy image
x   = Xloaddata('B',60,'DualEnergyLUT');  % LUT
map = parula;                             % color map
Y   = Xdualenergy(X2,X1,x.LUT,map,1);     % conversion

