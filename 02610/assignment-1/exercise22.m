function [xmin, X, F, DF] = exercise22()
% Is really a script but since matlab won't allow functions to be defined
% in a script file a function is used instead of a script.

    A = [2 1; 1 2];
    b = [-1.5; 0];

    % Define input function for newton function
    function [f, df, ddf] = fun(x)
        f = (x'*A*x)/2 + b;
        df = A*x + b;
        ddf = A;
    end

    % Call newton implementation
    [xmin, X, F, DF] = newton(@fun, [0;0])
end
