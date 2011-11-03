import numpy as np


f = lambda x: (np.exp(-(x-3)**2)+np.exp(-abs(x)))
uniform = np.random.uniform

c = 1.0
a = 1
T = lambda t: c*np.exp(-a*t)

def simulated_annealing(x0, n=1e5, s=0.1):
    xs = []
    pas = []
    xcur = x0
    for i in range(1, n):
        xcand = xcur + uniform(-s, s)
        paccept = min( 1, (f(xcand)/f(xcur))**(1/T(i)) )
        pas.append(paccept)
        if uniform() < paccept:
            xcur = xcand
            xs.append(xcur)
    return (xs, pas)
