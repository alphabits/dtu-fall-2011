source('kalman.R')
source('functions.R')


k = 6

# Setup variables with first prediction
X.hat.pred = matrix(0, k, 3)
X.hat.pred[1,] = X.hat.step
S.xx.pred = array(0, dim=c(3, 3, k))
S.xx.pred[,,1] = S.xx.step

# Make predictions
for (i in 2:k) {
    X.hat.pred[i,] = A %*% X.hat.pred[i-1,]
    S.xx.pred[,,i] = A %*% S.xx.pred[,,i-1] %*% t(A) + S.1
}

r.pred = X.hat.pred[,1]
theta.pred = X.hat.pred[,2]
r.pred.err = 1.96*sqrt(S.xx.pred[1,1,])
theta.pred.err = 1.96*sqrt(S.xx.pred[2,2,])

pred.cartesian = polar.to.cartesian(r.pred, theta.pred)
x.pred = pred.cartesian$x
y.pred = pred.cartesian$y

theta.min = theta.pred - theta.pred.err
theta.max = theta.pred + theta.pred.err
r.min = r.pred - r.pred.err
r.max = r.pred + r.pred.err

pdf(sprintf('../plots/all-predictions.pdf', 7, 7))
plot.predictions(dat.x, dat.y, x.pred, y.pred, main="6-step predictions")
dev.off()

for (i in 1:k) {
    pdf(sprintf('../plots/prediction-%d.pdf', i), 7, 7)
    plural = if (i == 1) '' else 's'
    main = sprintf("Prediction %d-step%s ahead", i, plural)
    plot.predictions(dat.x, dat.y, x.pred[i], y.pred[i], main=main)
    display.confidence.interval(r.min[i], r.max[i], theta.min[i], theta.max[i], 
                                border=NA, col="#FF000033")
    dev.off()
}

