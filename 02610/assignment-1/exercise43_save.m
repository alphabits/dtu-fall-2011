% This script should only be called after exercise43.m have been run
% as this script relies on data calculated by exercise43.m

% Iterate all combinations of starting point and algorithm
for x0ind = 1:numx0
    for algoind = 1:numalgos
        X = xs{x0ind, algoind};
        filenametmpl = sprintf('%s-start%d', algorithms{algoind}, x0ind);
        normarray = norms{x0ind, algoind};
        n = length(normarray);
        
        % Save gradient norms as latex table
        f = fopen([filenametmpl, '.tex'], 'w');
        for i = (n-4):n
            fprintf(f, '%d & %.3e\n', i-1, normarray(i));
        end
        fclose(f);

        % Plot gradient norms as function of iteration number
        % and save as eps
        set(gca, 'fontsize', 16);
        toplot = max(1, n-30):n;
        semilogy(toplot, normarray(toplot), 'r^', 'markersize', 8, 'linewidth', 2);
        titlestr = sprintf('Algorithm: %s, x_0=(%.02f, %.02f)', ...
                           algorithms{algoind}, x0s(1,x0ind), x0s(2, x0ind));
        title(titlestr, 'fontsize', 16);
        xlabel('Iteration no.'); ylabel('Norm of gradient'); 
        saveeps([filenametmpl, '.eps']);

        % Plot the convergence on contour plot
        plot_rosenbrock_convergence(X, titlestr);
        saveeps([filenametmpl, '-contour.eps']);
    end
end
