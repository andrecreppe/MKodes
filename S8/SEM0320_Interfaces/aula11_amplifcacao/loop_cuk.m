close all; clear all;
clc;

%% Variaveis Originais

Vd = 10;
rL1 = 35e-3;
rC = 10e-3;
rs = 30e-3;
rC1 = 10e-3;
C1 = 1e-6;
C = 22e-6;
L1 = 15e-6;
L = 47e-6;

fD = 50;
RL_med = 20;
fL = 100;

%% Simulacao Condicional

for var = 1:2
    rL = 30e-3;
    LL = 1e-3;

    for plt = 1:6
        sim_cuk(var, plt, 1);
    end
end
