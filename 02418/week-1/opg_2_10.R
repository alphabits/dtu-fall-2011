loc1 <- c(15, 19, 22,
          20, 24, 18,
          22, 17, 14)
loc2 <- c(17, 10, 13,
          24, 18, 22,
          26, 19, 21)
loc3 <- c(9, 12, 6,
          12, 15, 10,
          10, 5, 8)
loc4 <- c(14, 8, 11,
          21, 16, 14,
          19, 15, 12)
yield <- c(loc1, loc2, loc3, loc4)

location <- rep(c('L1', 'L2', 'L3', 'L4'), each=9)
variety <- rep(rep(c('A', 'B', 'C'), each=3), times=4)

sink('opg_2_10.out')
model <- aov(yield~location*variety)
summary(model)

model2 <- aov(yield~location+variety)
summary(model2)

sink()
