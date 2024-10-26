%% VARI�VEIS - LYSHEVSKI 5.5

close all; clear all;
clc;

% PAR�METROS:
Rs = 0.8;
Rr = 1;
Lm = 0.1;
Lls = 0.01;
Llr = 0.01;
J = 0.002;
P = 2;

% Matriz (alternativa) de Clarke:
KS = [ 1, 0, 0 ; 0, -1/sqrt( 3 ), 1/sqrt( 3 ) ];

% Matriz inversa:
Kabc = [1, 0; -1/2, -sqrt( 3 )/2; -1/2, sqrt( 3 )/2 ];

% Autoindut�ncias:
Ls = Lm + Lls;
Lr = Lm + Llr;

% Inversor de seis passos com condu��o de pi[rad]: 
Vm = 220*sqrt(2); % rms -> pico

% Frequ�ncia do inversor e el�trica:
f    = 60;
slip = 0.01;

% Fases das tens�es de alimenta��o
phi_a = 0;
phi_b = -( 2*pi/3);
phi_c = +( 2*pi/3 );

% Amplitude do torque da carga:
t = 0.7;
TL = 20;

% Verifica��o do valor de slip: 
wf = 2*pi*f;
we = 4*pi*f / P;
wr = (1 - slip) * we;   % verificar em estado estacion�rio

% Amortecimento mec�nico
Bm = 4e-4;
