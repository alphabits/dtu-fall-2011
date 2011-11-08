function score = run_score(seq)
    m = length(seq);
    u = sum(seq(1:(end-1)).*seq(2:end) < 0) + 1;
    nplus = sum(seq>0);
    nminus = sum(seq<=0);
    mu = (2*nplus*nminus)/m + 1;
    sd = sqrt((mu-1)*(mu-2)/(m-1));
    score = abs(u-mu)/sd;
end
