function [ lineSegments ] = multipleLines(Xs,Ys, n,d )
%Call robustLineFit for multiple line segments

% %Suppress if u want
% %Clean up the data, remove points where r=0
% i=find(r);
% r=r(i);
% theta=theta(i);
% 
% %Convert to cartesian coordinates
% Xs=r.*cosd(theta);
% Ys=r.*sind(theta);

%Store line segments 
lineSegments=[];

newData=[Xs,Ys];
while 1
    %Call robustLineFit
    [linePts,~,outlierSet]=robustLineFit(newData(:,1),newData(:,2),n,d);
    
    %Store found line segment
    lineSegments(end+1,:)=[linePts(1,1),linePts(1,2),linePts(2,1),linePts(2,2)];
    
    %Store new set of data to find line segments in
    newData=outlierSet';
    
    %If not enough outliers, break 
    if length(outlierSet)<=2
        break;
    end
end

end

