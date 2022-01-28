# Notes
- [How to generate Gaussian samples](https://medium.com/mti-technology/how-to-generate-gaussian-samples-3951f2203ab0)

- we can use box muller transformation to convert uniform distribution to Gaussian distribution.

```python
import numpy as np

# 0. Initialize random number generator
rng = np.random.RandomState(seed=42)

# 1. Generate 1000 U1 and U2, which are Unif(0, 1)
u1s, u2s = rng.uniform(size=1000), rng.uniform(size=1000)

# 2. Tranform U1 to s
ss = -np.log(u1s)

# 3. Transform U2 to theta
thetas = 2*pi*u2s

# 4. Convert s to r
rs = np.sqrt(2*ss)

# 5. Calculate x and y from r and theta
xs, ys = rs*np.cos(thetas), rs*np.sin(thetas)
```