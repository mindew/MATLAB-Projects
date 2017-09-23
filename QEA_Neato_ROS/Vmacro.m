
%edit your ranges to display here.  important to not include the actual
%location of your object in this grid of points or it will give you
%infinities

[px,py]=meshgrid(-10.5:1:10.5,-10.5:1:10.5);
[xlim,ylim] = size(px);
V = zeros(xlim, ylim);

for i=1:xlim
    for j=1:ylim
%this is the equation and integral with ranges for a specific object:  you
%should be able to figure out what this is and edit appropriately to get
%what you want
dVx = @(x)  -1./sqrt((px(i,j)-x).^2 + py(i,j).^2);
dVy = @(y)  1./sqrt((px(i,j)).^2 + (py(i,j)-y).^2);
V(i,j) = integral(dVx,2,4) + integral(dVy,2,4);
    end
end

hold off
contour(px,py,V)
[Ex,Ey] = gradient(V);
hold on
quiver(px,py,-Ex,-Ey)
