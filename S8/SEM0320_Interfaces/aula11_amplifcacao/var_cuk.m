clear all; close all;
clc;

Vd = 10;
rL1 = 35e-3;
rL = 30e-3;
rC = 10e-3;
rs = 30e-3;
rC1 = 10e-3;
C1 = 1e-6;
C = 22e-6;
L1 = 15e-6;
L = 47e-6;
LL = 1e-3;

% dD = [0.75, 0.25]
dD_med = 0.5;
fD = 50;

% RL = [10, 30]
RL_med = 20;
fL = 100;

% Indutancia Minima

Lmin = ((1 - dD_med)^2 * rL) / (2*fD);

% L = 1 * 1e-6; % < Lmin = 7.5000e-05
