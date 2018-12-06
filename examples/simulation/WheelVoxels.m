function [V,X,Y,Z] = WheelVoxels(Nv,flaw)

i0 = Nv/2; j0 = Nv/2;
V = false(Nv,Nv,Nv);

% a cylinder: z:k1,..., k2, radius r1
r1 = Nv*0.35; k1=0.40*Nv; k2=0.59*Nv;
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
    r5 = 0.02*Nv;
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
r2 = 0.30*Nv; k1p = 0.48*Nv; k2p = 0.51*Nv;
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



