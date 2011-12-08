function z = ex23_z(t, p)
    z0 = [10 0 0];

    function zdot = model(t, z, p)
        x = z(1,1);
        Sp = z(2:3, 1);
        
        x_plus_p2 = p(2)+x;
        x_plus_p2_sq = x_plus_p2.^2;

        xdot = -p(1)*x./x_plus_p2;

        dfdx = -p(1)./x_plus_p2 + p(1)*x./x_plus_p2_sq;
        dfdp = [-x./x_plus_p2;  p(1)*x./x_plus_p2_sq];

        Spdot = dfdx*Sp + dfdp;

        zdot = [xdot; Spdot(:)];
    end

    [T, X] = ode45(@model, t, z0, [], p);
    z = X;
end
