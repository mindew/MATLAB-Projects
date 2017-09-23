sub_scan = rossubscriber('/stable_scan');
sub_bump = rossubscriber('/bump');
pub = rospublisher('/raw_vel');
msg = rosmessage(pub);

tf=rostf;
n = 30;
% iteration number
d = .1;
% threshold distance

while 1

    %Get scan data
    scan_msg=receive(sub_scan);
    r=scan_message.Ranges(1:end-1);
    theta=[0:359]';
    
    %Clean up data and convert to cartesian coordinates
    [Xs,Ys]=cleanCartesian(r,theta);
       
    %Transform scan data to room frame
    [R,T]=getScanTransform(tf, scan.Header.Stamp);
    dataTransformed=T*R*[Xs,Ys,ones(length(Xs),1)]';
    
    %Fit line segments
    multipleLines(Xs, Ys, n, d);
    %Define gradient field based on line segments 
    
    
    %(Add bucket location as attractive point)
    %bobLoc=[111;55]./0.0254; %Coordinates of the BoB in meters
    
    %Choose path based on gradient (ala flatlands, gadient ascent)
    
    %Move
    
%     %If bump then stop and back up for a second
%         if (sub.LatestMessage.Data(1) == 1 || ...
%         sub.LatestMessage.Data(2) == 1 || ...
%         sub.LatestMessage.Data(3) == 1 || ...
%         sub.LatestMessage.Data(4) == 1)
%         tic
%         msg.Data = [-0.1, -0.1];
%         if toc>1
%             send(pub, msg);
%             break;
%         end
%    end
    
    
    %Conditions for breaking out of the loop
    %(If tapping BoB, then break and send stop message)
          
end