import socket

## Based on: https://realpython.com/python-sockets/
HOST = "127.0.0.1"  # Standard loopback interface address (localhost)
PORT = 65432        # Port to listen on (non-privileged ports are > 1023)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print(f"Connected by {addr}")
        while True:
            data = conn.recv(1024)
            if not data:
                break
            conn.sendall(data)





## Return the nth prime number, inefficiently 
def nth_prime(n):

    i = 3
    primes = [2]
    
    while len(primes) < n:
        while any([i % p == 0 for p in primes]):
            i = i + 1
        
        primes.append(i)    
        i = i + 1

    return i - 1
        
