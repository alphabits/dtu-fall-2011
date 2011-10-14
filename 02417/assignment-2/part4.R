zs = function (num) {
    return(rep(0, times=num))
}

model = function(a1, b1) {return(c(a1, zs(10), b1, a1*b1))}

models = list(
    list(ar=-c(0.9)),
    list(ar=-c(zs(11), 0.7)),
    list(ar=-c(0.9), ma=c(zs(11), 0.4)),
    list(ar=-model(0.9, 0.7)),
    list(ma=model(0.4, 0.3)),
    list(ar=-c(zs(11), 0.4), ma=c(0.7))
);

model.descriptions = list(
    "(1,0,0)x(0,0,0) s=12",
    "(0,0,0)x(1,0,0) s=12",
    "(1,0,0)x(0,0,1) s=12",
    "(1,0,0)x(1,0,0) s=12",
    "(0,0,1)x(0,0,1) s=12",
    "(0,0,1)x(1,0,0) s=12"
)

plot.models = function(ind) {
    par(mfcol=c(2,3))
    for (i in ind) {
        series = arima.sim(250, model=models[[i]])
        main = paste(model.descriptions[i], "seasonal model")
        plot(series, main=main, ylab="Y")
        acf(series, main=paste("ACF for", main))
    }
}

save.plots = function(ind) {
    num = min(ind[1], 2)
    filename = sprintf("seasonalmodels-%s.pdf", num)
    pdf(filename, 12, 7)
    plot.models(ind)
    dev.off()
}
