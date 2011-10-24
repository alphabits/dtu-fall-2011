addpath('/home/anders/dtu/E11/02610/src/immoptibox');

data = load('optic.dat');

% Polynomial degrees to fit
degrees = 1:6;
% Fontsize in plots
fs = 14;

for i=degrees
    coeffs = polyfit(data(:,1), data(:,2), i)
    xs = linspace(0, 35, 200);
    ys = polyval(coeffs, xs);
    % Plot data
    plot(data(:, 1), data(:, 2), 'r.', 'MarkerSize', 6);
    hold on;
    % Plot fitted polynomial
    plot(xs, ys, 'linewidth', 2)
    xlabel('msec', 'fontsize', fs); ylabel('Light intensity', 'fontsize', fs);
    xlim([0 35]);
    title(sprintf('Fitted polynomial of degree %d', i), 'fontsize', fs);
    set(gca, 'fontsize', fs);
    a = get(gca, 'DataAspectRatio');
    % Change aspect of plot. Can probably be done much easier
    set(gca, 'DataAspectRatio', a.*[1 2 1]);
    grid on;
    saveeps(sprintf('fitted-polynomial-%d.eps', i));
    hold off;
end
