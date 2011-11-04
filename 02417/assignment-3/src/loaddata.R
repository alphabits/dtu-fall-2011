dat = read.table("../data/assignment3data.dat")
dat = dat[,1]
dat.ts = ts(dat, start=1995, freq=12)
train = dat[1:78]
train.ts = ts(train, start=1995, freq=12)
test = dat[-(1:78)]
test.ts = ts(test, start=c(2001, 7), freq=12)
