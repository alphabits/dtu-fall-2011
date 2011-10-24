function a = backtracking(fns, xk, pk, fk, dfk, rho, c)
    %BACKTRACKING : Perform a backtracking step length selection. Base on 
    %               algorithm 3.1 on page 37 in "Numerical Optimization" 
    %               (2nd ed. 2006) by Nocedal and Wright.  
    %
    % Call  a = backtracking(fns, xk, pk, fk, dfk, rho, c)
    %
    % Input parameters 
    % fns  :  Handle to the function to minimize.
    % xk   :  The current x iteration.
    % pk :  The search direction
    % fk : The current function value
    % dfk : The current gradient vector
    % rho : Damping parameter of a.
    % c :  Affects the stopping criteria
    %
    % Output parameters
    % a  :  The step length

    a = 1;
    k = 1;
    kmax = 100;
    fknew = fk;

    function converged = is_converged()
        fkstep = fns(xk+a*pk);
        tol = fk + c*a*dfk'*pk;
        converged = fkstep <= tol;
    end

    converged = is_converged();

    while ~converged && k<kmax
        a = rho*a;
        converged = is_converged();
        k = k + 1;
    end

end
