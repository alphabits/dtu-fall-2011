spxibm <- read.csv('spx_ibm.txt', sep="\t")
spxret <- spxibm[,'spx']
ibmret <- spxibm[,'ibm']

N <- 1000
spx.boot.sum <- numeric(N)
for (i in 1:N) {
    this.samp <- sample(spxret, 251, replace=TRUE)
    spx.boot.sum[i] <- sum(this.samp)
}
hist(spx.boot.sum, col='yellow')
abline(v=sum(spxret), col='blue')
