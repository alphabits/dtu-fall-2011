addpath('/home/anders/dtu/E11/02610/src/immoptibox');

data = load('optic.dat');

t = data(:, 1);
y = data(:, 2);

% Choose between model 1 or 2.
model = 2;

if model == 1
    x0 = [0.2, 18, -1];
    res_jac = @residual_jacobian_M1;
    M = @M1;
else
    x0 = [0.2, 0.2, 8, 8, -1];
    res_jac = @residual_jacobian_M2;
    M = @M2;
end

%[maxJ, err, ind] = checkgrad(res_jac, x0, 1e-5, t, y);

[xs, info, perf] = marquardt(res_jac, x0, [0 1e-7 1e-12 0], t, y);

xmin = xs(:,end);

tbldata = {perf.ng, perf.f};
tbldatafilenames = {sprintf('gradient-norm-model-%d.tex', model), ...
                    sprintf('function-values-model-%d.tex', model)};

% Save results as latex tables
for i=1:2
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
