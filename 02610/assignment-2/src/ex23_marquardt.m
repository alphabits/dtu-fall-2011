addpath('/home/anders/dtu/E11/02610/src/immoptibox');

data = load('../data/MMBatchData.mat');
data = data.data;

x = data(:,1);
y = data(:,2);


[thetas, info, perf] = marquardt(@residual_jacobian_ex23, [0.1 1.5], [0 1e-7 1e-12 0], x, y);
theta = thetas(:, end);
[r, J] = residual_jacobian_ex23(theta, x, y);
sigma_est = 0.5*sum(r.^2)/(length(x)-length(theta));
[covar, err, min_theta, max_theta] = calculate_and_save_covariance_info(theta, sigma_est, J, 'ex23', '\\theta');
