plot.and.save = function(filename, width, height, plotfunction, ...) {
    save.the.plot = exists('SAVEPLOTS') && SAVEPLOTS
    if (save.the.plot) {pdf(sprintf('../plots/%s', filename), width, height)}
    plotfunction(...)
    if (save.the.plot) {dev.off()}
}

diagnose = function(ts) {
    par(mfrow=c(2,1))
    acf(ts)
    pacf(ts)
}

sign.test = function(res) {
    n = length(res)
    binom.test(sum(1*(res[2:n]*res[1:(n-1)] < 0)), n-1)
}

save.sign.test = function(res, filename) {
    sink(sprintf('../tables/%s', filename))
    print(sign.test(res))
    sink()
}

qq = function(model) {
    plot.qq.res(residuals(model), model$sigma2)
}

plot.qq.res = function(res, sigma) {
    qqnorm(res)
    lines((-4):4,((-4):4)*sqrt(sigma), type="l", lwd=3, col='red')
}

save.model.summary = function(model, filename) {
    sink(sprintf('../tables/%s', filename))
    print(model)
    sink()
}
