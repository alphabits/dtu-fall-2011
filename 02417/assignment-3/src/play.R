source('loaddata.R')


plot(train.ts, main='Airline passengers', xlab='Time', ylab='Passengers')

acf(train)
pacf(train)
