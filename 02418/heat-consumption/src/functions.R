
plot.and.save = function(filename, width, height, plotfunction, ...) {
    save.the.plot = exists('SAVEPLOTS') && SAVEPLOTS
    if (save.the.plot) {pdf(sprintf('../plots/%s', filename), width, height)}
    plotfunction(...)
    if (save.the.plot) {dev.off()}
}

save.diagnostics = function(model, filenametmpl) {
    filename.summary = sprintf(filenametmpl, 'summary-xtable')
    sink(sprintf('../tables/%s.tex', filename.summary))
    print(xtable(model))
    sink()

    filename.res = sprintf(filenametmpl, 'fit-res-plot')
    pdf(sprintf('../plots/%s.pdf', filename.res))
    plot(model, which=1)
    dev.off()

    filename.res = sprintf(filenametmpl, 'qq-plot')
    pdf(sprintf('../plots/%s.pdf', filename.res))
    plot(model, which=2)
    dev.off()

    filename.fit = sprintf(filenametmpl, 'fit-data-plot')
    pdf(sprintf('../plots/%s.pdf', filename.fit))
    plot.model.with.data(model)
    dev.off()

    for (i in names(datH05)[4:7]){
        filename.fit = sprintf(filenametmpl, sprintf('%s-data-plot', i))
        pdf(sprintf('../plots/%s.pdf', filename.fit))
        plot(datH05[[i]], residuals(model), xlab=i, ylab='Residuals',
             main=sprintf('Residuals vs %s', i))
        panel.smooth(datH05[[i]], residuals(model), lwd=2)
        abline(h=0, col=3, lwd=2)
        dev.off()
    }
}

plot.model.with.data = function(model) {
    plot(t, Q, pch=21)
    lines(t, fitted(model))
}
