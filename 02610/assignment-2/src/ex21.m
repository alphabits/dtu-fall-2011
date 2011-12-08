dat = load('../data/reaction-rates.txt');

x = dat(:,1);
y = dat(:,2);

fs = 16;

plot(x, y, 'r.', 'MarkerSize', 16);
set(gca, 'FontSize', fs);
axis([0 2.2 0 0.08]);
xlabel('Concentration');
ylabel('Reaction rate');
title('Plot of reaction rate as function of concentration');
%saveeps('../media/ex21-plot.eps');

plot(1./x, 1./y, 'r.', 'MarkerSize', 16);
set(gca, 'FontSize', fs);
axis([0 6 0 140]);
xlabel('Inverse Concentration');
ylabel('Inverse Reaction rate');
title('Plot of the inverse data (1/x, 1/y)');
%saveeps('../media/ex21-plot-inv.eps');

[theta, lambda] = calc_chemical_reaction_params_linear(x, y);
ex2_plot_model_with_data(theta, x, y);
%saveeps('../media/ex21-linear-model.eps');

fid = fopen('../tables/param-estimates-ex21.tex', 'w');
fprintf(fid, '\\theta_{LS}^* \\approx \\begin{pmatrix} %0.2f \\\\ %0.2f \\end{pmatrix} \n', theta);
fclose(fid);

% plot(x_inv_preds, y_inv_preds, 'b-', 1./x, 1./y, 'ro');
% axis([0 6 0 140]);


