x = linspace(-1.5, 1.5, 300);
y = linspace(-0.5, 2, 300);

[X, Y] = meshgrid(x, y);


f = 100*(Y-X.^2).^2 + (1-X).^2;
v = 1:20;


contour(x, y, f, v); axis equal; hold on; grid on;
