function [Ex, Ey,V, vFunc] = potentialFinder(m, b, xlimmin, xlimmax)

BoB = [2.8194, 1.3970];
xpt = BoB(1);
ypt = BoB(2);
[px,py]=meshgrid(-5:0.5:5,-5:0.5:5);
[xlim,ylim] = size(px);
V = zeros(xlim, ylim);

C=1;
C1=-1;
length(m)
% [xlimmax xlimmin m]

for i=1:xlim
    for j=1:ylim
        V(i,j) = getPotential(xlimmin, xlimmax, m, b, px(i,j), py(i,j), xpt, ypt, C, C1);
    end
end


%hold on

hold on;

vFunc = @(x) getPotential(xlimmin, xlimmax, m, b, x(1), x(2), xpt, ypt, C, C1);
contour(px,py,V)
[Ex,Ey] = gradient(V, 0.5);
% quiver(px,py,-Ex./sqrt(Ex.^2+Ey.^2), -Ey./sqrt(Ex.^2 + Ey.^2));
% plot(BoB(1), BoB(2), 'r*');
end