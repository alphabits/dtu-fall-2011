% Define starting points
x0s = [ -1.2  1.2; 
         1    1.2 ];
numx0 = size(x0s, 2);

% Define algorithms to test
algorithms = {'steepest-descent', 'newton', 'quasi-newton'};
numalgos = length(algorithms);

% Init options for linesearch function
o = struct();
o.tol = 1e-10;

% Init data structures to hold the results
xmins = cell(numx0, numalgos);
norms = cell(numx0, numalgos);
xs = cell(numx0, numalgos);

% Iterate all combinations of starting point and algorithm
for x0ind = 1:numx0
    x0 = x0s(:, x0ind);
    for algoind = 1:numalgos
        o.algorithm = algorithms{algoind};
        [xmin, X, F, DF] = linesearch(@rosenbrock, x0s(:,x0ind), o);
        xmins{x0ind, algoind} = xmin;
        xs{x0ind, algoind} = X;
        % Calculate gradient norms
        norms{x0ind, algoind} = sqrt(DF(1,:).^2 + DF(2,:).^2);
    end
end
