import numpy as np
import matplotlib.pyplot as plt

# Constantes
P = 2500  # Potencia em Watts
c = 4186  # Calor especifico da agua em J/(kg.oC)

# Conjunto de vazoes (Q) em L/min
vazoes = np.linspace(1, 10, 100)  # De 1 a 100 L/min com passo de 10 L/min
massa_vazoes = vazoes / 60     # Converter L/min para kg/s

# Calcula o aumento de temperatura (DT) para cada vazao
aumento_temp = P / (c * massa_vazoes)

# Grafico
plt.figure(figsize=(10, 6))
plt.plot(vazoes, aumento_temp, label="Delta da temperatura (DT)", color="blue")
plt.title("Delta da emperatura vs. Fluxo volumetrico em um chuveiro eletrico (2500W)", fontsize=14)
plt.xlabel("Fluxo volumetrico (L/min)", fontsize=12)
plt.ylabel("Delta da Temperatura (oC)", fontsize=12)
plt.grid(True, linestyle='--', alpha=0.7)
plt.axhline(0, color='black', linewidth=0.8)
plt.axvline(0, color='black', linewidth=0.8)
plt.legend(fontsize=12)
plt.show()
