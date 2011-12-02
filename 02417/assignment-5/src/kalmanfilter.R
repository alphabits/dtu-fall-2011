kalman.filter = function(A, B, C, u, S.1, S.2, mu0, V0, Y) {

    # Find the right dimensions
    num.observations = dim(Y)[1]
    observation.dim = dim(Y)[2]
    state.dim = dim(S.1)[1]

    # Init history variables
    X.hat.now.history = matrix(0, nrow=num.observations, ncol=state.dim)
    K.t.history = array(0, dim=c(state.dim, observation.dim, num.observations))

    # Initialize Kalman filter
    X.hat.step = mu0
    S.xx.step = V0
    S.yy.step = S.2

    # Run Kalman filter
    for (i in 1:num.observations) {
        Y.t = matrix(Y[i,])

        # Update Kalman gain
        K.t = S.xx.step %*% t(C) %*% solve(S.yy.step)

        # Reconstruction
        X.hat.now = X.hat.step + K.t %*% (Y.t - C %*% X.hat.step)
        S.xx.now = S.xx.step - K.t %*% C %*% S.xx.step
        
        # Prediction
        X.hat.step = A %*% X.hat.now + B %*% u
        S.xx.step = A %*% S.xx.now %*% t(A) + S.1
        S.yy.step = C %*% S.xx.step %*% t(C) + S.2

        # Save iteration history
        X.hat.now.history[i,] = X.hat.now
        K.t.history[,,i] = K.t
    }

    # Return information about the iterations
    return(list(X.hat.now.history=X.hat.now.history, S.xx.step=S.xx.step,
                K.t.history=K.t.history, X.hat.step=X.hat.step))

}
