dat = read.table('../data/veks.csv', sep=',', header=TRUE)
dat[,"day"] = 12965 + dat[,"rdays"]


hc = dat[["HC.f"]]
ta = dat[["Ta.f"]]
w = dat[["W.f"]]
gr = dat[["GR.f"]]

#st = 1995.5 + dat[2500,"rdays"]/365
ind = 2500:5500
pred.ind = 2500:5508
pred.only.ind = 5501:5506
st = dat[ind[1],"jdate"]

day = dat[["day"]][ind]
day.pred = dat[["day"]][pred.only.ind]
day.inc.pred = dat[["day"]][pred.ind]
hc.ts = ts(hc[ind], start=st, frequency=24)
ta.ts = ts(ta[ind], start=st, frequency=24)
w.ts = ts(w[ind], start=st, frequency=24)
gr.ts = ts(w[ind], start=st, frequency=24)
