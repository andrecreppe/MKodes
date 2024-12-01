import tkinter as tk
from tkinter import messagebox
import serial
import time
import matplotlib.pyplot as plt

# Configura a porta serial
try:
    # Para Linux (Ubuntu ou outro sistema baseado em Unix)
    arduino = serial.Serial("/dev/ttyUSB0", baudrate=9600, timeout=1)
    # Para Windows (descomente e ajuste "COMx" se necessário)
    # arduino = serial.Serial("COM11", baudrate=9600, timeout=1)
    time.sleep(2)  # Dá tempo para estabilizar a conexão
except Exception as e:
    messagebox.showerror("Erro", f"Erro ao conectar na porta serial: {e}")
    arduino = None

# Variáveis globais
pid_angulo_ativo = True
posicao_atual = 0
posicoes_pedidas = []
posicoes_reais = []
tempos = []
angulos = []

# Função para alternar o PID de Ângulo
def alternar_pid_angulo():
    global pid_angulo_ativo
    pid_angulo_ativo = not pid_angulo_ativo
    
    if arduino and arduino.is_open:
        comando = "A1\n" if pid_angulo_ativo else "A0\n"
        arduino.write(comando.encode('utf-8'))
        status = "Ativado" if pid_angulo_ativo else "Desativado"
        messagebox.showinfo("PID de Ângulo", f"PID de Ângulo {status} com sucesso!")
    else:
        messagebox.showerror("Erro", "Porta serial não está aberta.")
    
    btn_pid_angulo.config(text="PID de Ângulo: Ligado" if pid_angulo_ativo else "PID de Ângulo: Desligado")

# Função para enviar o valor inserido manualmente
def enviar_valor_manual(event=None):
    global posicao_atual, posicoes_pedidas
    try:
        valor = int(entry_valor.get())
        if 0 <= valor <= 30:
            if arduino and arduino.is_open:
                arduino.write(f"T{valor}\n".encode('utf-8'))
                posicao_atual = valor
                posicoes_pedidas.append(valor)
                tempos.append(time.time())
                atualizar_slider_visual()
                messagebox.showinfo("Enviado", f"Posição alvo {valor} cm enviada para o Arduino!")
            else:
                messagebox.showerror("Erro", "Porta serial não está aberta.")
        else:
            messagebox.showerror("Erro", "Insira um valor entre 0 e 30.")
    except ValueError:
        messagebox.showerror("Erro", "Insira um valor numérico válido.")

# Função para atualizar o slider visual da posição
def atualizar_slider_visual():
    slider_visual.set(posicao_atual)

def atualizar_valores():
    global posicao_atual, angulos
    if arduino and arduino.is_open:
        try:
            if arduino.in_waiting:
                linha = arduino.readline().decode('utf-8', errors='ignore').strip()
                if "Distância" in linha and "Ângulo" in linha:
                    # Extrai os valores da mensagem
                    partes = linha.split(",")
                    for parte in partes:
                        if "Distância" in parte:
                            posicao_atual = float(parte.split(":")[1].split("cm")[0].strip())
                            label_posicao_atual.config(text=f"Posição Atual: {posicao_atual:.2f} cm")
                        elif "Ângulo" in parte:
                            angulo = float(parte.split(":")[1].split("graus")[0].strip())
                            angulos.append(angulo)  # Opcional: armazena o ângulo
                            label_angulo_atual.config(text=f"Ângulo Atual: {angulo:.2f}°")
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao ler dados do Arduino: {e}")
    
    # Reagendar a próxima atualização
    janela.after(100, atualizar_valores)  # Atualiza a cada 500 ms



# Função para finalizar a simulação e plotar os gráficos
def finalizar_simulacao():
    global posicoes_reais, posicoes_pedidas, tempos, angulos

    # Simulação de coleta de dados
    if arduino and arduino.is_open:
        try:
            while arduino.in_waiting:
                linha = arduino.readline().decode('utf-8').strip()
                if linha.startswith("P"):  # Posição real recebida
                    posicoes_reais.append(float(linha[1:]))
                elif linha.startswith("A"):  # Ângulo recebido
                    angulos.append(float(linha[1:]))
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao coletar dados: {e}")
    
    # Fecha a janela principal
    janela.destroy()

    # Plota os gráficos
    plt.figure()
    plt.plot(tempos, posicoes_pedidas, label="Posição Pedida", linestyle='--')
    plt.plot(tempos[:len(posicoes_reais)], posicoes_reais, label="Posição Real")
    plt.xlabel("Tempo (s)")
    plt.ylabel("Posição (cm)")
    plt.legend()
    plt.title("Posição do Carrinho")

    plt.figure()
    plt.plot(tempos[:len(angulos)], angulos, label="Ângulo")
    plt.xlabel("Tempo (s)")
    plt.ylabel("Ângulo (graus)")
    plt.title("Ângulo do Carrinho")
    plt.legend()

    plt.show()

