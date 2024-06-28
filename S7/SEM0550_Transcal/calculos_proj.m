close all; clear all;
clc;

% Propriedades

T_inf = 298; % K
P_atm = 1e5; % Pa
rho_ar = 1.17; % kg/m^3
mu_ar = 1.841e-5; % Pa.s
cp_ar = 1004.66; % J/kg.m^3

rho_al = 2702; % kg/m^3
cp_al = 903; % J/kg.m^3
e_al = 0.82; % -
k_al = 180; % W/m.K

% Dimensões

L = 25e-3; % m
t = 1.1e-3; % m
w = 83.30e-3; % m

%% Coeficiente Convectivo

h = 23.836;

T_ba = 58.137;
T_bd = 62.3;

%% Efetividade

P = 2*L + 2*w;
A_c = w * t;

m = sqrt((h*P)/(k_al*A_c));

theta_b = T_ba - T_inf;
M = sqrt(h*P*k_al*A_c) * theta_b;

q_f = M * tanh(m*L);
eps_f = q_f / (h*A_c*theta_b)

%% Eficiencia

eta_f = tanh(m*L) / (m*L);
eta_f = eta_f * 100
