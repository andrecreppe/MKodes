def mdc(x, y):
    if(x == y):
        return x
    elif(x < y):
        return mdc(y, x)
    else:
        return mdc(x-y, y)

a = int(input())
b = int(input())

print(mdc(a, b))