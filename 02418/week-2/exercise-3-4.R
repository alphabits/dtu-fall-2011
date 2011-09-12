path <- "/home/anders/dtu/E11/02418/campusnet/R scripts/tab33.txt"

# Read data from file
data <- read.csv(path, sep=" ")

X <- data[,2]
Y <- data[,1]
Z <- data[,3]
Zsq <- Z^2

model <- lm(Y~X+Z+Zsq)

sink('exercise-3-4.out')
summary(model)
sink()
