def sumUpTo(N, acc):
    if N == 0:
        return acc
    else:
        return sumUpTo(N - 1, acc + N)
