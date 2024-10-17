close all; clear all;
clc;

% Controle dos casos de validação
valid = 1;

%% Parametros do Sistema

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

if valid == 1
    TL0 = 0;
    TL = 0.1;
elseif valid == 2
    TL0 = 0.2;
    TL = 0.5;
elseif valid == 3 % unbalanced test
    TL0 = 0.1;
    TL = 0.1;
end
