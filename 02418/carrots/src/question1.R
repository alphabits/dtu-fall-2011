carrots = read.table("../data/carrots.txt", header=TRUE, sep=",")
carrots$Consumer = factor(carrots$Consumer)
carrots$product = factor(carrots$product)

attach(carrots)

# Choosing to look at Sweetness evaluations
# First some plotting

##pdf("../plots/histogram-sweetness.pdf")
plot(factor(Sweetness))
##dev.off()

plot(product, Sweetness)
plot(Consumer, Sweetness)

ind = product %in% list("Bolero_E", "Bolero_F", "Yukon_L")
interaction.plot(Consumer[ind], product[ind], Sweetness[ind])

m1 = lm(BITTER~Consumer+product)
anova(m1)

res.m1 = residuals(m1)
qqnorm(res.m1)
plot(predict(m1), res.m1)
plot(Consumer, res.m1)
plot(product, res.m1)


m2 = lm(log(BITTER)~Consumer+product)
anova(m2)

res.m2 = residuals(m2)
qqnorm(res.m2)
plot(predict(m2), res.m2)
plot(Consumer, res.m2)
plot(product, res.m2)
