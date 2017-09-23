clear;

load('playpensample.mat');

n = 60;
d = 0.1;

[x, y] = cleanCartesian(r, theta);
linesegs = multipleLines(x, y, n, d);


figure;
hold on;
plot(x, y, 'ks');

for i = 1:size(linesegs, 1)
   plot(linesegs(i,1:2), linesegs(i,3:4),'r-') 
end

hold off;