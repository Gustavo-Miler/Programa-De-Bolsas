import hashlib

while True:
    s = input()
    print(hashlib.sha1(s.encode()).hexdigest())