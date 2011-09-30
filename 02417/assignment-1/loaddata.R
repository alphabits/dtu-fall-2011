d <- read.csv('fuel.csv')
rtime <- d[,3]
fpi <- d[,4]
N <- length(fpi)
pred.time <- seq(2005+1/12, 2005.5, length.out=6)

cex <- 0.7
col.normal <- "darkgray"
cex.pred <- 0.7
col.pred <- "black"
pch <- 20
