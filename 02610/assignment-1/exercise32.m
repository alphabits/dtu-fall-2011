function [xmin] = exercise32()
    data = load('optic.dat');

    t = data(:, 1);
    y = data(:, 2);

    M_1 = @(x, t)x(2)*exp(-x(1).*t)+x(3);
    M_2 = @(x, t)x(3)*exp(-x(1).*t)+x(4)*exp(-x(2).*t)+x(5);

    function [jac] = jacobian_1(x, t)
        jac = [-x(2)*t*exp(-x(1)*t) exp(-x(1)*t) 1];
    end

    function [jac] = jacobian_2(x, t)
        jac = [-x(3)*t*exp(-x(1)*t) -x(4)*t*exp(-x(2)*t) exp(-x(1)*t) exp(-x(2)*t) 1];
    end

    function [r, J] = residual_jacobian(x, f, jac, data_t, data_y)
        r = f(x, data_t) - data_y;
        J = zeros(length(data_t), length(x));
        for i=1:length(data_t)
            J(i, :) = jac(x, data_t(i));
        end
    end 

    M = M_1;
    jaco = @jacobian_1;
    %x0 = [0.2, 0.2, 8, 8, -1];
    x0 = [0.25, 19, -1];

    xmin = marquardt(@residual_jacobian, x0, [], M, jaco, t, y);
    r = residual_jacobian(xmin, M, jaco, t, y);
  
    subplot(1, 2, 1);
    hold on;
    plot(t, y, 'ro');
    t = linspace(0, 40, 200);
    plot(t, M(xmin, t), 'linewidth', 3);
    hold off;

    subplot(1, 2, 2);
    plot(t, r, 'ro');
end
