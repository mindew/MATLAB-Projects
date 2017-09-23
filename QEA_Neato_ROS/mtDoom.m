function mtDoom()
    %rosinit('10.0.75.2',11311, 'NodeHost','10.0.75.1')
    %x is forward, y is left, z is up
    d = 0.24*1.062*3.28084;
    pub_vel = rospublisher('/raw_vel');
    sub_accel = rossubscriber('/accel');
    sub_bump = rossubscriber('/bump');
    theta = pi/2-atan(.99/.33);
    C = [cos(theta) 0 -sin(theta);
         0          1 0;
         sin(theta) 0 cos(theta)];
    
    function res = getN()
        acc_msg = receive(sub_accel);
        acc = acc_msg.Data;
        res = C*acc;
    end
    function setWheelV(vl,vr)
        msg = rosmessage(pub_vel);
        msg.Data = [vl vr]/3.28084;
        %disp(msg.Data)
        send(pub_vel,msg); 
    end
    function [vl,vr] = calculateV(vLinear, vAngular)
        vl = vLinear - (vAngular*d)/2;
        vr = vLinear + (vAngular*d)/2;
    end
    function setV(vLin, vAng)
        [vl,vr] = calculateV(vLin,vAng);
        setWheelV(vl, vr);
    end
    function findGrad()
        turnToGrad(pi,0.05);
    end
    function advance(speed,time)
        Nv = getN();
        Nv = Nv(1:2);
        l = norm(Nv);
        disp(l)
        setV(speed*sqrt(l),0);
        pause(time);
        setWheelV(0,0);
        return
    end
    function turnToGrad(speed,epsilon)
        while(1)
            N = getN();
            if(abs(N(2))<epsilon)
                break;
            end
            setV(0,N(2)*speed);
        end
        setWheelV(0,0);
    end
    while(1)
        findGrad()
        advance(1,.1);
    end
end