dat = read.csv('../data/Satelliteorbit.csv', header=FALSE, sep=",")
dat = data.matrix(dat)
dat.xy = polar.to.cartesian(dat[,1], dat[,2])
dat.x = dat.xy$x
dat.y = dat.xy$y

