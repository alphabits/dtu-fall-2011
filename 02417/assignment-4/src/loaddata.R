dat = read.table('../data/veks.csv', sep=',', header=TRUE)
dat[,"day"] = 12965 + dat[,"rdays"]


hc = dat[["HC.f"]]
ta = dat[["Ta.f"]]

#st = 1995.5 + dat[2500,"rdays"]/365
ind = 2500:5500
st = dat[ind[1],"jdate"]

day = dat[["day"]][ind]
hc.ts = ts(hc[ind], start=st, frequency=24)
ta.ts = ts(ta[ind], start=st, frequency=24)
