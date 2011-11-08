function [] = plot_fit_with_res_analysis(t, y, n, x, r)
    z = run_score(r);
    [rho, Trho] = correlation_score(r);
    plot_title = sprintf('n: %d \\rho: %.02f T_\\rho: %.02f z: %.02f', ...
                         n, rho, Trho, z);
    plot_fit(t, y, n, x, r, plot_title);
end
