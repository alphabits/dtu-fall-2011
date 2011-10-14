phi.1 = seq(-2, 2, length.out=200)

const = rep(1, times=200)
quad = phi.1^2/4
linear = abs(phi.1) - 1

plot.stationary = function() {
    plot(phi.1, const, xlim=c(-3,3), ylim=c(-1.5, 1.5), type="l", lty=2,
         xlab="Phi 1", ylab="Phi 2", main="Area with stationary AR(2) process")
    polygon(c(phi.1, rev(phi.1)), c(linear, const), col="gray")
    lines(phi.1, linear, lty=2)
}

plot.damping = function() {
    plot(phi.1, const, xlim=c(-3,3), ylim=c(-1.5, 1.5), xlab="Phi 1", 
         ylab="Phi 2", type="l", lty=2, main="Area with damped oscillations for ACF")
    polygon(c(phi.1, rev(phi.1)), c(quad, const), col="gray")
    lines(phi.1, quad, lty=2)
    lines(phi.1, linear, lty=2)
}

save.plot = function(plotfns, filename) {
    pdf(filename)
    plotfns()
    dev.off()
}
