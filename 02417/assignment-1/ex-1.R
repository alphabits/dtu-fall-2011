source('loaddata.R')

pdf('data-plot.pdf')
plot(rtime, fpi, xlab='Year', ylab='FPI', cex=cex, pch=pch, 
     main="Data plot")
dev.off()
