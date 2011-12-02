polar.to.cartesian = function(r, theta) {
    x = r*cos(theta)
    y = r*sin(theta)
    return(list(x=x, y=y))
}

display.confidence.interval = function(r.min, r.max, theta.min, theta.max, ...) {
    rs = seq(r.min, r.max, length.out=30)
    thetas = seq(theta.min, theta.max, length.out=400)
    polygon.sides = list(
        list(rs, theta.min),
        list(r.max, thetas),
        list(rev(rs), theta.max),
        list(r.min, rev(thetas))
    )
    x = c()
    y = c()

    for (side in polygon.sides) {
        tmp = polar.to.cartesian(side[[1]], side[[2]])
        x = c(x, tmp$x)
        y = c(y, tmp$y)
    }

    polygon(x, y, border=NA, col="#FF000033", ...)
}

plot.data = function(dat.x, dat.y, plot.lim, ...) {
    plot(dat.x, dat.y, xlim=plot.lim, ylim=plot.lim, xlab="x", ylab="y", 
         cex.main=1.4, cex.lab=1.4, cex.axis=1.4, ...)
}

plot.predictions = function(dat.x, dat.y, pred.x, pred.y, ...) {
    plot.lim = c(-10000,42000)
    plot.data(dat.x, dat.y, plot.lim, ...)
    points(pred.x, pred.y, pch=20, col="red")
}

plot.reconstruction = function(recon.x, recon.y) {
    points(recon.coords$x, recon.coords$y, pch=20, cex=0.7)
    lines(recon.coords$x, recon.coords$y)
}

add.legend = function(show.prediction=TRUE, show.conf.interval=FALSE) {
    texts = c("Observations", "Reconstruction")
    pchs = c(21, 20)
    cols = c("black", "black")
    ltys = c(0, 1)
    cex = c(1, 1)
    if (show.prediction) {
        texts = c(texts, "Prediction")
        pchs = c(pchs, 20)
        cols = c(cols, "red")
        ltys = c(ltys, 0)
        cex = c(cex, 1)
    }
    if (show.conf.interval) {
        texts = c(texts, "95% Conf. Int.")
        pchs = c(pchs, 15)
        cols = c(cols, "#FF000033")
        ltys = c(ltys, 0)
        cex = c(cex, 1.5)
    }
    legend("bottomleft", texts, pch=pchs, col=cols, lty=ltys, pt.cex=cex)
}
