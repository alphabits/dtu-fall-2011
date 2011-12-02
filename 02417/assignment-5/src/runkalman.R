source('loaddata.R')
source('kalmanfilter.R')


# Setup model matrices
A.dat = c(1,0,0,
          0,1,1,
          0,0,1)
A = matrix(A.dat, nrow=3, ncol=3, byrow=TRUE)

B = diag(c(0,0,0))

C.dat = c(1,0,0,
          0,1,0)
C = matrix(C.dat, nrow=2, ncol=3, byrow=TRUE)

u = matrix(c(0,0,0))

# Init error covariance matrices
S.1 = diag(c(500^2, 0.005^2, 0.005^2))
S.2 = diag(c(2000^2, 0.03^2))

# Init intial input
mu0 = matrix(c(dat[1,], 0))
V0 = diag(c(0,0,0))

# Run kalman filter
kalman.results = kalman.filter(A, B, C, u, S.1, S.2, mu0, V0, dat)

# Define shorter variable names
S.xx.step = kalman.results$S.xx.step
X.hat.now.history = kalman.results$X.hat.now.history
X.hat.step = kalman.results$X.hat.step
# Reconstruction coordinates
recon.coords = polar.to.cartesian(X.hat.now.history[,1], X.hat.now.history[,2])
