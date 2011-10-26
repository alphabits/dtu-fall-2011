# Include dependecies
library(date)

if (!exists("dat")) {
    dat = read.table("../data/houseEnergy.txt", header=TRUE)
    dat$t = as.date(as.character(dat$t), order="ymd")
    dat$houseId = as.factor(sprintf("H%02i", dat$houseId))
    dat$daynum = (as.numeric(dat$t)-310) %% 365
    dat = na.omit(dat)
}

if (!exists("datH05")) {
    datH05 = subset(dat, houseId=="H05")
}
