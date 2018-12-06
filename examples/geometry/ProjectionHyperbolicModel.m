% ProjectionHyperbolicModel.m
M = [60 60 -40 1]';                        % 3D point in mm

h  = Xloaddata('C',1,'HyperbolicModel.txt');
P  = Xloaddata('C',1,'ManipulatorPosition.txt');

for p=38:2:46                              % for position p:
    t  = [P(p,1) P(p,2) P(p,3)]';          % translation vector
    Rp = Xmatrixr3(P(p,4),P(p,5),P(p,6));  % rotation matrix
    Hp = [Rp t;0 0 0 1];                   % 3D Euclidean transformation
    w  = Xhyperproj(M,h,Hp);               % projection using hyperbolic model
    Xloadimg('C',1,p,1);                   % display image p
    hold on
    plot(w(2),w(1),'rx');                  % 2D projection of 3D point M
    pause
end
