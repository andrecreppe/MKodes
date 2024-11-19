close all; clear all;
clc;

%% Variaveis Originais

Ls = 1e-3;
Rs = 1.2;
psim = 0.04;
J = 2e-5;
B = 1e-3;

%TL = 0;
TL = 0.2;

m = 2; % phase number of motor
stepsize = 30; % step angle in degree
p = 360 / (2*m*stepsize); % pole pairs (Formula 4)

theta0 = 0;
omega0 = 0;

%% Simulacao Condicional

for var = 1:4
    for plt = 1:7
        sim_motor(var, plt);
    end
end
