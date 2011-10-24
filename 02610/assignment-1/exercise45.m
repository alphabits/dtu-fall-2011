function [xs, norms] = exercise45()
    % Define starting points
    x0s = [ -1.2  1.2; 
             1    1.2 ];
    numx0 = size(x0s, 2);

    % Define data structures to hold results
    norms = cell(numx0, 1);
    xs = cell(numx0, 1);

    % Iterate starting points
    for x0ind = 1:numx0
        x0 = x0s(:,x0ind);
        X = []; DF = [];

        % Calculate results
        [xmin, X, F, DF, A] = gaussnewton(@rosenbrock_sq, x0, struct());
        xs{x0ind,1} = X;
        norms{x0ind,1} = sqrt(DF(1,:).^2 + DF(2,:).^2);

        % Plot and save gradient norm as function of iteration number
        filenametmpl = sprintf('gauss-newton-start%d', x0ind);
        set(gca, 'fontsize', 16);
        semilogy(norms{x0ind,1}, 'r^', 'markersize', 8, 'linewidth', 2);
        titlestr = sprintf('Algorithm: Gauss-Newton, x_0=(%.02f, %.02f)', ...
                           x0(1), x0(2));
        title(titlestr);
        xlabel('Iteration no.'); ylabel('Norm of gradient'); 
        saveeps([filenametmpl, '.eps']);

        % Plot and save contour plot with iteration path
        plot_rosenbrock_convergence(X, titlestr);
        saveeps([filenametmpl, '-contour.eps']);
    end
end
