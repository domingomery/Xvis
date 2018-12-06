% [V,X,Y,Z] = Xobjvoxels(obj,Nv,flaw)
%
% Toolbox Xvis: Voxels of an object
%
%    obj   : 1 for a wheel, 2 for an L object
%    V     : 3D binary matrix containing the voxels '1' means object
%            of Nv^3 voxels
%    X,Y,Z : coordinates of Voxels = '1'
%    flaw  : '1' includes a spherical flaw
%
%   Example:
%      V  = Xobjvoxels(1,256,1);           % V has Nv^3 voxels with a wheel
%      for k=1:256;
%         imshow(V(:,:,k));
%         title(num2str(k));
%         drawnow;
%      end


function [V,X,Y,Z] = Xobjvoxels(obj,Nv,flaw)

i0 = round(Nv/2); j0 = round(Nv/2);


switch obj
    case 1
        V = false(Nv,Nv,Nv);
        
        % a cylinder: z:k1,..., k2, radius r1
        r1 = round(Nv*0.35); k1=round(0.40*Nv); k2=round(0.59*Nv);
        for i=1:Nv
            for j=1:Nv
                r = sqrt((double(i)-i0)^2+(double(j)-j0)^2);
                if r<r1
                    V(i,j,k1:k2) = true;
                end
            end
        end
        
        if flaw==1
            % a spherical flaw
            r5 = round(0.02*Nv);
            for i=1:Nv
                for j=1:Nv
                    for k=k1:k2
                        r = sqrt((double(i)-(i0+0.33*Nv))^2+(double(j)-j0)^2+(double(k)-0.50*Nv)^2);
                        if r<r5
                            V(i,j,k) = false;
                        end
                    end
                end
            end
            
        end
        
        [X,Y,Z] = ind2sub(size(V),find(V==1));
        r2 = round(0.30*Nv); k1p = round(0.48*Nv); k2p = round(0.51*Nv);
        for i=1:length(X)
            if or(Z(i)>k2p,Z(i)<k1p)
                r = sqrt((X(i)-i0)^2+(Y(i)-j0)^2);
                if r<r2
                    V(X(i),Y(i),Z(i)) = false;
                end
            end
        end
        
        [X,Y,Z] = ind2sub(size(V),find(V==1));
        
        for i=1:length(X)
            cp = X(i)-i0 +sqrt(-1)*(Y(i)-j0);
            r = abs(cp);
            a = (angle(cp)+pi)/2/pi;
            an = round(a*16);
            if round(an/2)*2==an
                if and(r<r2,r>10)
                    V(X(i),Y(i),Z(i)) = false;
                end
            end
        end
    case 2 % L
        V = true(Nv,Nv,Nv);
        ii = 1:round(Nv/3);
        for k=1:round(Nv/2)
            V(ii,:,k) = false;
        end
        if flaw==1
            % a spherical flaw
            r5 = round(0.2*Nv);
            k1 = round(Nv/4);
            k2 = k1 + round(Nv/2);
            i0 = round(3*Nv/4);
            j0 = round(Nv/2);
            k0 = round(Nv/2);
            for i=1:Nv
                for j=1:Nv
                    for k=k1:k2
                        r = sqrt((double(i)-(i0))^2+(double(j)-j0)^2+(double(k)-k0)^2);
                        if r<r5
                            V(i,j,k) = false;
                        end
                    end
                end
            end
            
        end

    otherwise
        error('parameter obj = %d is not defined.\n',obj)
end


