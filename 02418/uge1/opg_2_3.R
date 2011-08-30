f1 <- c(164, 172, 168, 177, 156, 195)
f2 <- c(178, 191, 197, 182, 185, 177)
f3 <- c(175, 193, 178, 171, 163, 176)
f4 <- c(155, 166, 149, 164, 170, 168)
f <- c(f1, f2, f3, f4)

fattype <- rep(c('F1', 'F2', 'F3', 'F4'), each=6)
fattype <- as.factor(fattype)

model <- lm(f~fattype)
# Run anova
