close all; clear all;
clc;

%% Variaveis Originais

ra = 3.15;
La = 0.0066;
ka = 0.16;
J  = 1e-04;
Bm = 1e-04;
kgear = 0.1;

% --> Matrizes do sistema no ss:
A = [ -ra/La, -ka/La, 0 ; ka/J, -Bm/J, 0 ; 0, 1, 0 ];
B = [ 1/La ; 0 ; 0 ];
H = [ 0, 0, kgear ];
sys_OL = ss( A, B, H, 0 );

% --> Matrizes de controlabilidade e de observabilidade:
C = ctrb( A, B );Crank = rank( C );
O = obsv( A, H );Orank = rank( O );

%% Simulacao Condicional

for var = 1:4
    p = [ -100, -500, -1000 ];
    u_lim = 30;

    for plt = 1:2
        sim_estado(var, plt, 1);
    end
end
