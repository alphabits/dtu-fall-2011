function [rho, Trho] = correlation_score(seq)
    m = length(seq);
    rho = sum(seq(1:(end-1)).*seq(2:end));
    Trho = sum(seq.^2)/sqrt(m-1);
end
