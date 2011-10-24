function [xmin, X, F, DF, A] = linesearch(fns, x0, opts)
    %LINESEARCH : Perform a line search that finds a minimum  of the function 
    %             represented by the input fns. An initial guess of the 
    %             minimum must be given as the input x0. Various parameters 
    %             concerning the execution of the linesearch can be controlled 
    %             by passing options as the input opts.  
    %
    % Call  [xmin, X, F, DF, A] = linesearch(fns, x0, opts)
    %
    % Input parameters 
    % fns  :  Handle to the function to minimize. When the algorithm is 
    %         'steepest-descent' or 'newton' the function should have the 
    %         interface
    %
    %         [f, df, ddf] = fns(x)
    %
    %         where f is the function value at x. df is the gradient at x, and 
    %         ddf is the hessian at x. When the algorithm is 'quasi-newton' the 
    %         hessian is not needed and the interface should be
    %
    %         [f, df] = fns(x)
    %
    % x0   :  Initial guess for the minimum.
    % opts :  Struct containing settings for the execution of the linesearch. 
    %         The available settings are
    %         algorithm  :  Choose between 'steepest-descent', 'newton', 
    %                       'quasi-newton'. (default: 'steepest-descent')
    %         maxiter    :  The maximum number of iterations performed. 
    %                       (default: 1000)
    %         tol        :  The size the norm of the gradient should reach 
    %                       before the algorithm terminates. (default: 1e-5)
    %         rho        :  Damping parameter used by the linesearch algorithm. 
    %                       (default: 0.9)
    %         c          :  Parameter used for the sufficient decrease condition 
    %                       in the linesearch algorithm. (default: 1e-4)
    %         hessian    :  Only used when the algorithm is quasi-newton. Set to 
    %                       the initial approximation of the hessian. 
    %                       (default: eye(length(x0)))
    %
    % Output parameters
    % xmin  :  Minimum determined by the algorithm. Is an empty vector if the 
    %          algorithm terminated before the norm of the gradient reached the 
    %          tolerence set in opts.tol.
    % X     :  Matrix containing all x values visited by the algorithm. Each x 
    %          value is a column in X so the maximum size of X is 
    %          "length(x0) x maxiter".
    % F     :  Matrix containing function values for all x values visited.
    % DF    :  Matrix containing gradient values for all x values visited.
    % A     :  Matrix containing step sizes for all x values visited.


    % Define default options
    defaultopts = struct( ...
        'algorithm', 'steepest-descent', ...
        'maxiter', 1000, ...
        'tol', 1e-5, ...
        'rho', 0.9, ...
        'c', 1e-4, ...
        'hessian', eye(length(x0)) ...
    );
    % Overwrite default options with options given as input
    opts = mergestructs(defaultopts, opts);

    % Helpers to make later code more readable
    is_steepest_descent = strcmp(opts.algorithm, 'steepest-descent');
    is_newton = strcmp(opts.algorithm, 'newton');
    is_quasi_newton = strcmp(opts.algorithm, 'quasi-newton');

    % Check that algorithm exists
    if ~(is_steepest_descent || is_newton || is_quasi_newton)
        error('Algorithm not recognized');
    end

    k = 0;
    x = x0;
    xmin = x0;

    % Initialize function value, gradient and hessian
    if is_quasi_newton
        [f, df] = fns(x);
        Hk = opts.hessian;
        I = eye(length(x));
    else
        [f,df,ddf] = fns(x);
    end

    X = [x0]; F = [f]; DF = [df]; A = [];

    converged = (norm(df,'inf') < opts.tol);

    while ~converged && k < opts.maxiter
        % Determine search direction
        if is_steepest_descent
            pk = -df;
        elseif is_quasi_newton
            pk = -Hk*df;
        else
            pk = -ddf\df;
        end

        % Find step length and update x
        a = backtracking(fns, x, pk, f, df, opts.rho, opts.c);
        sk = a*pk;
        x = x + sk;
        
        % Update function value, gradient and hessian
        if is_quasi_newton
            [f, df] = fns(x);
            yk = df - DF(:, end);
            rhok = 1/(yk'*sk);
            syk = sk*yk';
            Hk = (I - rhok*syk)*Hk*(I - rhok*syk') + rhok*sk*sk';
        else
            [f,df,ddf] = fns(x);
        end
        
        converged = (norm(df,'inf') < opts.tol);

        if (converged) xmin = x; else xmin = []; end

        k = k + 1;

        % Update history matrices
        A = [A, a]; X = [X,x]; F = [F,f]; DF = [DF,df];
    end

end
