load_ex1;

for n=1:2:15
    [xstar, rstar] = NOfit(d(:,1), d(:,2), n);
    z = run_score(rstar);
    [rho, Trho] = correlation_score(rstar);
    if z < 1.96 && abs(rho)<Trho
        print 'n found';
        break
    end
end

