function phi_fun = ex22_phi(x, y)

    function phi = calc_phi(theta1, theta2)
        yhat = ex2_yhat(x, [theta1, theta2]);
        phi = 0.5*sum((y-yhat).^2);
    end

    phi_fun = @calc_phi;

end
