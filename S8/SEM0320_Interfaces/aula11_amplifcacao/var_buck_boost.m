clear all; close all;
clc;

rs = 25e-3;
rL = 20e-3;
rc = 150e-3;
RL = 5;
C = 22e-6;
L = 1e-3;
LL = 5e-3;

closedLoop = 1;

% Modelo Malha Aberta (closedLoop = 0)

% dD = [0.5, 0.7]
dD_med = 0.6;
dD_delta = 0.1;

omega = 100;
omega_chav = 100;

% Modelo Malha Fechada (closedLoop = 1)

kp = 10;
% ki = 0
ki = 8;
% kd = 0
kd = 0.4;

% r = [20, 40]
r_med = 30;
r_delta = 10;

% Indutancia Minima

freq = omega/(2*pi);
Lmin = ((1 - dD_med)^2 * RL) / (2*freq);

% L = 0.01; % < Lmin = 0.0251
