load penscans.mat
r = r_all(:,1);
theta = theta_all(:,1);
theta_clean = theta(r~=0);
r_clean = r(r~=0);
X = r_clean .* cosd(theta_clean);
Y = r_clean .* sind(theta_clean);

%edit your ranges to display here.  important to not include the actual
%location of your object in this grid of points or it will give you
%infinities

[xlim,ylim] = size(X);
V = zeros(xlim, ylim);

for i=1:xlim
    for j=1:ylim
%this is the equation and integral with ranges for a specific object:  you
%should be able to figure out what this is and edit appropriately to get
%what you want
dVx = @(x)  -1./sqrt((X(i,j)-x).^2 + Y(i,j).^2);
dVy = @(y)  -1./sqrt((X(i,j)).^2 + (Y(i,j)-y).^2);
V(i,j) = integral(dVx,2,4) + integral(dVy,2,4);
    end
end

hold off
contour(X,Y,V)
[Ex,Ey] = gradient(V);
hold on
quiver(X,Y,-Ex,-Ey)
