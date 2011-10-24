addpath('/home/anders/dtu/E11/02610/src/immoptibox');

data = load('optic.dat');

t = data(:, 1);
y = data(:, 2);

% Choose between model 1 or 2.
model = 1;

if model == 1
    x0 = [0.2, 18, -1];
    res_jac = @residual_jacobian_M1;
    M = @M1;
else
    x0 = [0.2, 0.2, 8, 8, -1];
    res_jac = @residual_jacobian_M2;
    M = @M2;
end

[xs, info, perf] = marquardt(res_jac, x0, [0 1e-7 1e-12 0], t, y);

xmin = xs(:,end);

% Plot gradient as function of iteration number
set(gca, 'fontsize', 16);
semilogy(perf.ng, 'r^', 'markersize', 8, 'linewidth', 2);
titlestr = sprintf('Gradient size for model M_%d (Levenberg-Marquardt)', model);
title(titlestr, 'fontsize', 16);
xlabel('Iteration no.'); ylabel('Norm of gradient'); 
saveeps(sprintf('least-squares-convergence-model-%d.eps', model));

% Save results as latex tables
xerr = xs - repmat(xmin, 1, size(xs,2));
xerr_norms = sqrt(xerr(1,:).^2 + xerr(2,:).^2 + xerr(3,:));
tbldata = {perf.ng, perf.f, xerr_norms};
tbldatafilenames = {sprintf('gradient-norm-model-%d.tex', model), ...
                    sprintf('function-values-model-%d.tex', model), ...
                    sprintf('xerror-model-%d.tex', model)};
for i=1:3
    tmpdata = tbldata{i};
    num = length(tmpdata); 
    tosave = 1:num;
    file = fopen(tbldatafilenames{i}, 'w');
    fprintf(file, '%d & %.2e \\\\ \n', [tosave; tmpdata(tosave)]);
    fclose(file);
end

% Calculate residuals
r = res_jac(xmin, t, y);

% Define string representation of model
if model == 1
    modelstr = sprintf('M_1^*(t) = %.02fe^{%.02ft} %+.02f', ...
                        xmin(2), -xmin(1), xmin(3));
else
    modelstr = sprintf('M_2^*(t) = %.02fe^{%.02ft} %+.02fe^{%.02ft} %+.02f', ...
                        xmin(3), -xmin(1), xmin(4), -xmin(2), xmin(5));
end

% Save string representation for latex report
fid = fopen(sprintf('model-%d-representation.tex', model), 'w');
fwrite(fid, modelstr);
fclose(fid);

% Plot the fitted model and the data set
newt = linspace(0, 35, 200);
plot(t, y, 'k.', newt, M(xmin, newt), 'linewidth', 2);
title(['Fitted model: ' modelstr], 'fontsize', 14);
set(gca, 'fontsize', 14);
grid on;
saveeps(sprintf('least-squares-model-%d.eps', model));

% Plot the residuals 
plot(t, r, 'k.', 'MarkerSize', 10);
title(['Residuals of fitted model: ' modelstr], 'fontsize', 14);
set(gca, 'fontsize', 14);
saveeps(sprintf('least-squares-model-%d-res.eps', model));
