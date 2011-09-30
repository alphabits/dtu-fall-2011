## A little code as inspiration for estimating Ua of houses.
## 2011-sep-27 Lasse Engbo Christiansen

## Reading data and reformating columns where needed.
dat <- read.table("houseEnergy.txt",header=TRUE)
str(dat)
library(date)
dat$t <- as.date(as.character(dat$t),order="ymd")
dat$houseId <- as.factor(sprintf("H%02i",dat$houseId))
levels(dat$houseId)

## Plotting the heat consumptions for all houses
par(mfrow=c(4,4),mgp=c(2,0.7,0),mar=c(2,2,1,1))
for (i in levels(dat$houseId)){ 
    plot(Q~t,dat[dat$houseId==i,],xlim=c(17857,18520),ylim=c(0,8),cex=0.1)
    legend("topright",legend=i)
  }

## A simple model:
lm1 <- lm(Q~houseId*Ta,dat)
## What is the difference between the following two commands?
summary(lm1)
summary.aov(lm1)

## Playing with one house
datH03<-subset(dat,houseId=="H03")
pairs(datH03) ## Gives errors related to dates
pairs(sapply(datH03,as.numeric))

## The same simpel model
lmH03 <- lm(Q~Ta,datH03)

## Diagnostic plots
par(mfrow=c(2,2),mar=c(3.5,3.5,2,1))
plot(lmH03)

## Plotting the residuals vs. all predictors
for (i in names(datH03)[4:7]){
  plot(datH03[-lmH03$na.action,i],residuals(lmH03),xlab=i)
  panel.smooth(datH03[-lmH03$na.action,i],residuals(lmH03),lwd=2)
  abline(h=0,col=3,lwd=2)
}

## Plotting residuals for each house
par(mfrow=c(4,4),mgp=c(2,0.7,0),mar=c(2,2,1,1))
for (i in levels(dat$houseId)){ 
    with(dat,plot(residuals(lm1)[houseId[-lm1$na.action]==i] ~ (t[-lm1$na.action])[houseId[-lm1$na.action]==i],xlim=c(17857,18520),ylim=c(-3.3,3.3),cex=0.1))
    legend("topright",legend=i)
}

## The error I had was due to not omitting NA's before fitting the model
## An easy way to do this is:
## dat <- omit.na(dat)



#################################################
## Two functions needed to make pairs() work with dates
as.vector.date<-function(x,mode="any"){
    if (mode == "any") 
        as.vector(as.numeric(x),mode)
    else if(mode == "character" || mode == "logical" || 
        mode == "list") 
        as.vector(as.character(x), mode)
    else as.vector(unclass(x), mode)
}

Axis.date<-function(x = NULL, at = NULL, xlim=range(x,na.rm=TRUE), ..., side, labels = NULL){
  if(!is.null(x)){
    x <- c(x[!is.na(x)], xlim)
    xd <- date.mdy(x)
    temp <- pretty(x, n = par("lab")[1])
    delta <- temp[2] - temp[1]
    if (delta < 1) 
        temp <- seq(min(x), max(x), 1)
    else if (delta > 182) {
        temp <- xd$year + (x - mdy.date(1, 1, xd$year))/365
        temp <- pretty(temp, n = par("lab")[1])
        temp <- mdy.date(1, 1, floor(temp)) + floor((temp%%1) * 365)
    }
    ## Within NS:date axis(side = side, at=temp, labels=as.character.date(temp), ...)
    axis(side = side, at=temp, labels=date:::as.character.date(temp), ...)
  } else
    axis(side = side, at = at, labels = labels, ...)
}
