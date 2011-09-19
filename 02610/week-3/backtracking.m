function a = backtracking(fns, xk, pk, fk, dfk, rho, c)

    function converged = is_converged()
        fkstep = fns(xk+a*pk);
        tol = fk + c*a*dfk'*pk;
        converged = fkstep <= tol;
    end

    a = 1;
    k = 1;
    kmax = 100;
    fknew = fk;
    converged = is_converged();

    while ~converged && k<kmax
        a = rho*a;
        converged = is_converged();
        k = k+1;
    end

end
