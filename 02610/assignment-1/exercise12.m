x = -10:0.2:10;
y = -10:0.2:10;
v = -3:0.1:3;
[X, Y] = meshgrid(x, y);

logfs = calc_contourbranin(X, Y);
contourbranin(X, Y, logfs, v);
