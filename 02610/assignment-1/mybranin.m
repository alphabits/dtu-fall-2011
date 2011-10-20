function [f, r1, r2] = mybranin(x1, x2)

    r1 = 1 - 2.*x2 + sin(4*pi.*x2)/20 - x1;
    r2 = x2 - sin(2*pi.*x1)/2;

    f = (r1^2 + r2^2)/2;

end
