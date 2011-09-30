source('loaddata.R')

sink('ex-2.out')
summary(fpi)
sprintf('SD: %s', sd(fpi))
sink()
