import numpy as np
import matplotlib.pyplot as plt

# Constantes
P = 2500        # Potencia em Watts
c = 4186        # Calor especifico da agua em J/(kg.oC)
rho = 1000      # Densidade da agua em kg/m^3
V = 0.001       # Volume do sistema em m^3 (1 litro)
T_entrada = 20  # Temperatura de entrada d'agua em oC
Q = 6           # Vazao em L/min

dot_m = Q / 60  # Vazao massica em kg/s

# Setup da simulacao
dt = 0.1                      # Passo em segundos
tempo = np.arange(0, 100, dt) # Simular por 100 segundos
T = np.zeros_like(tempo)      # Array de temperaturas
T[0] = T_entrada              # Temperatura inicial

# Simulacao transiente
for i in range(1, len(tempo)):
    dTdt = (P - dot_m * c * (T[i-1] - T_entrada)) / (rho * V * c)
    T[i] = T[i-1] + dTdt * dt

# Grafico
plt.figure(figsize=(10, 6))
plt.plot(tempo, T, label="Temperatura da agua (oC)", color="blue")
plt.axhline(T_entrada, color="red", linestyle="--", label="Temperatura de entrada (oC)")
plt.title("Resposta transiente de temperatura no chuveiro eletrico", fontsize=14)
plt.xlabel("Tempo (s)", fontsize=12)
plt.ylabel("Temperatura (oC)", fontsize=12)
plt.legend(fontsize=12)
plt.grid(True, linestyle='--', alpha=0.7)
plt.show()
