

def sumVals(xs):
    i = 0
    total = 0
    while i < len(xs):
        total = total + xs[i]
        i = i + 1
    return total
    

print(sumVals([1, 3, 2, 8]))

