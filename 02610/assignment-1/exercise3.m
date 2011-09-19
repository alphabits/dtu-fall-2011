addpath('/home/anders/dtu/E11/02610/src/immoptibox');

data = load('optic.dat');

degrees = 1:9;

fit = @(n){polyfit(data(:,1), data(:,2), n)};
coeffs = arrayfun(fit, degrees);

for i=degrees
    subplot(3, 3, i);
    xs = linspace(0, 40, 200);
    ys = polyval(coeffs{i}, xs);
    hold on;
    plot(data(:, 1), data(:, 2), 'ro');
    plot(xs, ys, 'linewidth', 3)
    hold off;
end
