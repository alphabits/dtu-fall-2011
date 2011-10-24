function [xmin,X,F,DF] = newton(fun,x0,tol,maxiters)

    xmin = x0;
    k = 0;
    x = x0;

    [f,df,ddf] = fun(x);

    X = [x0]; F = [f]; DF = [df];

    converged = (norm(df,'inf') < tol);

    while ~converged && k < maxiters
        s = -(ddf\df);
        x = x + s;
        
        [f,df,ddf] = fun(x);
        
        X = [X,x]; F = [F,f]; DF = [DF,df];
        
        converged = (norm(df,'inf') < tol);
        
        if converged
            xmin = x;
        else
            xmin = [];
        end

        k = k + 1;
    end

end
