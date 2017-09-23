function [new_theta, new_r] = ransac3(theta, r)
% clean the data first
theta_clean = theta(r~=0);
r_clean = r(r~=0);

% convert polar to cartesian
x = r_clean.*cosd(theta_clean);
y = r_clean.*sind(theta_clean);
data = [x'; y'];

% variables
% num = 2;
iter = 1000;
threshDist = .1;
inlierRatio = .1;
bestLine = [0,0;0,0];
% number of points that are used for line fitting. By default, it is 2
% number of iterations
% threshold Distance
% inlierRatio: the threshold of the number of inliers

% Plot the data points
% plot(x,y,'ko');hold on;
number = size(data,2); % Total number of points
bestInNum = 0; % Best fitting line with largest number of inliers
a=0;b=0; % parameters for best fitting line

for i=1:iter
    % Randomly generate 2 index and select two points based on index
    idx = randi([1 length(x)],1,2); sample = data(:,idx);
    if idx(1) == idx(2)
        continue
    end
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

    parallelDistance = kLineNorm'*(data - repmat(sample(:,1),1,number));
    parallelDistanceInliers = parallelDistance(inlierIdx);
    %[e1 ind1]=min(parallelDistanceInliers);
    %[e2 ind2]=max(parallelDistanceInliers);
    
 
    sortedDist = sort(parallelDistanceInliers);
    endPoint1 = sortedDist(1)*kLineNorm + sample(:,1);
    endPoint2 = sortedDist(end)*kLineNorm + sample(:,1);
    
    
    
    endPoints=[endPoint1'];
    endPoints(2,:)=0;
   
    for i=2:length(sortedDist)
        if sortedDist(i) - sortedDist(i-1) > 0.1
            endPoints(1,:) =  (sortedDist(i)*kLineNorm + sample(:,1))';
        else
            endPoints(2,:) = (sortedDist(i)*kLineNorm + sample(:,1))';
            if norm(endPoints(1,:)-endPoints(2,:)) > norm(bestLine(1,:)-bestLine(2,:))
                bestLine = endPoints;
            end
        end
    end
    
      
    
end

% Plot the best fitting line

plot(bestLine(:,1),bestLine(:,2),'-','LineWidth',1.5);

for i = length(inlierIdx):-1:1
    index = inlierIdx(i);
    data(:,index) = [];
end

[new_r,new_theta] = cart2pol(data(1,:),data(2,:));
% new_theta = ((new_theta./(2*pi)) .* 360);%convert to degrees orientation
new_theta = new_theta';
new_r = new_r';
end