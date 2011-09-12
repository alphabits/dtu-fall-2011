tt <- 1:8
w <- log10(c(4.4, 3.4, 3.3, 2.5, 7.3, 4.9, 4.8, 4.4))
i <- c(rep(0, times=4), rep(1, times=4))
X <- cbind(rep(1, times=8), tt, i)
plot(tt, w)

