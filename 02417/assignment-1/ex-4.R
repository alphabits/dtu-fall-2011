source('loaddata.R')

lambda <- 0.8
N <- length(fpi)
const <- (1-lambda)
last.measure <- fpi[N]

ys <- rep(0, times=N)
ys[1] <- fpi[1]
for (i in 2:N) {
    ys[i] <- const*fpi[i] + lambda*ys[i-1]
}

num.predictions <- 6
preds <- rep(0,times=num.predictions)
preds[1] <- ys[N]
for (i in 2:num.predictions) {
    preds[i] <- const*last.measure + lambda*preds[i-1]
}

ind <- rtime > 2001

pdf(sprintf('exp-smoothing-lambda-%s.pdf', strsplit(as.character(lambda), "\\.")[[1]][2]))
plot(c(rtime[ind], pred.time), c(fpi[ind], preds), pch=pch, cex=cex, col=col.normal,
     main="Prediction using exponential smoothing",
     xlab="Year",
     ylab="FPI")
points(pred.time, preds, pch=pch, cex=cex.pred, col=col.pred)
legend("topleft", expression(lambda==0.8), inset=0.05)
dev.off()
