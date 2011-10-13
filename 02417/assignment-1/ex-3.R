source('loaddata.R')

model <- lm(fpi ~ rtime)
pdf('fitted-linear-model.pdf')
plot(rtime, fpi, pch=pch, cex=cex, xlab="Year", col="gray", 
     ylab="FPI", main="First order linear model")
lines(rtime, fitted(model), lwd=3)
dev.off()
model.residuals <- resid(model)
pdf('fitted-linear-model-residuals.pdf')
plot(rtime, model.residuals, pch=pch, cex=cex,
     xlab="Year", 
     ylab="Residuals", 
     main="Residuals of first order linear model")
dev.off()

sink('fitted-linear-model-summary.txt')
summary(model)
sink()
