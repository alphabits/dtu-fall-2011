# Loads the textxy function
library('calibrate')
library('date')


my.acf = function(x, ...) {acf(x, lag.max=100, ...)}
my.pacf = function(x, ...) {pacf(x, lag.max=100, ...)}

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

my.ts.plot = function(x, y, ...) {
    plot(x, y, xaxt='n', cex.axis=1.4, cex.lab=1.4, cex.main=1.4, type="l", ...)
    days = seq(13080, 13180, 20)
    axis(1, days, as.character(as.date(days)), cex.axis=1.4, cex.lab=1.4)
}

get.datetime = function(date.string) {
    return(strptime(date.string, "%m/%d/%Y %H"))
}

get.date.from.row = function(data.row) {
    dateobj = as.date(data.row[["ds.jdate"]])
    return(as.Date(date.mmddyyyy(dateobj), format="%m/%d/%Y"))
}

get.datetime.from.row = function(data.row) {
    dateobj = as.date(data.row[["ds.jdate"]])
    string = sprintf('%s %d', date.mmddyyyy(dateobj), data.row[["hh"]])
    return(get.datetime(string))
}
