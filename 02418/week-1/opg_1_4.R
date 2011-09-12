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

sink('opg_1_4.out')
summary(model)
summary(model2)

print('--------------------------------')
print('Predict for x=-3 and x=13 and compare with the real values')
print('135.9 and 158.6')

fmt = 'Model %s prediction of x=%s: %s'

for (x in c(-3, 13)) {
    print(sprintf(fmt, 1, x, m(x)))
    print(sprintf(fmt, 2, x, m2(x)))
}
