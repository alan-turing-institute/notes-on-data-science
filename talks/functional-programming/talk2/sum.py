def sumUpTo(N):
    if N == 0:
        return 0
    else:
        return N + sumUpTo(N - 1)
    
