% Variáveis de Simulação
% Questão 1 - Esteira de Transporte

close all; clear all;
clc;

m = 200;
v = 0.75;
mu = 0.05;
TN = 10;
d = 0.15;

r = d/2;
g = 9.81;

% Contas perguntas

Fa = mu * m * g;
Pmec = Fa * v;
Tm = Fa * r;

% Variaveis Simulacao

B = Fa/v;

Vs = 2.1e3;
