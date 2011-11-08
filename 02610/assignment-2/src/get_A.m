function [A] = get_A(t, n)

    if mod(n, 2) == 0
        error('Only odd number of basis functions');
    end

    omega = 2*pi/24;
    m = length(t);
    A = zeros(m, n);
    fns = {@sin, @cos};

    for i=1:m
        for j=1:n
            % Cycle between sine and cosine
            f = fns{mod(j,2)+1};
            A(i,j) = f(floor(j/2)*omega*t(i));
        end
    end
end
