path <- "/home/anders/dtu/E11/02418/week-2/table-4-2.txt"

# Read data from file
data <- read.csv(path, sep=" ")

Y <- data[,2]
X <- data[,1]
Xsq <- X^2

model <- lm(Y~X+Xsq)

sink('exercise-4-1.out')
summary(model)
sink()
