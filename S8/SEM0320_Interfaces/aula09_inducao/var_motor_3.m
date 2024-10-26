%% VARIÁVEIS - LYSHEVSKI 5.7

close all; clear all;
clc;

% PARÂMETROS:
Rs = 9.4;
Rr = 7.1;
Lm = 0.37;
Lls = 0.032;
Llr = 0.032;
J = 0.001;
P = 2;

% Matriz (alternativa) de Clarke:
KS = [ 1, 0, 0 ; 0, -1/sqrt( 3 ), 1/sqrt( 3 ) ];

% Matriz inversa:
Kabc = [1, 0; -1/2, -sqrt( 3 )/2; -1/2, sqrt( 3 )/2 ];

% Autoindutâncias:
Ls = Lm + Lls;
Lr = Lm + Llr;

% Inversor de seis passos com condução de pi[rad]: 
Vm = 220*sqrt(2); % rms -> pico

% Frequência do inversor e elétrica:
f    = 60;
slip = 0.01;

% Fases das tensões de alimentação
phi_a = 0;
phi_b = -( 2*pi/3);
phi_c = +( 2*pi/3 );

% Amplitude do torque da carga:
t = 0;
TL = 0;
% TL = 2.5;

% Verificação do valor de slip: 
wf = 2*pi*f;
we = 4*pi*f / P;
wr = (1 - slip) * we;   % verificar em estado estacionário

% Amortecimento mecânico
Bm = 0.0001;
