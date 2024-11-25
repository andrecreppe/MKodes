import numpy as np
import matplotlib.pyplot as plt

# Parametros do sistema
T_f_ent_init = 20       # Temperatura inicial da agua fria (oC)
T_q_ent = 40            # Temperatura desejada da agua quente no banho (oC)
delta_T_chuveiro = 5.98 # Ganho de temperatura pelo chuveiro (oC)
vazao = 0.1             # Vazao massica (kg/s) = 6 l/s
c = 4186                # Calor especifico da agua (J/kgoC)
U = 850                 # Coeficiente global de transferencia de calor (W/m^2oC)
A = 0.332               # Area de troca de calor (m^2)
eficiencia = 0.7        # Eficiencia do trocador de calor (70%)
tolerancia = 0.01       # Criterio de convergencia (oC)
perda_cano = 1          # Perda de calor antes de chegar no chuveiro (oC)

# Funcao para calcular a temperatura de saida do trocador considerando perdas
def calcular_temperatura_saida(T_f_ent, T_q_sai, eficiencia):
    delta_T1 = T_q_ent - T_f_ent
    delta_T2 = T_q_sai - T_f_ent
    if delta_T1 == delta_T2:  # Evita divisao por zero no log
        delta_T_ml = delta_T1
    else:
        delta_T_ml = (delta_T1 - delta_T2) / np.log(delta_T1 / delta_T2)
    q = eficiencia * U * A * delta_T_ml  # Taxa de calor transferida considerando perdas
    T_f_sai = T_f_ent + q / (vazao * c)  # Nova temperatura da agua fria
    return T_f_sai

# Inicializacao
T_f_ent = T_f_ent_init
T_q_sai = T_q_ent - delta_T_chuveiro
T_f_sai = T_f_ent_init

T_sai_plot = []

# Iteracao incremental com perdas
for tempo in range(1000):  # Limite maximo de iteracoes
    T_f_sai_calculado = calcular_temperatura_saida(T_f_ent, T_q_sai, eficiencia)
    T_sai_plot.append(T_f_sai_calculado)
    
    # Condicao de equilibrio
    if abs(T_f_sai_calculado - T_f_sai) < tolerancia:
        T_f_sai = T_f_sai_calculado
        break
    
    # Atualizacao incremental para evitar instabilidades
    T_f_sai += (T_f_sai_calculado - T_f_sai)
    T_f_ent = T_f_sai - perda_cano  # Atualiza entrada
    T_q_sai = T_f_ent + delta_T_chuveiro  # Recalcula saida do chuveiro

# Grafico
t = range(len(T_sai_plot))

plt.figure(figsize=(10, 6))
plt.plot(t, T_sai_plot, label="Temperatura da água (oC)", color="green")
plt.title("Temperatura de saída do chuveiro com regenerador de calor ao longo do tempo.", fontsize=14)
plt.xlabel("Tempo (s)", fontsize=12)
plt.ylabel("Temperatura de saída do chuveiro (oC)", fontsize=12)
plt.grid(True, linestyle='--', alpha=0.7)
plt.axhline(0, color='black', linewidth=0.8)
plt.axvline(0, color='black', linewidth=0.8)
plt.legend(fontsize=12)
plt.show()
