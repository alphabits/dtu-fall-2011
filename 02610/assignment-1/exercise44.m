function [xs, norms] = exercise44()
    % Define starting points
    x0s = [ -1.2  1.2; 
             1    1.2 ];
    numx0 = size(x0s, 2);
    % Define algorithms to test
    algorithms = {'quasi-newton', 'steepest-decent'};
    numalgos = length(algorithms);

    % Create data structures for the results
    norms = cell(numx0, numalgos);
    xs = cell(numx0, numalgos);

    % Used to get iteration results out of fminunc
    function stop = outfun(x, optim, state)
        if strcmp(state, 'iter')
            X = [X x];
            DF = [DF optim.gradient];
        end
        stop = false;
    end

    % When largescale is off a quasi-newton algorithm is run.
    % Setting HessUpdate to steepdesc gives the steepest descent algo.
    % See http://www.mathworks.se/help/toolbox/optim/ug/fminunc.html 
    o = {};
    o{1} = optimset('gradobj', 'on', 'largescale', 'off', 'maxiter', 1000, ...
                    'outputfcn', @outfun, 'maxfuneval', 3000, ...
                    'initialhesstype', 'identity');
    o{2} = optimset(o{1}, 'hessupdate', 'steepdesc');

    % Iterate all combinations of starting points and algorithms
    for x0ind = 1:numx0
        x0 = x0s(:, x0ind);
        for algoind = 1:numalgos
            X = []; DF = [];
            fminunc(@rosenbrock, x0s(:,x0ind), o{algoind});
            xs{x0ind, algoind} = X;
            norms{x0ind, algoind} = sqrt(DF(1,:).^2 + DF(2,:).^2);
        end
    end
end
