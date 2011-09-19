function [fns] = rosenbrockfactory(a)
    function [f, df, ddf] = rosenbrock(x)
        
        f = a*(x(2)-x(1)^2)^2 + (1-x(1))^2;

        df = [-4*a*x(1)*(x(2)-x(1)^2)-2*(1-x(1)) ;
              2*a*(x(2)-x(1)^2)];

        ddf = [-4*a*x(2)+12*a*x(1)^2+2  -4*a*x(1) ; 
               -4*a*x(1)                2*a ];

    end

    fns = @rosenbrock;
end
