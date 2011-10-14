numpoints = 1500
e = rnorm(numpoints)
ind.to.include = (numpoints-249):numpoints


#############################################
# Make common interface for all simulations #
#############################################

my.filter = function (coeffs) {
    ts(filter(e, filter=coeffs, method="recursive")[ind.to.include])
}

my.arima.sim = function (coeffs) {
    arima.sim(model=list(ar=coeffs), n=250)
}

sim = function (simfns, coeffs) {
    ys = list()
    acfs = list()
    i = 1
    for (cs in coeffs) {
        ys[[i]] = simfns(cs)
        acfs[[i]] = acf(ys[[i]], plot=FALSE)
        i = i + 1
    }
    return(list(ys=ys, acfs=acfs, coeffs=coeffs))
}


###################
# AR(1) processes #
###################

coeffs = list(0.1, -0.1, 0.9, -0.9, 1.01, -1.01)
ar1.res = sim(my.filter, coeffs)


###################
# AR(2) processes #
###################

# Roots: (-1/2, 3/4) and (2/5, 9/10)
coeffs.ar2 = list(c(1/4, 3/8), c(13/10, -9/25))
ar2.res = sim(my.filter, coeffs.ar2)


########################
# AR(2) with arima.sim #
########################

# Roots: (-1/20, 1/10) and (5/6, 5/6)
coeffs.ar2.sim = list(c(1/20, 1/200), c(5/3, 25/36))
ar2.sim.res = sim(my.arima.sim, coeffs.ar2)


##################################################
# Helper functions for creating and saving plots #
##################################################

ar1.filename = "ar1-filter-%s.pdf"
ar2.filename = "ar2-filter-%s.pdf"
ar2.sim.filename = "ar2-sim-%s.pdf"

plot.timeseries = function (series, acfs, coeffs) {
    cols = length(acfs)
    par(mfcol=c(2,cols))
    for (ci in 1:cols) {
        cs = coeffs[[ci]]
        coeff.text = paste("for a1 =", cs[1])
        if (length(cs) == 2) {
            coeff.text = paste(coeff.text, ", a2 =", cs[2])
        }
        plot(series[[ci]], ylab="Y", 
             main=paste("Time series", coeff.text))
        plot(acfs[[ci]], main=paste("ACF", coeff.text))
    }
}

save.plots = function (sim.res, filename) {
    numplots = length(sim.res$ys)
    for (i in 1:ceiling(numplots/2)) {
        s = 2*i - 1
        e = if (s == numplots) s else s+1
        ind = s:e
        pdf(sprintf(filename, i), 12, 7)
        with(sim.res, {
            plot.timeseries(ys[ind], acfs[ind], coeffs[ind])
        })
        dev.off()
    }
}
