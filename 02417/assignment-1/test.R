source('loaddata.R')

lambda <- 0.2
const <- 1-lambda

pred <- 0
for (j in 0:(N-1)) {
    pred <- pred + lambda^j*fpi[N-j]
}
pred <- pred*const
