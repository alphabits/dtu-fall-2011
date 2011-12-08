function phi_fun = get_phi_fun(x, y, yhat_fun)

    function phi = calc_phi(theta1, theta2)
        yhat = yhat_fun(x, [theta1, theta2]);
        phi = 0.5*sum((y-yhat).^2);
    end

    phi_fun = @calc_phi;

end
