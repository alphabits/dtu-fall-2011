% Define the four starting points
x0s = [0 1 3.9 4.1; 
       0 0 -1 -1];

% Calculate function values for the contour plot
x = -10:0.1:10;
y = -10:0.1:10;
v = -3:0.1:3;
[Xg, Yg] = meshgrid(x, y);
logfs = max(log10(arrayfun(@mybranin, Xg, Yg)), -5);

tol = 1e-12;
maxiters = 1000;

% Initialize cell arrays to hold the results from the four
% different starting points.
xmins = {};
Xs = {};
Fs = {};
DFs = {};

for i=1:4
    % Calculate results and save
    [xmin, X, F, DF] = newton(@branin, x0s(:,i), tol, maxiters);
    xmins{i} = xmin;
    Xs{i} = X;
    Fs{i} = F;
    DFs{i} = DF;

    % Plot contour plot
    contour(Xg, Yg, logfs, v, 'linewidth', 1);
    colorbar;
    set(gca, 'fontsize', 14);
    hold on;
    xpath = X(1,:);
    ypath = X(2,:);

    % Determine the plot limits based on the path points
    xlimits = [max(min(xpath)-0.4, -10) min(max(xpath)+0.4, 10)];
    ylimits = [max(min(ypath)-0.4, -10) min(max(ypath)+0.4, 10)];
    plot(xpath, ypath, 'kx-', 'linewidth', 2);
    xlim(xlimits);
    ylim(ylimits);
    plottitle = sprintf('Number of iterations: %d. x^{(0)}_%d = (%.02f, %.02f)', ...
                        length(xpath)-1, i, x0s(1,i), x0s(2,i));
    title(plottitle, 'fontsize', 18);
    hold off;
    set(gca, 'fontsize', 18);

    % Save as eps
    print('-depsc', '-loose', sprintf('newton-on-branin-%d', i));
end
