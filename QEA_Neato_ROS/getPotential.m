function V = getPotential(xlimmin, xlimmax, m, b, px, py, xpt, ypt, C, C1)
V = 0;
for k = 1:length(m)
    dV= @(x) (C*sqrt(m(k)^2+1))./sqrt((px-x).^2 + (py-(m(k)*x+b(k))).^2);
    V = V + integral(dV, xlimmin(k), xlimmax(k));
end
V = V + C1./sqrt((px - xpt).^2 + (py - ypt).^2);
end