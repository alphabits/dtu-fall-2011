function [r J] = residual_jacobian_ex23(theta, x, y)
    Z = ex23_z(x, theta);

    r = y - Z(:,1);
    J = -Z(:,2:3);
end
