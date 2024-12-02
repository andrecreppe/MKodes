% Variáveis de Simulação
% Questão 2 - Massa Girando

close all; clear all;
clc;

m = 100;
r = 1;
f = 60;
Tr = 50;
ta = 10;

% Contas perguntas

omega = (2*pi*f)/60;
Pmec = Tr * omega;

J = 1/2 * m * r^2;
alpha = omega/ta;

Ta = 50 * alpha;
Ttotal = Tr + Ta;

% Variaveis Simulacao

B = Tr/omega;

Vs = 58e3; % tentativa-erro
