source('loaddata.R')


n = length(dat[,1])

# Setup model matrices
A.dat = c(1,0,0,
          0,1,1,
          0,0,1)
A = matrix(A.dat, nrow=3, ncol=3, byrow=TRUE)
C.dat = c(1,0,0,
          0,1,0)
C = matrix(C.dat, nrow=2, ncol=3, byrow=TRUE)

# Init error covariance matrices
S.1 = diag(c(500^2, 0.005^2, 0.005^2))
S.2 = diag(c(2000^2, 0.03^2))

# Init history variables
X.hat.now.history = matrix(0, nrow=n-1, ncol=3)
K.t.history = array(0, dim=c(3,2,n-1))

# Initialize Kalman filter
X.hat.step = matrix(c(r.m[1], theta.m[1], 0))
S.xx.step = diag(c(0,0,0))
S.yy.step = S.2

# Run Kalman filter
for (i in 2:n) {
    Y.t = matrix(c(r.m[i], theta.m[i]))

    # Update Kalman gain
    K.t = S.xx.step %*% t(C) %*% solve(S.yy.step)

    # Reconstruction
    X.hat.now = X.hat.step + K.t %*% (Y.t - C %*% X.hat.step)
    S.xx.now = S.xx.step - K.t %*% C %*% S.xx.step
    
    # Prediction
    X.hat.step = A %*% X.hat.now
    S.xx.step = A %*% S.xx.now %*% t(A) + S.1
    S.yy.step = C %*% S.xx.step %*% t(C) + S.2

    # Save iteration history
    X.hat.now.history[i-1,] = X.hat.now
    K.t.history[,,i-1] = K.t
}
