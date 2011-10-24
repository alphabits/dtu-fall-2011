function [] = plot_rosenbrock_convergence(Xs, titlestr)
    % Helper function used in the scripts exercise43_save and exercise44_save
    % This function plot contour of the rosenbrock function and the iteration
    % path given in input parameter Xs

    % Determine plot limits based on the iteration points
    margins = 0.2;
    mins = min(Xs, [], 2) - margins;
    maxs = max(Xs, [], 2) + margins;
    x = linspace(max(-2, mins(1)), min(2, maxs(1)), 100);
    y = linspace(max(-1, mins(2)), min(1.5, maxs(2)), 100);

    % Calculate function values for contour plot
    v = -10:0.1:10;
    [X, Y] = meshgrid(x, y);
    f = arrayfun(@(x, y)rosenbrock([x;y]), X, Y);

    % Plot contour
    contour(X, Y, log(f), v, 'linewidth', 1);
    colorbar;
    set(gca, 'fontsize', 16);
    hold on;

    % Plot iteration path
    plot(Xs(1,:), Xs(2,:), 'k^', 'markersize', 10, 'linewidth', 2);
    plot(Xs(1,:), Xs(2,:), 'k-', 'linewidth', 2);
    hold off;
    title(titlestr, 'fontsize', 16);
    xlabel('x_1'); ylabel('x_2');
end
