% Should only be called after the function exercise44 have been run and the 
% results have been saved in the variables xs and norms. This script relies
% on these two variables being available

% Define starting points
x0s = [ -1.2  1.2; 
         1    1.2 ];
numx0 = size(x0s, 2);
% Define algorithms
algorithms = {'quasi-newton', 'steepest-descent'};
numalgos = length(algorithms);

% Iterate all combinations of starting points and algorithms
for x0ind = 1:numx0
    for algoind = 1:numalgos
        X = xs{x0ind, algoind};
        filenametmpl = sprintf('%s-start%d-fminunc', algorithms{algoind}, x0ind);
        normarray = norms{x0ind, algoind};
        n = length(normarray);

        % Save gradient norms as latex table
        f = fopen([filenametmpl, '.tex'], 'w');
        for i = (n-4):n
            fprintf(f, '%d & %.3e\n', i-1, normarray(i));
        end
        fclose(f);

        % Plot gradient norm as function of iteration number
        set(gca, 'fontsize', 16);
        toplot = max(1, n-30):n;
        semilogy(toplot, normarray(toplot), 'r^', 'markersize', 8, 'linewidth', 2);
        titlestr = sprintf('Algorithm: %s (fminunc), x_0=(%.02f, %.02f)', ...
                           algorithms{algoind}, x0s(1,x0ind), x0s(2, x0ind));
        title(titlestr);
        xlabel('Iteration no.'); ylabel('Norm of gradient'); 
        saveeps([filenametmpl, '.eps']);

        % Plot iteration path on contour plot
        plot_rosenbrock_convergence(X, titlestr);
        saveeps([filenametmpl, '-contour.eps']);
    end
end
