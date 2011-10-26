# Include dependencies
source('loaddata.R')
source('functions.R')

# Should the plots be saved. Used by save.and.plot function
SAVEPLOTS = TRUE

attach(dat)

## Plotting the heat consumptions for all houses
png('../plots/Q-house-grid.png', 1600, 1000)
par(mfrow=c(4,4),mgp=c(2,0.7,0),mar=c(2,2,1,1))
for (i in levels(dat$houseId)){ 
    plot(Q~t, dat[dat$houseId==i,], xlim=c(17857,18520), ylim=c(0,8), cex=0.1)
    legend("topright", legend=i)
}
dev.off()

plot.and.save('../plots/Q-h05.pdf', 12, 7,
          plot, Q~t, datH05, xlim=c(17857,18520), ylim=c(0,8), cex=0.8, 
          pch=20, cex.axis=1.8, cex.lab=1.8, 
          main='Heat consumption for house 5')


detach("dat")
