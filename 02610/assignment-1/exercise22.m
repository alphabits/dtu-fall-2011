function [xmin, X, F, DF] = exercise22()
    A = [2 1; 1 2];
    b = [-1.5; 0];

    function [f, df, ddf] = fun(x)
        f = (x'*A*x)/2 + b;
        df = A*x + b;
        ddf = A;
    end

    [xmin, X, F, DF] = Newton(@fun, [0;0])
end
