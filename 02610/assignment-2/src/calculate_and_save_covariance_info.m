function [cov_theta, err_theta, min_theta, max_theta] = calculate_and_save_covariance_info(theta, sigma, J, name, theta_repr)
    cov_theta = sigma*((J'*J)\eye(length(theta)));
    err_theta = 1.96*sqrt(diag(cov_theta));
    min_theta = theta - err_theta;
    max_theta = theta + err_theta;

    % Save latex representation of the results
    param_template = [theta_repr, ' \\approx \\begin{pmatrix} %0.2f \\\\ %0.2f \\end{pmatrix} \n'];
    saveline(['param-estimates-', name, '.tex'], param_template, theta);
    sigma_template = '\\\\hat{\\\\sigma}^2 \\\\approx %0.3g \n';
    sigma_line = sprintf(sigma_template, sigma);
    sigma_line = strrep(sigma_line, 'e-', 'e\\mbox{-}');
    saveline(['sigma-estimate-', name, '.tex'], sigma_line, []);
    cov_theta_tmpl = ['\\text{Cov}[', theta_repr, '] \\approx '...
                      '\\begin{bmatrix} %0.3g & %0.3g \\\\ %0.3g & %0.3g \\end{bmatrix}'];
    saveline(['covariance-', name, '.tex'], cov_theta_tmpl, cov_theta);
    conf_ints_tmpl = ['\\text{Conf}_{95\\%%}(', theta_repr, '_1) \\approx [%0.3g; %0.3g], ', ...
                      '\\quad \\text{Conf}_{95\\%%}(', theta_repr, '_2) \\approx [%0.3g; %0.3g]'];
    saveline(['confidence-', name, '.tex'], conf_ints_tmpl, ...
             [min_theta(1), max_theta(1), min_theta(2), max_theta(2)]);
end
