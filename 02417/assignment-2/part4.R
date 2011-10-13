zs = function (num) {
    return(rep(0, times=num))
}

model = function(a1, b1) {return(c(a1, zs(10), b1, a1*b1))}

models = list(
    list(ar=-c(0.9)),
    list(ar=-c(zs(11), 0.7)),
    list(ar=-c(0.9), ma=c(zs(11), 0.4)),
    list(ar=-model(0.9, 0.7)),
    list(ma=model(0.4, 0.3)),
    list(ar=-c(zs(11), 0.4), ma=c(0.7))
);

par(mfrow=c(2,3))
for (m in models) {
    plot(arima.sim(240, model=m))
}