# Criação da interface gráfica
janela = tk.Tk()
janela.title("Controle do Carrinho")

# Define o tamanho da janela como metade da largura e altura da tela
largura_tela = janela.winfo_screenwidth()
altura_tela = janela.winfo_screenheight()
largura_janela = largura_tela // 2
altura_janela = altura_tela // 2
pos_x = (largura_tela - largura_janela) // 2
pos_y = (altura_tela - altura_janela) // 2
janela.geometry(f"{largura_janela}x{altura_janela}+{pos_x}+{pos_y}")
janela.configure(bg="#2d4739")

# Título
titulo = tk.Label(
    janela,
    text="Controle do Carrinho",
    font=("Helvetica", 24, "bold"),
    fg="#f4a261",
    bg="#2d4739"
)
titulo.pack(pady=20)

# Frame principal
frame_principal = tk.Frame(janela, bg="#2d4739")
frame_principal.pack(expand=True)

# Representação visual da posição
label_slider_visual = tk.Label(
    frame_principal,
    text="Posição Atual (cm):",
    font=("Helvetica", 14),
    fg="#ffffff",
    bg="#2d4739"
)
label_slider_visual.pack(pady=10)

slider_visual = tk.Scale(
    frame_principal,
    from_=5, to=25,
    orient=tk.HORIZONTAL,
    font=("Helvetica", 12),
    fg="#6abf69",
    bg="#3e5f50",
    troughcolor="#2d4739",
    highlightbackground="#2d4739",
    length=largura_janela // 1.5,
    state="active"
)
slider_visual.pack(pady=10)

# Campo de entrada manual
frame_input = tk.Frame(frame_principal, bg="#2d4739")
frame_input.pack(pady=20)

label_input = tk.Label(
    frame_input,
    text="Digite a posição alvo (cm):",
    font=("Helvetica", 14),
    fg="#007acc",
    bg="#2d4739"
)
label_input.pack(side=tk.LEFT, padx=5)

entry_valor = tk.Entry(
    frame_input,
    font=("Helvetica", 14),
    bg="#3e5f50",
    fg="#ffffff",
    width=10
)
entry_valor.pack(side=tk.LEFT, padx=5)
entry_valor.bind("<Return>", enviar_valor_manual)

# Adicionar rótulos para exibir os valores
label_posicao_atual = tk.Label(
    frame_principal,
    text="Posição Atual: -- cm",
    font=("Helvetica", 14),
    fg="#ffffff",
    bg="#2d4739"
)
label_posicao_atual.pack(pady=10)

label_angulo_atual = tk.Label(
    frame_principal,
    text="Ângulo Atual: --°",
    font=("Helvetica", 14),
    fg="#ffffff",
    bg="#2d4739"
)
label_angulo_atual.pack(pady=10)

btn_enviar = tk.Button(
    frame_input,
    text="Enviar",
    command=enviar_valor_manual,
    font=("Helvetica", 14, "bold"),
    fg="#ffffff",
    bg="#007acc",
    activebackground="#6abf69",
    relief=tk.RAISED,
    bd=3
)
btn_enviar.pack(side=tk.LEFT, padx=10)

# Botão para alternar PID de Ângulo
btn_pid_angulo = tk.Button(
    frame_principal,
    text="PID de Ângulo: Ligado",
    command=alternar_pid_angulo,
    font=("Helvetica", 14, "bold"),
    fg="#ffffff",
    bg="#e76f51",
    activebackground="#f4a261",
    relief=tk.RAISED,
    bd=3
)
btn_pid_angulo.pack(pady=20)

# Botão para finalizar
btn_finalizar = tk.Button(
    frame_principal,
    text="Finalizar Simulação",
    command=finalizar_simulacao,
    font=("Helvetica", 14, "bold"),
    fg="#ffffff",
    bg="#e76f51",
    activebackground="#f4a261",
    relief=tk.RAISED,
    bd=3
)
btn_finalizar.pack(pady=20)

# Rodapé
rodape = tk.Label(
    janela,
    text="© 2024 Projetos 2 - Simulação",
    font=("Helvetica", 10),
    fg="#a0d9a0",
    bg="#2d4739"
)
rodape.pack(side=tk.BOTTOM, pady=5)

# Iniciar a atualização automática ao iniciar a interface
atualizar_valores()

janela.mainloop()

if arduino and arduino.is_open:
    arduino.close()
