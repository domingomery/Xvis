% Q = Xsimvoxels(N,M,V,s,P)
%
% Toolbox Xvis: Simulation of an X-ray image using voxels (or STL files)
%               (SFT files will converted to voxels (*))
%
%    NxM   : size of output image
%    V     : 3D binary matrix containing the voxels '1' means object
%            or name of STL file(*)
%    s     : scale in voxels/mm
%    P     : 3x4 projection matrix
%    Q     : output image
%    T     : number of voxels in each direction for stl files
%
%   (*) It requires Mesh Voxelisation by Adam A
%       http://www.mathworks.com/matlabcentral/fileexchange/27390-mesh-voxelisation
%
%   Example 1:
%      V  = Xobjvoxels(1,600,0);                                  % V has Nv^3 voxels with a wheel
%      K  = [1.1 0 235; 0 1.1 305; 0 0 1];                        % Transformation (x,y)->(u,v)
%      P  = [1000 0 0 0; 0 1000 0 0; 0 0 1 0];                    % Transformation (Xb,Yb,Zb)->(x,y)
%      H  = [Xmatrixr3(0.5,0.1,0.6) [-120 -120 1000]'; 0 0 0 1];  % Transformation (X,Y,Z)->(Xb,Yb,Zb)
%      Q  = Xsimvoxels(512,512,V,4,K*P*H);                        % Simulation
%      imshow(exp(-0.0001*Q),[])
%
%   Example 2:
%      V  = 'sample.stl';                                         % STL file of Mesh Voxelisation(*)
%      K  = [1.1 0 235; 0 1.1 305; 0 0 1];                        % Transformation (x,y)->(u,v)
%      P  = [1000 0 0 0; 0 1000 0 0; 0 0 1 0];                    % Transformation (Xb,Yb,Zb)->(x,y)
%      H  = [Xmatrixr3(0.5,0.1,0.6) [-120 -120 1000]'; 0 0 0 1];  % Transformation (X,Y,Z)->(Xb,Yb,Zb)
%      Q  = Xsimvoxels(512,512,'sample.stl',4,K*P*H,400);         % Simulation
%      imshow(exp(-0.0001*Q),[])


function Q = Xsimvoxels(N,M,V,s,P,T)

if ischar(V)
    V = VOXELISE(T,T,T,V,'xyz');
end

[X,Y,Z] = ind2sub(size(V),find(V==1));

X = X/s; Y = Y/s; Z = Z/s;

n = length(X);

MM = [X'; Y' ; Z'; ones(1,n)];

w = Xh2nh(P*MM);

Q = zeros(N,M);

for i=1:n
    i1 = floor(w(1,i)); j1 = floor(w(2,i));
    if i1>0 && j1>0 && i1<N && j1<M
        i2 = i1+1;          j2 = j1+1;
        a1 = w(1,i)-i1;     b1 = w(2,i)-j1;
        a2 = 1-a1;          b2 = 1-b1;
        Q(i1,j1) = Q(i1,j1) + a2*b2;
        Q(i1,j2) = Q(i1,j2) + a2*b1;
        Q(i2,j1) = Q(i2,j1) + a1*b2;
        Q(i2,j2) = Q(i2,j2) + a1*a1;
    end
end



