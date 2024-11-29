close all; clear all;
clc;

%% Variaveis Originais

ia_max = 0.15;
omegar_max = 150;
ra = 200;
La = 2e-3;
ka = 0.2;
J = 80e-9;
Bm = 50e-9;
kgear = 1/100;

kp = 25e3;
ki = 250;
kd = 0;

rt = 1;
TL = 0.02;

%% Simulacao Condicional

for var = 1:4
    g = 1;
    q = 1;
    u_max = 30;
    u_min = 0;
    kd = 0;

    for plt = 1:5
        sim_pid(var, plt, 1);
    end
end
