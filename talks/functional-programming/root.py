from math import log

# Find a zero of -x ln x - (1-x) ln (1-x) - x

def f(x):
    return (-x*math.log(x)
            - (1.0-x)*math.log(1.0-x) - x)

eps = 0.001

# Ensure f(a) > 0  and f(b) < 0
a = 0.5
b = 0.99

while abs(b - a) > eps:
    guess = (a + b) / 2.0
    if f(guess) > 0.0:
        a = guess
    else:
        b = guess
        
print(f"[{a},{b}]")
