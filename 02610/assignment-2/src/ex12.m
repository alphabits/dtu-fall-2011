load_ex1;

n = 3;

[xstar, rstar] = NOfit(t, y, n);

file = fopen('../tables/3rd-order-fitted-model.tex', 'w');
fprintf(file, 'M(\\myvec{x}, t) = %.02f %+.02f \\sin(\\omega t) %+.02f \\cos(\\omega t)', xstar);
fclose(file);

plot_fit(t, y, n, xstar, rstar, '3rd order fit for Air Pollution Data');
saveeps('../media/3rd-order-fit.eps');
