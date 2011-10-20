function [xmin,X,F,DF] = Newton(fun,x0,tol,maxiters,varargin)

    xmin = x0;
    k = 0;
    x = x0;

    [f,df,ddf] = feval(fun,x,varargin{:});

    X = [x0]; F = [f]; DF = [df];

    converged = (norm(df,'inf') < tol);

    while ~converged && k < maxiters
        s = -(ddf\df);
        x = x + s;
        
        [f,df,ddf] = feval(fun,x,varargin{:});
        
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
