function [r J] = residual_jacobian_ex22(theta, x, y)
    xplustheta2 = theta(2) + x;

    r = y - theta(1)*x./xplustheta2;
    J = -[x./xplustheta2  -theta(1)*x./xplustheta2.^2];
end
