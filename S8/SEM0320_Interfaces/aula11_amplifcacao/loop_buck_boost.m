close all; clear all;
clc;

%% Variaveis Originais

rs = 25e-3;
rL = 20e-3;
rc = 150e-3;
RL = 5;
C = 22e-6;
L = 1e-3;

closedLoop = 0;

% Modelo Malha Aberta
dD_med = 0.6;
dD_delta = 0.1;
omega = 100;

% Modelo Malha Fechada
kp = 10;
ki = 0;
kd = 0;
r_med = 30;
r_delta = 10;

%% Simulacao Condicional

for var = 1:2
    RL = 5;
    LL = 5e-3;

    for plt = 1:4
        sim_buck_boost(var, plt, 1);
    end
end
