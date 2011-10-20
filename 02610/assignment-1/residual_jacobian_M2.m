function [r, J] = residual_jacobian_M2(x, t, y)
    r = M2(x,t) - y;
    J = [-x(3)*t.*exp(-x(1)*t), -x(4)*t.*exp(-x(2)*t), exp(-x(1)*t), ...
         exp(-x(2)*t), ones(size(t))];
end
