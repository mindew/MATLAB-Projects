function fitCircleLinear()
clf;
[x, y, r, theta] = makeCircle(2,0,60);
scatter(x,y);
xlim([-2,2]);
ylim([-2,2]));
% make fake circle


% b = A*w
A = [x y ones(size(x))];
% added column of ones because we hae CDE
b =  -x.^2 - y.^2;
w = A\b;
xc = -w(1)/2;
yc = -w(2)/2;
r = sqrt(xc.^2+yc.^2-w(3)));
viscircles([xc yc],r)
end
