# Loads the textxy function
library('calibrate')
library('date')


my.acf = function(x, ...) {acf(x, lag.max=100, ...)}
my.pacf = function(x, ...) {pacf(x, lag.max=100, ...)}
my.acfs = function(x, ...) {
    par(mfrow=c(1,2))
    my.acf(x, ...)
    my.pacf(x, ...)
}

plot.and.save = function(filename, width, height, plotfunction, ...) {
    save.the.plot = exists('SAVEPLOTS') && SAVEPLOTS
    if (save.the.plot) {pdf(sprintf('../plots/%s', filename), width, height)}
    plotfunction(cex.axis=1.4, cex.lab=1.4, cex.main=1.4, ...)
    if (save.the.plot) {dev.off()}
}

get.model = function(model.id, model.fun, ...) {
    filename = sprintf('../data/%s.rda', model.id)

    if (!file.exists(filename)) {
        model = model.fun(...)
        save(model, file=filename)
    }
    load(filename)

    return(model)
}

get.string.from.struct = function(struct) {
    return(sprintf('(%d,%d,%d)', struct[1], struct[2], struct[3]))
}

get.model.string = function(model.setup) {
    return(sprintf('%sx%s_24', get.string.from.struct(model.setup[["nonseas"]]), 
                   get.string.from.struct(model.setup[["seas"]])))
}

range.mean.calculate = function(x, bin.size) {
    n = length(x)
    means = c()
    ranges = c()
    cur.group = c()

    for (i in 1:n) {
        cur.group = c(cur.group, x[i])
        if (i %% bin.size == 0) {
            means = c(means, mean(cur.group))
            ranges = c(ranges, max(cur.group)-min(cur.group))
            cur.group = c()
        }
    }

    return(list(means=means, ranges=ranges))
}

range.mean.plot = function(x, bin.size, ...) {
    res = range.mean.calculate(x, bin.size)
    means = res$means
    ranges = res$ranges

    plot(means, ranges, pch=20, xlab='Mean', ylab='Range', ...)
    textxy(means, ranges, 1:length(means), cx=0.75)
}

my.ts.plot.base = function(x, y, days.ticks, ...) {
    days = days.ticks
    plot(x, y, xaxt='n', cex.axis=1.4, cex.lab=1.4, cex.main=1.4, type="l", ...)
    axis(1, days, as.character(as.date(days)), cex.axis=1.4, cex.lab=1.4)
}

my.ts.plot = function(x, y, ...) {
    days = seq(13080, 13180, 20)
    return(my.ts.plot.base(x, y, days, ...))
}

plot.forecast = function(model, ...) {
    predictions = predict(model, n.ahead=length(pred.only.ind))
    pred = predictions$pred
    se = predictions$se
    n = length(day)
    ind = (n-200):n
    first.day = day[ind[1]]
    last.day = day.inc.pred[length(day.inc.pred)]
    my.ts.plot.base(day[ind], as.vector(hc.ts)[ind], c(13185, 13190), xlim=c(first.day, last.day),
                    xlab="Time", ylab="Heat Consumption (GJ/h)", ...)
    lines(day.pred, pred, lwd=2)
    lines(day.pred, pred + 1.96*se, lty=2, lwd=2)
    lines(day.pred, pred - 1.96*se, lty=2, lwd=2)
}

save.prediction.table = function(filename, model, steps.ahead=6) {
    predictions = predict(model, n.ahead=length(pred.only.ind))
    l = c()
    pred = predictions$pred
    err = 1.96*predictions$se
    l = c(l, 'Time ahead & Prediction & Error & Interval \\\\\\hline')
    for (i in 1:steps.ahead) {
        app = if (i!=steps.ahead) "\\\\" else ""
        l = c(l, sprintf('%d & %.02f & %.02f & [%.02f; %.02f]%s', i, pred[i],
                      err[i], pred[i]-err[i], pred[i]+err[i], app))
    }
    f = file(sprintf('../tables/%s', filename))
    writeLines(l, f)
    close(f)
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

qq = function(model, ...) {
    plot.qq.res(residuals(model), model$sigma2, ...)
}

plot.qq.res = function(res, sigma, ...) {
    qqnorm(res, ...)
    lines((-4):4,((-4):4)*sqrt(sigma), type="l", lwd=3, col='red')
}

save.model.summary = function(model, filename) {
    sink(sprintf('../tables/%s', filename))
    print(model)
    sink()
}

