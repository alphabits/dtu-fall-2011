function [xmin, A, X, F, DF] = linesearch(fns, x0, direction, stepsearch)

    kmax = 1000;
    tol = 10^(-5);
    rho = 0.9;
    c = 1.0e-4;
    xmin = x0;

    k = 0;
    x = x0;

    [f,df,ddf] = fns(x);

    X = [x0];
    F = [f];
    DF = [df];
    A = [];

    converged = (norm(df,'inf')<tol);

    while ~converged && k<kmax
        pk = direction(f, df, ddf);

        a = stepsearch(fns, x, pk, f, df, rho, c);

        x = x + a*pk;
        
        [f,df,ddf] = fns(x);
        
        converged = (norm(df,'inf')<tol);
        
        if converged
            xmin = x;
        else
            xmin = [];
        end

        k = k+1;

        % Update history matrices
        A = [A, a];
        X = [X,x];
        F = [F,f];
        DF = [DF,df];
    end

end
