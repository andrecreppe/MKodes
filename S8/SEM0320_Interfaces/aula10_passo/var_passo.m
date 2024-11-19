clear all; close all;
clc;

Ls = 1e-3;
Rs = 1.2;
psim = 0.04;
TL = 0.2;
J = 2e-5;
B = 1e-3;

m = 2; % phase number of motor
stepsize = 30; % step angle in degree
p = 360 / (2*m*stepsize); % pole pairs (Formula 4)

theta0 = 0;
omega0 = 0;
