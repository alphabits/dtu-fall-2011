usage <- c(45939, 60423, 64721, 68484, 71799, 76036, 79831,
           21574, 29990, 32510, 35218, 37598, 40341, 43173,
           2876, 4708, 5230, 6662, 6856, 8220, 9053,
           1815, 2568, 2695, 2845, 3000, 3145, 3338,
           1646, 2366, 2526, 2691, 2868, 3054, 3224,
           89, 1411, 1546, 1663, 1769, 1905, 2005,
           555, 733, 773, 836, 911, 1008, 1076)
year <- rep(c(51, 56:61), times=7)

zeros <- rep(0, times=7)
ones <- rep(1, times=7)

na <- c(ones, rep(zeros, times=6))
na.ind <- as.logical(na)
eu <- c(zeros, ones, rep(zeros, times=5))
eu.ind <- as.logical(eu)
aa <- c(rep(zeros, times=2), ones, rep(zeros, times=4))
aa.ind <- as.logical(aa)
sa <- c(rep(zeros, times=3), ones, rep(zeros, times=3))
sa.ind <- as.logical(sa)
oc <- c(rep(zeros, times=4), ones, rep(zeros, times=2))
oc.ind <- as.logical(oc)
af <- c(rep(zeros, times=5), ones, rep(zeros, times=1))
af.ind <- as.logical(af)

model.simple <- lm(usage ~ year + na + eu + aa + sa + oc + af)
model.full <- lm(usage ~ year*na + year*eu + year*aa + year*sa + year*oc + year*af)
