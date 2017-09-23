% Multiple Lines
clear
clf
% load playpensample.mat
load penscans.mat
% clean the data first
theta = theta_all(:,4);
r = r_all(:,4);
theta_clean = theta(r~=0);
r_clean = r(r~=0);

% variables
Xn = 1;
Yn = 1;
phi = -45;

% % convert polar to cartesian
% x = r_clean.*cosd(theta_clean);
% y = r_clean.*sind(theta_clean);

[Fixed] = convert_2_fixed_frames(r, theta, Xn, Yn, phi);
x = Fixed(1,:)';
y = Fixed(2,:)';
hold on

% plotting data points
% plot(x,y,'ks')
% hold on
% grid on

[x, y, BestLine] = ransac2(x,y);

xmin = BestLine(1,1);
xmax = BestLine(2,1);
ymin = BestLine(1,2);
ymax = BestLine(2,2);
[m, b, xlimmin, xlimmax] = lineFinder (xmin, xmax, ymin, ymax);
potentialFinder(m, b, xlimmin, xlimmax);