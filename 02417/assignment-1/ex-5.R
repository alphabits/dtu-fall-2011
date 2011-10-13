source('loaddata.R')
source('local-trend-functions.R')

library(xtable)

lambda <- 0.37
lambda.filename <- strsplit(as.character(lambda), "\\.")[[1]][2]

FN <- calc.FN(fpi, lambda)
hN <- calc.hN(fpi, lambda)
thetahat <- calc.thetahat(FN, hN)
preds <- cbind(rep(1, times=6), 1:6)%*%thetahat
ind <- rtime > 2001

for (type in c("normal", "adjusted")) {
    adjust <- (type=="adjusted")
    extra.plot.title <- ifelse(adjust, "\n(Variance estimate adjusted)", "")
    sigmahat <- calc.sigmahat(fpi, lambda, thetahat, adjust.df=adjust)
    variance <- sapply(1:6, calc.prediction.variance, sigmahat=sigmahat, 
                       FN.inv=solve(FN))
    conf.interval <- qt(0.95, N-2)*sqrt(variance)

    pdf(sprintf("local-trend-predict-%s-%s.pdf", type, lambda.filename))
    plot(c(rtime[ind], pred.time), c(fpi[ind], preds), pch=pch, cex=cex, 
         col=col.normal, ylim=c(120,155), ylab="FPI", xlab="Year", 
         main=sprintf("Local trend model predictions%s", extra.plot.title))
    points(pred.time, preds, pch=pch, cex=cex.pred, col=col.pred)
    lines(pred.time, preds+conf.interval, lty=2)
    lines(pred.time, preds-conf.interval, lty=2)
    legend("topleft", expression(lambda==0.37), inset=0.05)
    dev.off()

    if (adjust) {
        sink('result-table.tex')
        dates <- as.Date(sapply(1:6, function(x)paste("2005-0",x,"-01", sep="")))
        dates <- format(dates, format="%B 2005")
        interval <- sapply(1:6, function(i)sprintf("[%.02f, %.02f]", 
                                                   preds[i]-conf.interval[i], 
                                                   preds[i]+conf.interval[i]))
        table.data <- data.frame(predictions=preds, uncertainty=conf.interval, 
                                 interval=interval, row.names=dates)
        print(xtable(table.data))
        sink()
    }
}


