# Include all dependencies
library(xtable)
library(multcomp)
source('functions.R')

# Controls whether the plots are saved or displayed
SAVEPLOTS = TRUE

# Load data in carrots variable
source('loaddata.R')

attach(carrots)

plot.and.save('interaction-region-cultivar.pdf', 7, 7,
              interaction.plot, region, cultivar, Sweetness)
plot.and.save('interaction-cultivar-region.pdf', 7, 7,
              interaction.plot, cultivar, region, Sweetness)


# Define model and calculate anova
m2 = lm(Sweetness ~ Consumer + cultivar*region)
m2.anova = anova(m2)
m2.res = residuals(m2)

# Save anova as latex table
sink('../tables/q2-model2-xtable.tex')
print(xtable(m2.anova))
sink()

# Plot diagnostic plots
plot.and.save('qqplot-model2.pdf', 7, 7,
              qqnorm, m2.res)
plot.and.save('residuals-model2.pdf', 7, 7,
              plot, predict(m2), m2.res,
              xlab='Fitted values', ylab='Residuals')

# Do post hoc analysis
hypothesis2 = glht(m2, linfct=mcp(cultivar="Tukey"))
sink('../tables/q2-post-hoc.tex')
summary(hypothesis2)
sink()

detach("carrots")
