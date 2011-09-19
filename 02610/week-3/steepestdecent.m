function [xmin, A, X, F, DF] = steepestdecent(fns, x0)
    
    function pk = direction(f, df, ddf)
        pk = -df;
    end

    [xmin, A, X, F, DF] = linesearch(fns, x0, @direction, @backtracking);

end
