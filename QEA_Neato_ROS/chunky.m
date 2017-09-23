function chunky()
    %rosinit('10.0.75.2',11311, 'NodeHost','10.0.75.1')
    %video here: https://www.youtube.com/watch?v=qPb2KfK3Ycc
    encoderP = [0 0];
    theta = pi;
    x = 4;
    y = 1;
    omega = pi/2;
    step = .5;
    timeStep = 1.5;
    
    function turnTowards(dx,dy)
        thetaGoal = atan2(dy,dx);
        
        dtheta = thetaGoal-theta;
        if(dtheta>pi)
            dtheta = dtheta-2*pi;
        end
        if(dtheta<-pi)
            dtheta = dtheta+2*pi;
        end
        disp(dtheta)
        
        [vl,vr] = calculateV(0,omega*sign(dtheta));
        setWheelV(vl,vr);
        pause(abs(dtheta/omega))
        setWheelV(0,0);
        theta = thetaGoal;
    end
    function moveForward()
        setWheelV(step/timeStep,step/timeStep)
        pause(timeStep)
        setWheelV(0,0)
        x = x + step*cos(theta);
        y = y + step*sin(theta);
    end
    
    function setWheelV(vl,vr)
        msg = rosmessage(pub_vel);
        msg.Data = [vl vr]/3.28084;
        %disp(msg.Data)
        send(pub_vel,msg); 
    end
    function processEncoders(sub, msg)
        %nothing to see here folks!
    end
    function [vl,vr] = calculateV(vLinear, vAngular)
        d = 0.24*1.02*3.28084; %we need to experimentally detrmine this

        vl = vLinear - (vAngular*d)/2;
        vr = vLinear + (vAngular*d)/2;
    end

    global xs ys
    syms xs ys
    f = symfun(xs*ys - xs^2 - ys^2 - 2*xs - 2*ys + 4,[xs,ys]);
    dx = diff(f,xs);
    dy = diff(f,ys);
%   
    
    
    
    pub_vel = rospublisher('/raw_vel');
    sub_scan = rossubscriber('/encoders', @processEncoders);
    sub_bump = rossubscriber('/bump');
    
    
    global running
    running = 1;

    while(running)
        bump_msg = receive(sub_bump);
        if(any(bump_msg.Data))
            running = 0;
            break;
        end
        grad = [double(dx(x,y)),double(dy(x,y))];
        if(norm(grad)<.1)
            running = 0;
            break
        end
        turnTowards(grad(1),grad(2));
        pause(.1)
        moveForward()
        pause(.1)
    end
    for i = 1:5
        setWheelV(0,0)
    end
end