x0s = [0 1 3.9 4.1; 
       0 0 -1 -1];

tol = 1e-12;
maxiters = 1000;

norms = zeros(4,1);

for i=1:4
    [xmin, X, F, DF] = Newton(@branin, x0s(:,i), tol, maxiters);
    if length(xmin) > 0
        x1 = xmin(1); x2 = xmin(2);
    else
        x1 = X(1, end); x2 = X(2, end);
    end
    [f, r1, r2] = mybranin(x1, x2);
    norms(i) = norm([r1 r2]);
end
