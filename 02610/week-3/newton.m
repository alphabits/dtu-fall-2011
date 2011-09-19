function [xmin, A, X, F, DF] = newton(fns, x0)
    
    function pk = direction(f, df, ddf)
        pk = -(ddf\df);
    end

    [xmin, A, X, F, DF] = linesearch(fns, x0, @direction, @backtracking);

end
