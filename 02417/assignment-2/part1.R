phi.1 = seq(-2, 2, length.out=200)

const = rep(1, times=200)
quad = phi.1^2/4
linear = abs(phi.1) - 1

plot(phi.1, const, xlim=c(-3,3), ylim=c(-1.5, 1.5), type="l", lty=2)
polygon(c(phi.1, rev(phi.1)), c(quad, const), col="gray")
lines(phi.1, quad, lty=2)
lines(phi.1, linear, lty=2)
