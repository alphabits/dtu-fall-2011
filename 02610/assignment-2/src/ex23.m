addpath('/home/anders/dtu/E11/02610/src/immoptibox');

data = load('../data/MMBatchData.mat');
data = data.data;

x = data(:,1);
y = data(:,2);


plot(x, y, 'r.', 'MarkerSize', 16);
set(gca, 'FontSize', 16);
xlabel('Time');
ylabel('Concentration');
title('Substrate concentration as function of time');
axis([-10 210 -1 10]);
saveeps('../media/ex23-data.eps');


odefun = @(t, x, p)-p(1)*x./(p(2)+x);
[T, X] = ode45(odefun, [0 200], 10, [], [0.14 2.54]);
[T2, X2] = ode45(odefun, 0:10:200, 10, [], [0.14 2.54]);

x_con = 0:0.05:0.5;
y_con = 0:0.2:4;
x_con = 0.05:0.005:0.15;
y_con = 0.05:0.2:6;
v = [0:0.2:5, 5:1:200];
[X_con, Y_con] = meshgrid(x_con, y_con);

phi_fun = get_phi_fun(x, y, @ex23_yhat);
phi = arrayfun(phi_fun, X_con, Y_con);

contour(X_con, Y_con, phi, v, 'linewidth', 1);
set(gca, 'FontSize', 16);
xlabel('\theta_1');
ylabel('\theta_2');
colorbar;
saveeps('../media/ex23-contour.eps');
