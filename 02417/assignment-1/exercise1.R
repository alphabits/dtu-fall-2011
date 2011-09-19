data <- read.csv("fuel.csv", sep=",")

time <- data[,3]
fpi <- data[,4]

pdf('time-fpi-plot.pdf')
plot(time, fpi)
dev.off()
