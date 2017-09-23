function [a,b] = ransac(theta, r)
% clean the data first
theta_clean = theta(r~=0);
r_clean = r(r~=0);

% convert polar to cartesian
x = r_clean.*cosd(theta_clean);
y = r_clean.*sind(theta_clean);
data = [x'; y'];

% variables
% num = 2;
iter = 100;
threshDist = 3;
inlierRatio = .1;
% number of points that are used for line fitting. By default, it is 2
% number of iterations
% threshold Distance
% inlierRatio: the threshold of the number of inliers

% Plot the data points
figure;plot(x,y,'ko');hold on;
number = size(data,2); % Total number of points
bestInNum = 0; % Best fitting line with largest number of inliers
a=0;b=0; % parameters for best fitting line

for i=1:iter
    % Randomly generate 2 index and select two points based on index
    idx = randi([1 length(x)],1,2); sample = data(:,idx);
    
    % Compute the distances between all points with the fitting line
    kLine = sample(:,2)-sample(:,1);% two points relative distance
    kLineNorm = kLine/norm(kLine);
    normVector = [-kLineNorm(2),kLineNorm(1)];%Ax+By+C=0 A=-kLineNorm(2),B=kLineNorm(1)

    distance = normVector*(data - repmat(sample(:,1),1,number));
    % or.. d = abs(det([Q2-Q1;x(k)-Q1]))/norm(Q2-Q1)
    % Q1 and Q2 are two selected endpoints
    
    
    % Compute the inliers with distances smaller than the threshold
    inlierIdx = find(abs(distance)<=threshDist);
    inlierNum = length(inlierIdx);
    
    % Update the number of inliers and fitting model if better model is found
    if inlierNum>=round(inlierRatio*number) && inlierNum>bestInNum
        bestInNum = inlierNum;
%         parameter1 = (sample(2,2)-sample(2,1))/(sample(1,2)-sample(1,1));
%         parameter2 = sample(2,1)-parameter1*sample(1,1);
%         a=parameter1; b=parameter2;
          P = polyfit(sample(1,:),sample(2,:),1);
          a = P(1);
          b = P(2);
    end
    
end

% Plot the best fitting line
yhat = a*x + b;
plot(x,yhat,'-','LineWidth',1);
end