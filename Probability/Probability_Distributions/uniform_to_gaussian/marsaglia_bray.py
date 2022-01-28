# Jan 23, 2022
# https://quantgirl.blog/box-muller-and-marsaglia-bray/

import numpy as np
import math


def marsaglia():

    while True:

        w1 = (np.random.rand() * 2) - 1
        w2 = (np.random.rand() * 2) - 1
        s = w1 * w1 + w2 * w2

        if s < 1:
            t = math.sqrt((-2) * math.log(s)/s)
            z1 = w1 * t
            z2 = w2 * t

            return z1, z2


def marsaglia_sample(n=1):

    z1 = np.empty(n)
    z2 = np.empty(n)

    for i in range(n):
        z1[i], z2[i] = marsaglia()

    return z1, z2
