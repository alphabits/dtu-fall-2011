source('functions.R')
source('runkalman.R')


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

# Plot all predictions
pdf(sprintf('../plots/all-predictions.pdf', 7, 7))
plot.predictions(dat.x, dat.y, x.pred, y.pred, main="6-step predictions")
plot.reconstruction(recon.coords$x, recon.coords$y)
add.legend()
dev.off()

# Plot all predictions magnified
pdf(sprintf('../plots/all-predictions-magnified.pdf', 7, 7))
plot(dat.x, dat.y, xlim=c(-6000, 15000), ylim=c(33000, 44000), xlab="x", ylab="y", 
     cex.main=1.4, cex.lab=1.4, cex.axis=1.4, main="6-step predictions close up")
points(x.pred, y.pred, pch=20, col="red")
plot.reconstruction(recon.coords$x, recon.coords$y)
add.legend()
dev.off()

# Plot each prediction with confidence interval
for (i in 1:k) {
    pdf(sprintf('../plots/prediction-%d.pdf', i), 7, 7)
    plural = if (i == 1) '' else 's'
    main = sprintf("Prediction %d time step%s ahead", i, plural)
    plot.predictions(dat.x, dat.y, x.pred[i], y.pred[i], main=main)
    plot.reconstruction(recon.coords$x, recon.coords$y)
    display.confidence.interval(r.min[i], r.max[i], theta.min[i], theta.max[i])
    add.legend(show.conf.interval=TRUE)
    dev.off()
}

# Save predictions and confidence intervals in latex table
r.table.lines = c()
theta.table.lines = c()
line.template = "%d & %.02f & %.02f & [%.02f; %.02f] %s"
for (i in 1:k) {
    delim = if (i==k) '' else '\\\\'
    r.line = sprintf(line.template, i, r.pred[i], r.pred.err[i], r.min[i], 
                     r.max[i], delim) 
    r.table.lines = c(r.table.lines, r.line)
    theta.line = sprintf(line.template, i, theta.pred[i], theta.pred.err[i], 
                         theta.min[i], theta.max[i], delim)
    theta.table.lines = c(theta.table.lines, theta.line)
}

r.table.file = file('../tables/r-predictions.tex')
writeLines(r.table.lines, r.table.file)
close(r.table.file)

theta.table.file = file('../tables/theta-predictions.tex')
writeLines(theta.table.lines, theta.table.file)
close(theta.table.file)
