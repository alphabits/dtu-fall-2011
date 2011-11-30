addpath('/home/anders/dtu/E11/02610/src/immoptibox');

dat = load('../data/reaction-rates.txt');

x = dat(:,1);
y = dat(:,2);

x0 = [8, 8];
[xs, info, perf] = marquardt(@residual_jacobian_ex22, x0, [0 1e-7 1e-12 0], x, y);
%[X] = marquardt(@residual_jacobian_ex22, x0, [0 1e-7 1e-12 0], x, y);
