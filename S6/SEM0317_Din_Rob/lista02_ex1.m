clear all
close all

syms nx ny nz sx sy sz ax ay az px py pz real

MATINV = [nx sx ax px
          ny sy ay py
          nz sz az pz
          0 0 0 1];

% Ex 1
syms q2 q3 d1 l2 l3 real

% transfMatrix(th, d, al, a)
A01 = transfMatrix(pi/2, d1, pi/2, 0);
A12 = transfMatrix(q2, 0, pi/2, l2);
A23 = transfMatrix(q3, 0, pi/2, l3);

A03 = A01 * A12 * A23;

M13 = A01' * MATINV;
A13 = A12 * A23;
