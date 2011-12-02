source('runkalman.R')


pdf('../plots/reconstruction.pdf', 7, 7)
plot.data(recon.coords$x, recon.coords$y, plot.lim=c(0,42000), type="l",
          main="Reconstructed trajectory in the xy-plane")
points(recon.coords$x, recon.coords$y, pch=20, cex=0.7)
points(dat.x, dat.y)
add.legend(show.prediction=FALSE, show.conf.interval=FALSE)
dev.off()

