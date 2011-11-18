source('loaddata.R')
source('functions.R')


SAVEPLOTS = TRUE


plot.and.save('hc-ts.pdf', 12, 7, my.ts.plot, day, hc.ts, 
              main="Hourly measures of Heat Consumption", 
              ylab="Heat Consumption (GJ/h)", xlab="Time")


org.acf.main.tmpl = "%s for the original heat consumption series"
plot.and.save('acf-hc.pdf', 7, 5, my.acf, as.vector(hc.ts), 
              main=sprintf(org.acf.main.tmpl, "ACF"))
plot.and.save('pacf-hc.pdf', 7, 5, my.pacf, as.vector(hc.ts), 
              main=sprintf(org.acf.main.tmpl, "PACF"))

plot.and.save('range-mean-plot.pdf', 7, 7, range.mean.plot, hc.ts, 200,
              main="Range-Mean plot for the HC data (Group size = 200)")

hc.d = diff(hc.ts, 1)

hc.diff.acf.main.tmpl = "%s for the differenced heat consumption series"
plot.and.save('acf-hc-diff.pdf', 7, 5, my.acf, as.vector(hc.d), 
              main=sprintf(hc.diff.acf.main.tmpl, "ACF"))
plot.and.save('pacf-hc-diff.pdf', 7, 5, my.pacf, as.vector(hc.d), 
              main=sprintf(hc.diff.acf.main.tmpl, "PACF"))


hc.d.season = diff(hc.d, 24)

hc.diff.season.acf.main.tmpl = "%s for the seasonal differenced heat consumption series"
plot.and.save('acf-hc-diff-season.pdf', 7, 5, my.acf, as.vector(hc.d.season), 
              main=sprintf(hc.diff.season.acf.main.tmpl, "ACF"))
plot.and.save('pacf-hc-diff-season.pdf', 7, 5, my.pacf, as.vector(hc.d.season), 
              main=sprintf(hc.diff.season.acf.main.tmpl, "PACF"))


# Testing lots of different models

models = list(
    list(name='m1', nonseas=c(0,1,2), seas=c(0,1,2)),
    list(name='m2', nonseas=c(0,1,4), seas=c(0,1,1)),
    list(name='m3', nonseas=c(0,1,4), seas=c(0,1,2)),
    list(name='m4', nonseas=c(4,1,4), seas=c(0,1,1)),
    list(name='m5', nonseas=c(4,1,0), seas=c(0,1,1)),
    list(name='m6', nonseas=c(1,1,0), seas=c(2,0,0)),
    list(name='m7', nonseas=c(3,1,3), seas=c(0,1,1)),
    list(name='m8', nonseas=c(2,1,2), seas=c(0,1,1)),
    list(name='m9', nonseas=c(1,1,1), seas=c(0,1,1)),
    list(name='m10', nonseas=c(3,1,2), seas=c(0,1,1)),
    list(name='m11', nonseas=c(2,1,3), seas=c(0,1,1)),
    list(name='m12', nonseas=c(3,1,0), seas=c(1,0,0)),
    list(name='m13', nonseas=c(1,1,2), seas=c(0,1,1)),
    list(name='m14', nonseas=c(2,1,3), seas=c(0,1,2)), 
    list(name='m15', nonseas=c(2,1,3), seas=c(1,1,1)),
    list(name='m16', nonseas=c(2,1,2), seas=c(0,1,1), transform=log),
    list(name='m17', nonseas=c(2,1,2), seas=c(0,1,2)),
    list(name='m18', nonseas=c(2,1,1), seas=c(0,1,2)),
    list(name='m19', nonseas=c(2,1,1), seas=c(1,1,2)),
    list(name='m20', nonseas=c(2,1,1), seas=c(0,1,2), transform=log),
    list(name='m21', nonseas=c(2,1,1), seas=c(0,1,1)),
    list(name='m22', nonseas=c(2,1,1), seas=c(0,1,2)),
    list(name='m23', nonseas=c(2,1,1), seas=c(0,1,3)),
    list(name='m24', nonseas=c(1,1,2), seas=c(2,1,1)),
    list(name='m25', nonseas=c(2,1,1), seas=c(0,2,1)),
    list(name='m26', nonseas=c(2,0,1), seas=c(0,1,2)),
    list(name='m27', nonseas=c(2,1,1), seas=c(1,0,2)),
    list(name='m28', nonseas=c(2,1,1), seas=c(1,1,1)),
    list(name='m29', nonseas=c(2,1,1), seas=c(1,0,4))
)

# Iterate models and assign in current scope
for (m in models) {
    model.name = m[["name"]]
    model.data = if ("transform" %in% names(m)) m[["transform"]](hc.ts) else hc.ts
    assign(model.name, get.model(model.name, arima, model.data, order=m[["nonseas"]], 
                           seasonal=list(order=m[["seas"]], period=24)))
}

plot.and.save('m22-predictions.pdf', 12, 7,
              plot.forecast, m22, 
              main=sprintf("Predictions of %s model", get.model.string(models[[22]])))
save.prediction.table('m22-predictions.tex', m22)

# Save all info about 'interesting' models for the report

for (model.setup in models) {
    model.name = model.setup[["name"]]
    model = get(model.name)
    description = get.model.string(model.setup)

    # QQ plot
    plot.and.save(sprintf('%s-qq.pdf', model.name), 7, 7, qq, model)
    # Model summary
    save.model.summary(model, sprintf('%s-summary.txt', model.name))
    # Sign test
    save.sign.test(residuals(model), sprintf('%s-sign-test.txt', model.name))
    # tsdiag
    plot.and.save(sprintf('%s-tsdiag.pdf', model.name), 7, 8.5, tsdiag, model, gof.lag=32)
    # ACF and PACF of residuals
    plot.and.save(sprintf('%s-residual-acf.pdf', model.name), 7, 5, my.acf, residuals(model), 
                  main=sprintf("ACF for residuals of %s model", description))
    plot.and.save(sprintf('%s-residual-pacf.pdf', model.name), 7, 5, my.pacf, residuals(model), 
                  main=sprintf("PACF for residuals of %s model", description))
}
