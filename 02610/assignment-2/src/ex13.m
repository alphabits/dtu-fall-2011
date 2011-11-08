load_ex1;


for n=3:2:13
    [x, r] = NOfit(t, y, n);
    plot_fit_with_res_analysis(t, y, n, x, r);
    saveeps(sprintf('../media/order-determination-%d.eps', n));
end

