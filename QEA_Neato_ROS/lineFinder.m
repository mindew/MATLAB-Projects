function [m, b, xlimmin, xlimmax] = lineFinder (xmin, xmax, ymin, ymax)
    m = (ymax - ymin)/(xmax - xmin);
    b = ymax - m*xmax;
    xlimmin = xmin;
    xlimmax = xmax;
end