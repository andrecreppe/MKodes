def power(x, n):
    if n == 1:
        return x
    else:
        return x*power(x, n-1)

num = int(input())
exp = int(input())

print(power(num, exp))