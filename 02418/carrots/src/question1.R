# Include all dependencies
library(multcomp)
library(xtable)
source('functions.R')

# Controls whether the plots are saved or displayed
SAVEPLOTS = TRUE

# Load data in carrots variable
source('loaddata.R')

attach(carrots)

plot.and.save('sweetness-histogram.pdf', 7, 7,
              plot, factor(Sweetness), main='Histogram for Sweetness scores',
              xlab='Sweetness', ylab='Counts')

titletmpl = 'Distribution of sweetness score for the %s'
plot.and.save('product-boxplot.pdf', 7, 7,
              plot, product, Sweetness,
              main=sprintf(titletmpl, '12 products'),
              xlab='Product', ylab='Sweetness')
plot.and.save('consumer-boxplot.pdf', 14, 7,
              plot, Consumer, Sweetness,
              main=sprintf(titletmpl, '103 Consumers'),
              xlab='Consumer', ylab='Sweetness')

# Define model and calculate anova
m1 = lm(Sweetness ~ Consumer + product)
m1.anova = anova(m1)
m1.res = residuals(m1)

# Residual plot is difficult to interpret. 
# Try a few transformations
models = list(
    list(y=Sweetness^0.5, key="sqrt", label="Square root"),
    list(y=log(Sweetness), key="log", label="Log"),
    list(y=(Sweetness^0.5-1)/0.5, key="boxcox", label="Box/Cox")
)
for (model in models) {
    y.tmp = model[['y']]
    key.tmp = model[['key']]
    model.tmp = lm(y.tmp~Consumer+product)
    filename.tmpl = '%s-model-%s.pdf'
    title.tmpl = sprintf('%%s for %s transformed model', 
                         model[['label']])
    plot.and.save(sprintf(filename.tmpl, 'qqplot', key.tmp), 7, 7,
                  main=sprintf(title.tmpl, 'Normal Q-Q plot'),
                  qqnorm, residuals(model.tmp))
    plot.and.save(sprintf(filename.tmpl, 'residuals', key.tmp), 7, 7,
                  plot, predict(model.tmp), residuals(model.tmp),
                  main=sprintf(title.tmpl, 'Residuals plot'),
                  xlab="Fitted values", ylab="Residuals")
}

# Save anova as latex table
sink('../tables/q1-model1-xtable.tex')
print(xtable(m1.anova))
sink()

# Plot diagnostic plots
plot.and.save('qqplot-model1.pdf', 7, 7,
              qqnorm, m1.res)
plot.and.save('residuals-model1.pdf', 7, 7,
              plot, predict(m1), m1.res,
              xlab='Fitted values', ylab='Residuals')

# Do post hoc analysis
hypothesis = glht(m1, linfct=mcp(product="Tukey"))
sink('../tables/q1-post-hoc.tex')
summary(hypothesis)
sink()

detach('carrots')
