yield.a <- c(14.5, 12.0, 9.0, 6.5)
yield.b <- c(13.5, 10.0, 9.0, 8.5)
yield.c <- c(11.5, 11.0, 14.0, 10.0)
yield.d <- c(13.0, 13.0, 13.5, 7.5)
yield.e <- c(15.0, 12.0, 8.0, 7.0)
yield.f <- c(12.5, 13.5, 14.0, 8.0)

zeros <- rep(0, times=4)
ones <- rep(1, times=4)

yield <- c(yield.a, yield.b, yield.c, yield.d, yield.e, yield.f)
mu <- rep(1, times=24)
fertiliser.b <- c(zeros, ones, rep(zeros, times=4))
fertiliser.c <- c(rep(zeros, times=2), ones, rep(zeros, times=3))
fertiliser.d <- c(rep(zeros, times=3), ones, rep(zeros, times=2))
fertiliser.e <- c(rep(zeros, times=4), ones, zeros)
fertiliser.f <- c(rep(zeros, times=5), ones)

linearmodel <- lm(yield ~ mu + fertiliser.b + fertiliser.c + fertiliser.d 
                             + fertiliser.e + fertiliser.f - 1)

fertilisers <- as.factor(rep(c('A', 'B', 'C', 'D', 'E', 'F'), each=4))
aovmodel <- aov(yield ~ fertilisers)


# Two way anova
areas <- as.factor(rep(c('A1', 'A2', 'A3', 'A4'), times=6))
twoway.aovmodel <- aov(yield ~ fertilisers + areas)

area.1 <- rep(c(1,0,0,0), times=6)
area.2 <- rep(c(0,1,0,0), times=6)
area.3 <- rep(c(0,0,1,0), times=6)
area.4 <- rep(c(0,0,0,1), times=6)
twoway.linearmodel <- lm(yield ~ mu + fertiliser.b + fertiliser.c + fertiliser.d 
                       + fertiliser.e + fertiliser.f + area.2 + area.3 
                       + area.4 - 1)

X <- cbind(mu, fertiliser.b, fertiliser.c, fertiliser.d, fertiliser.e, fertiliser.f,
           area.2, area.3, area.4)
bhat <- solve(t(X)%*%X)%*%t(X)%*%yield

sink('exercise-4-3.out')
summary(linearmodel)
summary(aovmodel)
summary(twoway.linearmodel)
summary(twoway.aovmodel)
sink()
