# Note to self: pyvenv-activate

import jax
from jax import make_jaxpr, grad
import jax.numpy as jnp

def g(x):
    g = jnp.exp(-(x*x)/2)
    return g

print(make_jaxpr(g)(0))

dg = grad(g)
