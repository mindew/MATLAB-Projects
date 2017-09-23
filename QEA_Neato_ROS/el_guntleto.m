clear all
pub = rospublisher('/raw_vel');
sub = rossubscriber('/encoders');
sub_bump=rossubscriber('/bump');

msg=rosmessage(pub);


%Velocities of wheels
vL=0;
vR=0;

msg.Data=[vL, vR];
send(pub,msg);

heading=[0; 1];

load penscans.mat
[Ex, Ey, V, vFunc] = multiple_lines(theta_all, r_all);
%Hill function
% Height = @(x) x(1)*x(2) - x(1)^2 - x(2)^2 - 2*x(1) - 2*x(2) + 4;
% Define the gradient vector
% keyboard;
% potential_gradient =@(x) [Ex(round(x(1),0)); Ey(round(x(2),0))];
potential_gradient =@(x) [(vFunc(x+[.001;0])-vFunc(x))/.001;(vFunc(x+[0; .001])-vFunc(x))/.001];
%Initial point
x=[0; 0];

lambda = 1/16;
delta = 1;

% keyboard;
while norm(potential_gradient(x)) > 0.01
    normalizedpotential_gradient=potential_gradient(x)./norm(potential_gradient(x));
    
    
%     bump_message = receive(sub_bump);
%     if (bump_message.Data(1) == 1 || ...
%             bump_message.Data(2) == 1 || ...
%             bump_message.Data(3) == 1 || ...
%             bump_message.Data(4) == 1)
%         msgOut.Data = [0, 0];
%         send(pub, msgOut);
%         break;
%     end
    
    
    if normalizedpotential_gradient(1)==0
        normalizedpotential_gradient(1)=.001;
    end
    
    if heading(1)==0
        heading(1)=.001;
    end
    
    %angle we want to go
    theta=atan(normalizedpotential_gradient(2)/normalizedpotential_gradient(1));
    %angle we're at
    theta0=atan(heading(2)/heading(1));
    deltaTheta=theta-theta0;
    
    heading=normalizedpotential_gradient;
    
    %     hold on
    %     quiver(x(1),x(2),heading(1),heading(2))
    
    %time to turn
    t=deltaTheta/0.8;
    
    if t<0
        vL=0.1;
    else
        vL=-0.1;
    end
    vR=-vL;
    
    msg.Data=[vL, vR];
    send(pub,msg);
    
    pause(t)
    
    
    distance=lambda*norm(potential_gradient(x));
    distance=0.305*distance;
    
    %Wheel speeds
    vL=0.1; vR=0.1;
    
    msg.Data=[vL, vR];
    send(pub,msg);
    
    pause(distance/0.1)
    
    % Compute the next point
    x = x + lambda.*potential_gradient(x);
    
    % Change the step-size
    lambda = lambda.*delta;
    
    
    msg.Data=[0, 0];
    send(pub,msg);
end

