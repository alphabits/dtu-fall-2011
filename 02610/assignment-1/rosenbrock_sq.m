function [r, J] = rosenbrock_sq(x)
    r = [10*x(2)-10*x(1)^2;  1-x(1)];
    J = [-20*x(1)  10;
         -1  0];
end
