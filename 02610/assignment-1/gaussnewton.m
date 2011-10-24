function [xmin, X, F, DF, A] = gaussnewton(fun, x0, opts)

    function [f, df, ddf] = calc_f(x)
        [r, J] = fun(x);
        f = (r'*r)/2;
        df = J'*r;
        ddf = J'*J;
    end

    opts.algorithm = 'newton';
    [xmin, X, F, DF, A] = linesearch(@calc_f, x0, opts);

end
