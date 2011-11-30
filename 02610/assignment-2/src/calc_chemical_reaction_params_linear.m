function [theta, lambda] = calc_chemical_reaction_params_linear(x, y)

    lambda = zeros(2,1);
    theta = zeros(2,1);

    A = [ones(length(x), 1) 1./x];
    lambda = (A'*A)\(A'*(1./y));

    theta(1) = 1/lambda(1);
    theta(2) = lambda(2)/lambda(1);

end
