clear all
close all

syms nx ny nz sx sy sz ax ay az px py pz real

MATINV = [nx sx ax px
          ny sy ay py
          nz sz az pz
          0 0 0 1];

% Ex 2
syms q1 d1 q2 d3 q4 q5 d5 real

A01 = transfMatrix(q1, d1, -pi/2, 0);
A12 = transfMatrix(q2, 0, pi/2, 0);
A23 = transfMatrix(pi, d3, pi/2, 0);
A34 = transfMatrix(q4, 0, pi/2, 0);
A45 = transfMatrix(q5, d5, 0, 0);

A05 = A01 * A12 * A23 * A34 * A45;

M25 = A12' * A01' * MATINV;
A25 = A23 *  A34 * A45;

M35 = A23' * A12' * A01' * MATINV;
A35 = A34 * A45;
