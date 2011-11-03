import numpy as np


uniform = np.random.uniform

def rs(f, n=1e5):
    k = 0
    xs = []
    while k < n:
        xt = uniform(-8, 8)
        accept_num = uniform()
        if accept_num < f(xt):
            xs.append(xt)
            k += 1
    return xs
