source('kalman.R')

dat.coords = polar.to.cartesian(dat[,1], dat[,2])
recon.coords = polar.to.cartesian(X.hat.now.history[,1], X.hat.now.history[,2])

pdf('../plots/reconstruction.pdf', 7, 7)
plot(recon.coords$x, recon.coords$y, type="l", xlim=c(0, 42000), ylim=c(0,42000),
     main="Reconstructed trajectory in the xy-plane", xlab="x", ylab="y", 
     cex.main=1.4, cex.lab=1.4, cex.axis=1.4)
points(recon.coords$x, recon.coords$y, pch=20, cex=0.7)
points(dat.coords$x, dat.coords$y)
dev.off()

