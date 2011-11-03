k = c(-0.4, 0.19, 0.01, -0.07, -0.07, -0.15, 0.05, 0.00, 
      -0.10, 0.05, 0.18, -0.05, 0.09, 0.18, 0.01)
ind = seq(1, length(k), length.out=100)

band = 2/sqrt(70)

plot(k, ylimit=c(-0.4, 0.4))
lines(ind, rep(band, 100))
lines(ind, rep(-band, 100))
