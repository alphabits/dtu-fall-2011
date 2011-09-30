y <- c(92, 92, 91.25, 85.62, 84.9, 87.88, 87.88, 87.57, 
       90.25, 88.4, 89.45, 96.38, 94.62, 91.23)
mu <- rep(1, times=14)
age <- c(42:44,46,48:51,57,59:63)
club <- c(rep(0, times=3), rep(1, times=11))
age.club <- c(rep(0, times=3), age[4:14])
z <- age.club

X <- cbind(mu, age, club)

R <- diag(length(mu)) - X%*%solve(t(X)%*%X)%*%t(X)

zry <- z%*%R%*%y
new.coeff <- solve(z%*%R%*%z)%*%zry
ss.new <- new.coeff*zry
