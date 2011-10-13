generate.sample = function (a, b, x0, M, N) {
    res <- c(x0, rep(0, times=N-1))
    for (i in 2:N) {
        res[i] <- (a*res[i-1] + b) %% M
    }
    return(res/M)
}

a = 16807
b = 0
seed = 10292
M = 2147483647
N = 1000
rnd = generate.sample(a, b, seed, M, N)

hist(rnd, prob=TRUE)
qqplot(rnd, runif(N))
abline(0,1,col=2)
plot(rnd[-1], rnd[-N], pch=".")
plot(rnd[-(1:10)], rnd[-((N-9):N)], pch=".")
