x <- 1:10
xsq = x^2
y <- c(140.3, 143.1, 147.4, 151.4, 144.3, 
       151.2, 152.9, 156.9, 155.7, 157.7)
model <- lm(y~x)
model2 <- lm(y~x+xsq)

m <- function (x) {
    return(sum(model$coefficients*c(1, x)))
}

m2 <- function (x) {
    return(sum(model2$coefficients*c(1, x, x^2)))
}

