x = -10:0.2:10;
y = -10:0.2:10;
v = -3:0.1:3;
[X, Y] = meshgrid(x, y);

logfs = max(log10(arrayfun(@mybranin, X, Y)), -5);

contour(X, Y, logfs, v, 'linewidth', 1);
colorbar;
set(gca, 'fontsize', 14);
