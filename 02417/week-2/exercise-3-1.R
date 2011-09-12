x <- c(4.0, 4.0, 3.5, 4.0, 2.0, 2.5, 1.5)
y <- c(1.0, 0.5, 2.0, 2.0, 3.5, 3.0, 4.0)
tt <- 1:7

TT <- cbind(rep(1, length(tt)), tt)
X = cbind(rep(1, length(x)), x)

plot(x, y)

calc.thetahat <- function (X, y) {
    return(solve(t(X)%*%X)%*%t(X)%*%y)
}
calc.err <- function (X, y) {
    thetahat <- calc.thetahat(X, y)
    return(y-X%*%thetahat)
}
calc.sigmahatsq <- function (err, degf) {
    return(t(err)%*%(err)/degf)
}
calc.variance.prediction <- function (xp, X, sigmahatsq) {
    return(sigmahatsq*(1+t(xp)%*%solve(t(X)%*%X)%*%xp))
}

calc.prediction <- function (xp, X, y) {
    thetahat <- calc.thetahat(X, y)

    err <- calc.err(X, y)
    sigmahatsq <- calc.sigmahatsq(err, length(X[,1])-length(xp))

    variance.prediction <- calc.variance.prediction(xp, X, sigmahatsq)
    prediction <- xp%*%thetahat
    prediction.error <- qt(0.95, 5)*sqrt(variance.prediction)

    res <- sprintf('Confidence interval: %s +- %s', prediction, prediction.error)
    return(res)
}

thetahat <- calc.thetahat(X, y)

err <- calc.err(X, y)
sigmahatsq <- calc.sigmahatsq(err, 5)

xp <- c(1, 0.5)
variance.prediction <- calc.variance.prediction(xp, X, sigmahatsq)
prediction <- xp%*%thetahat
prediction.error <- qt(0.95, 5)*sqrt(variance.prediction)

res <- sprintf('Confidence interval: %s +- %s', prediction, prediction.error)


thetahat2 <- calc.thetahat(TT, y)
err2 <- calc.err(TT, y)
sigmahatsq2 <- calc.sigmahatsq(err2, 5)
tp <- c(1, 8)
variance.prediction.2 <- calc.variance.prediction(tp, TT, sigmahatsq2)
prediction2 <- tp%*%thetahat2
prediction.error.2 <- qt(0.95, 5)*sqrt(variance.prediction.2)
res2 <- sprintf('Confidence interval: %s +- %s', prediction2, prediction.error.2)
