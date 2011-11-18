source('loaddata.R')
source('functions.R')
library('TSA')


SAVEPLOTS = TRUE


ta.d = diff(diff(ta.ts, 1), 24)
w.d = diff(diff(w.ts, 1), 24)
gr.d = diff(diff(gr.ts, 1), 24)
hc.d = diff(diff(hc.ts, 1), 24)

# Modelling the ambient temperature

plot.and.save('ta-ccf.pdf', 7, 6,
              prewhiten, ta.d, hc.d,
              main="CCF between Ambient Temperature and Heat Consumption")
plot.and.save('w-ccf.pdf', 7, 6,
              prewhiten, w.d, hc.d,
              main="CCF between Wind Speed and Heat Consumption")
plot.and.save('gr-ccf.pdf', 7, 6,
              prewhiten, gr.d, hc.d,
              main="CCF between Global Radiation and Heat Consumption")
 
m22 = get.model('m22', function(){})


models = list(
    list(name='tfm1', nonseas=c(2,1,0), seas=c(0,1,2), exo=ta.ts),
    list(name='tfm2', nonseas=c(3,1,3), seas=c(0,1,2), exo=ta.ts),
    list(name='tfm3', nonseas=c(2,1,3), seas=c(0,1,2), exo=ta.ts),
    list(name='tfm4', nonseas=c(3,1,3), seas=c(0,1,2), exo=ta.ts[2:3001])
)

# Iterate models and assign in current scope
for (m in models) {
    model.name = m[["name"]]
    model.data = if ("transform" %in% names(m)) m[["transform"]](hc.ts) else hc.ts
    if (model.name == 'tfm4') {
        model.data = model.data[1:3000]
    }
    assign(model.name, get.model(model.name, arima, model.data, order=m[["nonseas"]], 
                           seasonal=list(order=m[["seas"]], period=24), xreg=m[["exo"]]))
}


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
                  main=sprintf("ACF for residuals of %s transfer model", description))
    plot.and.save(sprintf('%s-residual-pacf.pdf', model.name), 7, 5, my.pacf, residuals(model), 
                  main=sprintf("PACF for residuals of %s transfer model", description))
}
