random.walk = function () {return(ts(cumsum(rnorm(3000))))}

vals = list()
acfs = list()
for (chr in sapply(1:6, as.character)) {
    vals[[chr]] = random.walk()
    acfs[[chr]] = acf(vals[[chr]], plot=FALSE)
}
diffed.series = lapply(vals, diff)

minmaxfns = function(f, lst) {f(unlist(lapply(lst, f)))}

get.limits = function (series.list) {
    return(lapply(list(min, max), minmaxfns, series.list))
}

plotfns.factory = function (series.list) {
    return(function (x, y, col=1) {
        plot(x, y, col=col, ylim=unlist(get.limits(series.list)), type="l")
    });
}

plot.timeseries = function (series.list, ind=1:3000) {
    for (k in names(series.list)) {
        fns = if (as.numeric(k) == 1) plotfns.factory(series.list) else lines
        fns(ind, series.list[[k]][ind], col=i)
    }
}
