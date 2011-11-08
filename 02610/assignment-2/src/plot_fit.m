function [] = plot_fit(t, y, n, x, r, plot_title)
    tplot = linspace(1,24,100);
    A = get_A(tplot, n);
    fit = A*x;
    fs = 18;
    set(gca, 'fontsize', fs);
    plot(tplot, fit, '-b', t, y, 'or');
    title(plot_title, 'fontsize', fs);
end
