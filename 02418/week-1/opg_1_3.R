agehalf <- log10(c(46, 48, 49, 50, 51, 
        57, 59, 60, 61, 62))
timehalf <- log10(c(85.62, 84.9, 87.88, 87.88, 87.57, 
        90.25, 88.40, 89.45, 96.38, 94.62))
modelhalf <- lm(timehalf~agehalf)

agefull <- log10(c(46.5, 47, 47.5, 49.5, 50.5, 
                 54.5, 56.0, 58.5, 59.5, 60.0))
timefull <- log10(c(166.87, 173.25, 175.17, 178.97, 176.63,
                  175.03, 180.32, 183.02, 192.33, 191.73))
modelfull <- lm(timefull~agefull)

sink('opg_1_3.out')
summary(modelfull)
