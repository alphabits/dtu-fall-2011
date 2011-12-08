function [] = ex2_plot_model_with_data(theta, x, y, line_spec)
    x_preds = linspace(0,2.2,100);
    y_preds = ex2_yhat(x_preds, theta);

    plot(x_preds, y_preds, line_spec, x, y, 'r.', 'MarkerSize', 16, 'LineWidth', 2);
    set(gca, 'FontSize', 16);
    axis([0 2.2 0 0.08]);
    xlabel('Concentration');
    ylabel('Reaction rate');
    title('Plot of reaction rate as function of concentration');
end
