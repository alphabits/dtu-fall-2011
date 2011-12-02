source('loaddata.R')
source('functions.R')


pdf('../plots/data.pdf', 7, 7)
plot.data(dat.x, dat.y, c(0, 42000), main="Plot of data in xy-plane", show.legend=FALSE)
dev.off()
