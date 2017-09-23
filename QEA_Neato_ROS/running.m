theta_clean = theta(r~=0);
r_clean = r(r~=0);
% i=find(r);
% r_clean=r(i);
% theta_clean=theta(i);

% convert polar to cartesian
x = r_clean.*cosd(theta_clean);
y = r_clean.*sind(theta_clean);

