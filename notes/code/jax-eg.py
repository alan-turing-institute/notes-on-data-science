import jax
from jax import make_jaxpr
import jax.numpy as jnp

def g(x):
    g = jnp.exp(-(x*x)/2)
    return g

print(make_jaxpr(g)(0))
