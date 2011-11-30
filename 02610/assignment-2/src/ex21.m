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
saveeps('../media/ex21-plot.eps');

plot(1./x, 1./y, 'r.', 'MarkerSize', 16);
set(gca, 'FontSize', fs);
axis([0 6 0 140]);
xlabel('Inverse Concentration');
ylabel('Inverse Reaction rate');
title('Plot of the inverse data (1/x, 1/y)');
saveeps('../media/ex21-plot-inv.eps');

%theta = calc_chemical_reaction_params_linear(x, y);
%yhat = @(x, theta)(theta(1)*x)./(theta(2)+x);
%x_preds = linspace(0,2,100);
%y_preds = yhat(x_preds, theta);

%plot(x_preds, y_preds, 'b-');

% plot(1./x, 1./y, 'ro');
% axis([0 6 0 140]);


