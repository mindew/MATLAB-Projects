function [ Xs,Ys ] = cleanCartesian( r,theta )
%Clean up the data and convert to cartesian coordinates

    %Clean up data
    i=find(r);
    r=r(i);
    theta=theta(i);

    %Convert to cartesian coordinates
    Xs=r.*cosd(theta);
    Ys=r.*sind(theta);

end

