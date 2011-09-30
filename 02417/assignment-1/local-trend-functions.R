L.inv <- matrix(c(1,-1,0,1), nrow=2)

f <- function (j) {
    return(matrix(c(1, j), nrow=2))
}

calc.FN <- function (y, lambda) {
    N <- length(y)
    FN <- matrix(rep(0, times=4), nrow=2)
    for (j in (N-1):0) {
        FN  <- FN + lambda^j*f(-j)%*%t(f(-j))
    }
    return(FN)
}

calc.hN <- function (y, lambda) {
    N <- length(y)
    hN <- matrix(rep(0, times=2), nrow=2)
    for (j in (N-1):0) {
        hN <- hN + lambda^j*f(-j)*y[N-j]
    }
    return(hN)
}

calc.thetahat <- function (FN, hN) {
    return(solve(FN)%*%hN)
}

calc.sigmahat <- function (y, lambda, thetahat, adjust.df=FALSE) {
    N <- length(y)
    adjusted.N <- sum(as.numeric(lambda^(0:(N-1)) > 1e-6))
    deg.freedoms <- ifelse(adjust.df, adjusted.N, N) - 2

    calc.sigmahat.j <- function (j) {
        return(lambda^j * (y[N-j] - t(f(-j))%*%thetahat)^2)
    }
    return(sum(sapply(0:(N-1), calc.sigmahat.j))/deg.freedoms)
}

calc.prediction.variance <- function (l, sigmahat, FN.inv) {
    sigmahat*(1 + t(f(l))%*%FN.inv%*%f(l))
}

one.step.predict.sum <- function (lambda, y) {
    FN <- calc.FN(y[1:2], lambda)
    hN <- calc.hN(y[1:2], lambda)
    errs <- 0
    for (j in 2:(N-1)) {
        thetahat <- calc.thetahat(FN, hN)
        prediction <- sum(thetahat)
        errs <- errs + (y[j+1] - prediction)^2

        FN <- update.F(FN, j, lambda)
        hN <- update.h(hN, y[j], lambda)
    }
    return(errs)
}

update.F <- function (F.old, N, lambda) {
    return(F.old + lambda^N*f(-N)%*%t(f(-N)))
}

update.h <- function (h.old, y.new, lambda) {
    lambda*L.inv%*%h.old + y.new*f(0)
}
