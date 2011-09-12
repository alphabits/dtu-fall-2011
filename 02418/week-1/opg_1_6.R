age <- c(42, 43, 44, 46, 48, 49, 50, 51,
         57, 59, 60, 61, 62, 63)
agesq <- age^2
times <- c(92, 92, 91.25, 85.62, 84.9, 87.88, 87.88,
           87.57, 90.25, 88.4, 89.45, 96.38, 94.62, 91.23)

linmodel <- lm(times~age)
polymodel <- lm(times~age+agesq)

sink('opg_1_6.out')

summary(linmodel)
print('----')
summary(polymodel)
