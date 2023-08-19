import numpy as np

mat1 = eval(input().split(" ")[0])
arr1 = np.array(mat1)

mat2 = eval(input().split(" ")[0])
arr2 = np.array(mat2)

print("M1 + M2")
print(arr1 + arr2)

print("M1 - M2")
print(arr1 - arr2)

print("M1 * M2")
print(arr1 * arr2)

print("M1 / M2")
print(arr1 / arr2)

print("M1 ** 2")
print(arr1**2)

print("Raiz M2")
print(np.sqrt(arr2))