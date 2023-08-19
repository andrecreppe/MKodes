import numpy as np

mat1 = eval(input().split(" ")[0])
arr1 = np.array(mat1)

mat2 = eval(input().split(" ")[0])
arr2 = np.array(mat2)

print("Produto Escalar")
print(np.vdot(arr1, arr2))

print("Produto Interno")
print(np.inner(arr1, arr2))

print("Produto Externo")
print(np.outer(arr1, arr2))