# Jan 23, 2022
# https://quantgirl.blog/box-muller-and-marsaglia-bray/

from numpy import random, sqrt, log, sin, cos, pi


def box_muller_sample(n=1):

    u1 = random.rand(n)
    u2 = random.rand(n)

    r = sqrt(-2*log(u1))
    x = cos(2*pi*u2)
    y = sin(2*pi*u2)
    z1 = r*x
    z2 = r*y

    return z1, z2
