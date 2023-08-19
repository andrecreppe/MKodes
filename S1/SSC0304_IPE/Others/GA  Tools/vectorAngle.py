import math

a1, a2, a3 = input("V1 components (x y z): ").split(" ")
a1, a2, a3 = [float(a1), float(a2), float(a3)]

b1, b2, b3 = input("V2 components (x y z): ").split(" ")
b1, b2, b3 = [float(a1), float(a2), float(a3)]

esc = a1*b1 + a2*b2 + a3*b3
mod1 = math.sqrt(a1*a1 + a2*a2 + a3*a3)
mod2 = math.sqrt(b1*b1 + b2*b2 + b3*b3)

cosAng = esc / (mod1 * mod2)
arcAng = math.acos(cosAng)
arcAng = (arcAng * 180) / math.pi

#print("cos(ang(v1, v2)) = ", round(cosAng, 2))
print("ang(v1, v2) = ", round(arcAng, 2), "°")
