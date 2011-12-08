addpath('/home/anders/dtu/E11/02610/src/immoptibox');

dat = load('../data/reaction-rates.txt');

x = dat(:,1);
y = dat(:,2);

[theta_lin, lambda] = calc_chemical_reaction_params_linear(x, y);

x_con = -0.1:0.005:0.25;
y_con = 0:0.1:4;
v = 0:0.0001:0.035;
[X_con, Y_con] = meshgrid(x_con, y_con);

phi_fun = ex22_phi(x, y);
phi = arrayfun(phi_fun, X_con, Y_con);

contour(X_con, Y_con, phi, v, 'linewidth', 1);
set(gca, 'FontSize', 16);
xlabel('\theta_1');
ylabel('\theta_2');
colorbar;
hold on;
plot(theta_lin(1), theta_lin(2), 'r.', 'MarkerSize', 20);
hold off;
%saveeps('../media/ex22-contour-linear.eps');


[xs, info, perf] = marquardt(@residual_jacobian_ex22, theta_lin, [0 1e-7 1e-12 1e3], x, y);
theta_marq = xs(:, end);
[r_marq, J_marq] = residual_jacobian_ex22(theta_marq, x, y);
sigma_est_marq = 0.5*sum(r_marq.^2)/(length(x)-length(theta_marq));

calculate_and_save_covariance_info(theta_marq, sigma_est_marq, J_marq, 'ex22', '\\theta^*');


ex2_plot_model_with_data(theta_lin, x, y, 'g-');
hold on;
ex2_plot_model_with_data(theta_marq, x, y, 'b-');
hold off;
%saveeps('../media/ex22-models-with-data.eps');


contour(X_con, Y_con, phi, v, 'linewidth', 1);
set(gca, 'FontSize', 16);
xlabel('\theta_1');
ylabel('\theta_2');
colorbar;
hold on;
plot(theta_marq(1), theta_marq(2), 'r.', 'MarkerSize', 20);
hold off;
%saveeps('../media/ex22-contour-marquardt.eps');

