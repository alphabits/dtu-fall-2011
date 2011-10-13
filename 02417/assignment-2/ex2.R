y = c(-3, 0, 4, 4, 1, -3, -2, -1, 1, 2)
w = c(1.8, -0.8, 0, 0, 0, 0.2, -0.36, 0.16, 0, 0)
sigma.hat = 0.31

for (k in 1:2) {
    y = c(sum(w*y), y)
    w = c(w, 0)
}

error.variance = (1+w[1]^2)*sigma.hat
conf.step = qnorm(0.975)*sqrt(error.variance)

