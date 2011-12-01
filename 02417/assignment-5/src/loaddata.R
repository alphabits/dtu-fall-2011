dat = read.csv('../data/Satelliteorbit.csv', header=FALSE, sep=",")
dat.xy = polar.to.cartesian(dat[,1], dat[,2])
dat.x = dat.xy$x
dat.y = dat.xy$y

r.m = dat[,1]
theta.m = dat[,2]
