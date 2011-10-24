function [r, J] = residual_jacobian_M1(x, t, y)
    r = M1(x,t) - y;
    J = [-x(2)*t.*exp(-x(1)*t) exp(-x(1)*t) ones(size(t))];
end 
