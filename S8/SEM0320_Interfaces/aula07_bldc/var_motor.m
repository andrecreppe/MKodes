close all; clear all;
clc;

uM = 50;
TL = 0.3;
% TL = 7.335; % torque de estol

rs = 1;
Lls = 5e-4;
Lss = 5e-3;
fm = 0.15;
Bm = 5e-4;
J = 2.5e-4;
P = 4;

Lmb = Lss - Lls;
