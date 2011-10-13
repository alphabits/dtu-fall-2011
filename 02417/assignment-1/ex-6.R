source('loaddata.R')
source('local-trend-functions.R')

lambdas <- seq(0.01, 0.8, 0.01)
res <- sapply(lambdas, one.step.predict.sum, y=fpi)
min.index <- which.min(res)

pdf('prediction-error.pdf')
plot(lambdas, res, xlab=expression(lambda), ylab="One step prediction error",
     main=expression(paste("One step prediction error as function of ", lambda)))
points(lambdas[min.index], res[min.index], pch=20)
legend("topleft", inset=.05, pch=20, expression(paste("Minimum (", lambda==0.37, ")")))
dev.off()
