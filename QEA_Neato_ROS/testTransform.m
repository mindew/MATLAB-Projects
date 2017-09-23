tf = rostf;
pause(2);
rostime('now')
[R, T] = getScanTransform(tf)