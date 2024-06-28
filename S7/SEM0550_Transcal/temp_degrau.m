close all; clear all
clc

% Constantes
T_inf = 25; % oC
T_ba = 58.137; % oC
T_bd = 62.3; % oC

h = 23.836; % W/m^2.K
cp = 2702; % J/kg.m^3
rho = 903; % kg/m^3

A_aleta = 4165e-6; % m^2
V_aleta = 2290.75e-9; % m^3

A_base = 3323.67e-6; % m^2
V_base = 49646.8e-9; % m^3

tau_base = (rho * V_base * cp) / (h * A_base)
tau_aleta = (rho * V_aleta * cp) / (h * A_aleta)

% Degrau
q = 75; % W
T_0 = T_inf;

% Temperaturas ao longo do tempo
min = 60; % quantos minutos de simulacao
t = 0:1:60*min; % tempo em segundos

T_base = T_inf + (T_bd - T_inf) * (1 - exp(-t / tau_base));
T_aleta = T_inf + (T_ba - T_inf) * (1 - exp(-t / tau_aleta));

% Plotagem
figure;
plot(t, T_base, 'b-', 'LineWidth', 2); hold on;
plot(t, T_aleta, 'r-', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('Temperatura (°C)');
title('Evolução da Temperatura ao Longo do Tempo');
legend('Temperatura na Base do Dissipador', 'Temperatura na Ponta da Aleta');
grid on;
