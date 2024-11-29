%% Exemplo 8.15 - Lyshevski
%  State feedback control of a servo with a permanent-magnet DC motor
%
%  jams, SEM/EESC/USP, 2024.

clear;close all;clc

%% -----------------------------------------------------------------------------
%  VARIÁVEIS

% Parâmetros eletromecânicos do motor:
ra = 3.15;
La = 0.0066;
ka = 0.16;
J  = 1e-04;
Bm = 1e-04;
kgear = 0.1;

u_lim = 30;

%% -----------------------------------------------------------------------------
%  MATRIZES DO SISTEMA NO ESPAÇO DE ESTADOS

% --> Matrizes do sistema no ss:
A = [ -ra/La, -ka/La, 0 ; ka/J, -Bm/J, 0 ; 0, 1, 0 ];
B = [ 1/La ; 0 ; 0 ];
H = [ 0, 0, kgear ];
sys_OL = ss( A, B, H, 0 );

% --> Matrizes de controlabilidade e de observabilidade:
C = ctrb( A, B );Crank = rank( C );
O = obsv( A, H );Orank = rank( O );

% --> Autovalores desejados:
p = [ -100, -500, -1000 ];  % -100, -500, -1000

% --> Pole assignment method using state feedback: 
%     K = place(A,B,P) computes a state-feedback matrix K such that the 
%     eigenvalues of A-B*K are those specified in the vector P:
[ KF, prec ] = place( A, B, p );

% --> Matriz do sistema em malha fechada:
Acl = A - B*KF;

% --> Autovalores do sistema em malha fechada:
E = eig( Acl );

disp( prec );
disp( E );