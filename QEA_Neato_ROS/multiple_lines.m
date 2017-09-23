function [Ex, Ey, V, vFunc] = multiple_lines(theta_all, r_all)
% Multiple Lines
% load playpensample.mat
% clean the data first
theta = theta_all(:,1);
r = r_all(:,1);

% set the variables
Xn = 0;
Yn = 0;
phi = 0;
iteration = 10;

[Fixed] = convert_2_fixed_frames(r, theta, Xn, Yn, phi);
x = Fixed(1,:)';
y = Fixed(2,:)';

% % convert polar to cartesian
% x = r_clean.*cosd(theta_clean);
% y = r_clean.*sind(theta_clean);

% plotting data points
% scatter(x,y,'k')
hold on
grid on
stored_m = zeros(1,iteration);
stored_b = zeros(1,iteration);
stored_xlimmin = zeros(1,iteration);
stored_xlimmax = zeros(1,iteration);


for i = 1:iteration

    [x, y, BestLine] = ransac2(x,y);
    xmin = BestLine(1,1);
    xmax = BestLine(2,1);
    ymin = BestLine(1,2);
    ymax = BestLine(2,2);
    [m, b, xlimmin, xlimmax] = lineFinder (xmin, xmax, ymin, ymax);
    stored_m(i) = m;
    stored_b(i) = b;
    stored_xlimmin(i) = xlimmin;
    stored_xlimmax(i) = xlimmax;
end
[Ex, Ey, V, vFunc] = potentialFinder(stored_m, stored_b, stored_xlimmin, stored_xlimmax);
axis([-2,5,-5,5])
grid on
end