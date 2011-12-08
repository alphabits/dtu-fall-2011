function yhat = ex23_yhat(t, p)
    x0 = 10;
    model = @(t, x)-p(1)*x./(p(2)+x);
    [T, X] = ode45(model, t, x0, []);
    yhat = X;
end
