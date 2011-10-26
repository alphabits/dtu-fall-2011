# Include dependencies
source('loaddata.R')
source('functions.R')
library(xtable)

attach(datH05)

# Fit models
m1 = lm(Q~Ta)
save.diagnostics(m1, 'one-house-m1-%s')

m2 = lm(Q~poly(Ta, 3, raw=TRUE))
save.diagnostics(m2, 'one-house-m2-%s')

m3 = lm(Q~poly(Ta, 3, raw=TRUE)+Ws+G+sunElev)
save.diagnostics(m3, 'one-house-m3-%s')

m4 = step(m3, direction="both")
save.diagnostics(m4, 'one-house-m4-%s')

m5 = lm(Q~poly(Ta, 3, raw=TRUE)+Ws+G+sunElev+Ta:Ws)
save.diagnostics(m5, 'one-house-m5-%s')

# Not used
m6 = step(m5, direction="both")
m7 = lm(Q~poly(Ta, 3, raw=TRUE)+Ta:Ws + Ws)
m8 = lm(Q~Ta*Ws)
