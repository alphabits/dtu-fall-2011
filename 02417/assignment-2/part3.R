random.walk = function(n=3000, sd=1) {
    ts(cumsum(rnorm(n, mean=0, sd=sd)))
}

series = lapply(rep(3000, 6), random.walk)
diffed.series = lapply(series, diff)

minmaxfns = function(f, lst) {f(unlist(lapply(lst, f)))}

# Finding the minimum and maximum across
# all time series in series.list
get.limits = function(series.list) {
    lapply(list(min, max), minmaxfns, series.list)
}

plotfns.factory = function(series.list) {
    function(x, y, main, col=1) {
        plot(x, y, main=main, col=col, ylim=unlist(get.limits(series.list)), 
             type="l", xlab="Index", ylab="Y")
    };
}

plot.timeseries = function(series.list, main, ind=1:3000) {
    num.series = length(series.list)
    for (i in 1:num.series) {
        fns = if (i == 1) plotfns.factory(series.list) else lines
        fns(ind, series.list[[i]][ind], 
            main=paste(num.series, main), col=i)
    }
}

save.multiple.timeseries = function(series.list, main, filename) {
    pdf(filename)
    plot.timeseries(series.list, main)
    dev.off()
}

save.multiple.random.walks = function() {
    save.multiple.timeseries(series, " Random Walks", "multiple-random-walk.pdf")
}

save.multiple.diffed.random.walks = function() {
    save.multiple.timeseries(diffed.series, " Diffed Random Walks", 
                             "multiple-diffed-random-walk.pdf")
}

plot.single = function(ts, filename, main.ts, main.acf) {
    pdf(filename, 8, 9)
    par(mfrow=c(2,1))
    plot(ts, ylab="Y", main=main.ts)
    acf(ts, main=main.acf)
    dev.off()
}

plot.single.random.walk = function() {
    plot.single(series[[1]], "random-walk.pdf", "Random Walk", 
                "ACF for Random Walk")
}

plot.single.random.walk.diffed = function() {
    plot.single(diffed.series[[1]], "random-walk-diffed.pdf", 
                "Differenced Random Walk", "ACF for Differenced Random Walk")
}
