################
# Exercise 5.5 #
################

rate <- c(67, 51, 84, 86, 98, 115, 131, 124, 144, 158, 160, 76,
       47, 97, 107, 123, 139, 159, 152, 191, 201, 207, 200)
conc.half <- c(rep(c(0.02, 0.06, 0.11, 0.22, 0.56), each=2), c(1.10))
conc <- c(rep(conc.half, times=2), 1.1)
state <- c(rep(0, times=11), rep(1, times=12))

# Try to fit full ancova model
model.full <- lm(rate ~ conc * state)

# Find best model by backward selection
model.back <- step(model.full, direction="backward")

# Find by stepwise selection
model.step <- step(model.full, direction="both")



################
# Exercise 5.6 #
################

rate.log <- log(rate)
conc.log <- log(conc)

model.full.log <- lm(rate.log ~ conc.log * state)
model.back.log <- step(model.full.log, direction="backward")
