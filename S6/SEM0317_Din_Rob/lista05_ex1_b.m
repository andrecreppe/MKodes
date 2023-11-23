clear all
close all

%{ EXERCÍCIO 1 - PARTE 2 %}

%% Dados do Problema

q_1 = 15; q_2 = 5; q_3 = -16;
t_d12 = 2; t_d23 = 3;
ddq = 60;

%% Movimentos

% Segmento 1 (primeiro)

ddq_1 = sign(q_2 - q_1) * ddq; % aceleração
t_1 = t_d12 - sqrt(t_d12.^2 - (2*(q_2 - q_1) / (ddq_1))) % tempo de junção
dq_12 = (q_2 - q_1) / (t_d12 - (0.5*t_1)) % velocidades lineares

% Segmento 2

dq_23 = (q_3 - q_2) / t_d23

ddq_2 = sign(dq_23 - dq_12) * ddq 
t_2 = (dq_23 - dq_12) / ddq_2

t_12 = t_d12 - t_1 - (0.5*t_2)


% Segmento 3 (último)

ddq_3 = sign(q_3 - q_2) * ddq;
t_3 = t_d23 - sqrt(t_d23.^2 - (2*(q_3- q_2) / (ddq_3)))
dq_23 = (q_3 - q_2) / (t_d23 - (0.5*t_3))

t_23 = t_d23 - (0.5*t_2) - (0.5*t_3)
