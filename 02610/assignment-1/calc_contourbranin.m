function [logfs] = calc_contourbranin(X, Y)
    logfs = max(log10(arrayfun(@mybranin, X, Y)), -5);
end
