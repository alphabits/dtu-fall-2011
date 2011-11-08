function [xstar, rstar, A] = NOfit(t, y, n)

    omega = 2*pi/24;
    m = length(t);

    if m ~= length(y)
        error('The length of t and y should match')
    end

    A = get_A(t, n);

    xstar = (A'*A)\(A'*y);
    rstar = y - A*xstar;
end
