%% VARIÁVEIS - VALIDAÇÃO DO MODELO

close all; clear all;
clc;

% PARÂMETROS:
Rs = 0.087;
Rr = 0.228;
Lm = 34.7e-03;
Lls = 0.8e-03;
Llr = 0.8e-03;
J = 1.662;
P = 4;

% Matriz (alternativa) de Clarke:
KS = [ 1, 0, 0 ; 0, -1/sqrt( 3 ), 1/sqrt( 3 ) ];

% Matriz inversa:
Kabc = [1, 0; -1/2, -sqrt( 3 )/2; -1/2, sqrt( 3 )/2 ];

% Autoindutâncias:
Ls = Lm + Lls;
Lr = Lm + Llr;

% Inversor de seis passos com condução de pi[rad] e Um = 460V: 
Vm = ( 4/pi ) * 460;

% Frequência do inversor e elétrica:
f    = 60;
slip = 0.01;

% Fases das tensões de alimentação
phi_a = 0;
phi_b = -( 2*pi/3);
phi_c = +( 2*pi/3 );

% Amplitude do torque da carga:
t = 2;
TL = 100;
% TL = 200;

% Verificação do valor de slip: 
wf = 2*pi*f;
we = 4*pi*f / P;
wr = (1 - slip) * we;   % verificar em estado estacionário

% Amortecimento mecânico
Bm = 0;
