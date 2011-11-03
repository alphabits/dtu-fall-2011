source('loaddata.R')
source('functions.R')

SAVEPLOTS = TRUE

diagnose = function(ts) {
    par(mfrow=c(2,1))
    acf(ts)
    pacf(ts)
}

sign.test = function(res) {
    n = length(res)
    binom.test(sum(1*(res[2:n]*res[1:(n-1)] < 0)), n-1)
}


plot.and.save('trainingset.pdf', 12, 7,
              plot, train.ts, main='Airline passengers', xlab='Time', 
              ylab='Passengers')
plot.and.save('acf-trainingset.pdf', 7, 7,
              acf, train, main='ACF for the time series')
plot.and.save('pacf-trainingset.pdf', 7, 7,
              pacf, train, main='ACF for the time series')


train.ts.d = diff(train.ts)
plot(train.ts.d)
diagnose(train.ts.d)


train.ts.d2 = diff(train.ts.d, 12)
plot(train.ts.d2)
diagnose(train.ts.d2)


m1 = arima(train.ts, order=c(1,1,1), 
           seasonal=list(order=c(0,1,1), period=12), 
           method="ML")
m1.r = residuals(m1)
pred = predict(m1, n.ahead=9)
m1.p = pred$pred
m1.p.se = pred$se
plot(residuals(m1), type="p")
qqnorm(m1$residuals)
lines((-4):4,((-4):4)*sqrt(m1$sigma2), type="l", lwd=3, col='red')
sign.test(m1.r)
hist(m1.r, probability=T, col='blue')
acf(m1.r)
pacf(m1.r)
plot(1:9, m1.p, type="l", ylim=c(35000, 65000))
lines(1:9, test, type="l", col="red")
lines(1:9, m1.p+m1.p.se*2, lty=2)
lines(1:9, m1.p-m1.p.se*2, lty=2)
# The Ljung-Box test is a refinement of the Box-Pierce test
# that is described under the heading "Portmanteau lack-of-fit test"
# on page 175 in course text book. See also:
# http://en.wikipedia.org/wiki/Ljung-Box_test 
tsdiag(m1)





m1.log = arima(train.log.d, order=c(2,0,0), include.mean=T, method="ML")
plot(residuals(m1.log))
qqnorm(residuals(m1.log))
m1.log.pred = predict(m1.log, 9)
plot(m1.log.pred$pred, type="l")
plot(log(test))


m2 = arima(train, order=c(0,0,0), seasonal=list(order=c(0,1,1), period=12), 
           include.mean=T, method="ML")
m2.r = residuals(m2)
m2.p = predict(m2, n.ahead=9)$pred
plot(m2.r)
par(mfrow=c(2,3))
qqnorm(m2.r)
lines((-4):4,((-4):4)*sqrt(m2$sigma2), type="l", lwd=3, col='red')
hist(m2.r, probability=T, col='blue')
plot(1:9, m2.p, type="l", ylim=c(30000,70000))
lines(1:9, test, type="l", col="red")
sign.test(m2.r)
acf(m2.r)
pacf(m2.r)



plot(dat.ts)



