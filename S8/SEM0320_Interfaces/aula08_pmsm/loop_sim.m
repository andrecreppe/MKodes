close all; clear all;
clc;

%% Variaveis Originais

P = 4;
uM = 50;
rs = 1;
Lls = 0.2e-3;
Lmb = 1.8e-3;
psim = 0.1;
Bm = 80e-6;
Jm = 40e-6;

a1 = 1;
a2 = 0.05;
a3 = 0.02;

% TL0 = 0;
TL0 = 0.5;
% TL = 0;
TL = 0.5;

%% Simulacao Condicional

for var = 1:4
    for plt = 1:4
        sim_motor(var, plt);
    end
end
