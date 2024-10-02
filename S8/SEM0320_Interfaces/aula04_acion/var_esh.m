% Sistema Atuador Elástico-Serial Hidráulico

close all; clear all;
clc

A = 4.91e-4;
K1 = 7.5e7;
C1 = 18.4;
M = 1.5;
B = 1.23e9;
Cl = 2e-6;
Vt = 2.6e-5;
KL = 3.3e9;
CL = 8.08;
KP = 8.4e2;
Kc = 4e6;
Kv = 6.24e-5;
t = 0.0015;

Kvp = 1;
Ka = B*Vt;

Kp = 54.9946;
Ki = 4412.1219;
Kd = 0.0575;
