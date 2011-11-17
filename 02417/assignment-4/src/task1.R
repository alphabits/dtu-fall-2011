source('loaddata.R')
source('functions.R')
library('forecast')


SAVEPLOTS = TRUE

plot.and.save('hc-ts.pdf', 12, 7, my.ts.plot, day, hc.ts, 
              main="Hourly measures of Heat Consumption", 
              ylab="Heat Consumption (GJ/h)", xlab="Time")

org.acf.main.tmpl = "%s for the original heat consumption series"
plot.and.save('acf-hc.pdf', 7, 7, my.acf, as.vector(hc.ts), 
              main=sprintf(org.acf.main.tmpl, "ACF"))
plot.and.save('pacf-hc.pdf', 7, 7, my.pacf, as.vector(hc.ts), 
              main=sprintf(org.acf.main.tmpl, "PACF"))

hc.d = diff(hc.ts, 1)
hc.d2 = diff(hc.d, 24)

my.acf(hc.d2)
my.pacf(hc.d2)

m1 = get.model('m1', arima, hc.ts, order=c(0,1,2), 
               seasonal=list(order=c(0,1,2), period=24))

m2 = get.model('m2', arima, hc.ts, order=c(0,1,4), 
               seasonal=list(order=c(0,1,1), period=24))

m3 = get.model('m3', arima, hc.ts, order=c(0,1,4), 
               seasonal=list(order=c(0,1,2), period=24))

m4 = get.model('m4', arima, hc.ts, order=c(4,1,4), 
               seasonal=list(order=c(0,1,1), period=24))

m5 = get.model('m5', arima, hc.ts, order=c(4,1,0), 
               seasonal=list(order=c(0,1,1), period=24))
