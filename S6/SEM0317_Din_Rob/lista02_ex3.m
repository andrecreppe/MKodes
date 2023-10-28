clear all
close all

syms nx ny nz sx sy sz ax ay az px py pz real

MATINV = [nx sx ax px
          ny sy ay py
          nz sz az pz
          0 0 0 1];

% Ex 3
syms q1 d2 d3 q4 q5 real

AB1 = transfMatrix(q1, 0, 0, 0);
A12 = transfMatrix(-pi/2, d2, 0, 0);
A23 = transfMatrix(-pi/2, d3, pi/2, 0);
A34 = transfMatrix(q4, 0, -pi/2, 0);
A4G = transfMatrix(q5, 10, 0, 0);

ABG = AB1 * A12 * A23 * A34 * A4G;

M2G = A12' * AB1' * MATINV
A2G = A23 * A34 * A4G
