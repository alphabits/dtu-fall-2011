
polar.to.cartesian = function(r, theta) {
    x = r*cos(theta)
    y = r*sin(theta)
    return(list(x=x, y=y))
}

display.confidence.interval = function(r.min, r.max, theta.min, theta.max, ...) {
    rs = seq(r.min, r.max, length.out=30)
    thetas = seq(theta.min, theta.max, length.out=400)
    inputs = list(
        list(rs, theta.min),
        list(r.max, thetas),
        list(rev(rs), theta.max),
        list(r.min, rev(thetas))
    )
    x = c()
    y = c()

    for (input in inputs) {
        tmp = polar.to.cartesian(input[[1]], input[[2]])
        x = c(x, tmp$x)
        y = c(y, tmp$y)
    }

    polygon(x, y, ...)
}

plot.predictions = function(dat.x, dat.y, pred.x, pred.y, ...) {
    plot.lim = c(-10000,42000)
    plot(dat.x, dat.y, xlim=plot.lim, ylim=plot.lim, xlab="x", ylab="y", 
         cex.main=1.4, cex.lab=1.4, cex.axis=1.4, ...)
    points(pred.x, pred.y, pch=20, col="red")
}
