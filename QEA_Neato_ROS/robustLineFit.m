function [ linePts, inlierSet, outlierSet ] = robustLineFit( Xs,Ys,n,d )
%d is threshhold, n is number of lines to try

% %Suppress if u want
% %Clean up the data, remove points where r=0
% i=find(r);
% r=r(i);
% theta=theta(i);
% 
% %Convert to cartesian coordinates
% Xs=r.*cosd(theta);
% Ys=r.*sind(theta);

%Outputs this function used to give:
%line,linePts,data,inlieSet,outlierSet
%data=[Xs,Ys];

%Number of inliers for the best line; set to 0 initially
bestInliers=0;

inlierSet=[];
outlierSet=[];

for num=1:n
    %Select two random points
    i=randi(length(Xs),[2,1]);
    
    pt1=[Xs(i(1)); Ys(i(1)); 0];
    pt2=[Xs(i(2)); Ys(i(2)); 0];
    
    %Equation of the current line
    m=(pt2(2)-pt1(2))/(pt2(1)-pt1(1)); %Slope
    b=pt1(2)-m*pt1(1); %Intercept
    y=@(x) m.*x+b; %The equation in slope-intercept form
    
    %Endpoints of the line
    xEndpts=[min(Xs); max(Xs)];
    yEndpts=y(xEndpts);
    e1=[xEndpts(1); yEndpts(1); 0];
    e2=[xEndpts(2); yEndpts(2); 0];
    
    inliers=0; %Total number of inliers for this line; initially 0
    %Find distance from each point to the line
    inPoints=[]; %The set of inliers
    outPoints=[]; %The set of outliers
    for k=1:length(Xs)
        Pt=[Xs(k);Ys(k);0];
        a=e1-e2;
        c=Pt-e2;
        distance=norm(cross(a,c))/norm(a);
        
        %Count the number of inliers in this set
        if distance<=d
            inliers=inliers+1;
            inPoints(1:2,end+1)=Pt(1:2,:);
        else
            outPoints(1:2,end+1)=Pt(1:2,:);
        end
        
    end
    
    if inliers>bestInliers
        bestInliers=inliers;
        %line=[m,b];
        inlierSet=inPoints;
        outlierSet=outPoints;
        
       %finding largest gaps
       index = 0;
       largestgap = 0;
       pt = NaN;
       for i = 1:size(inlierSet, 2) - 1;
           dist = sqrt((inlierSet(1,i) - inlierSet(1,i + 1))^2 + (inlierSet(2,i) - inlierSet(1,i + 1))^2);
           if dist > largestgap
               largestgap = dist;
               pt = [inlierSet(1,i), inlierSet(2,i)];
               index = i;
           end
       end
                     
        %Determine line segment
        xLine=[min(inlierSet(1,:)),pt];
        yLine=y(xLine);
        linePts=[xLine; yLine];
        
       
       
         
                     
        %Determine line segment
        xLine=[min(inlierSet(1,:)),pt];
        yLine=y(xLine);
        linePts=[xLine; yLine];
            
    end
    
end

end

