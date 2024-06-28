clear all

% abrir simulink -> controlador.slx

%% PARAMETROS DO MOTOR

Km = 0.288;
Bm = 817e-6; % amortecimento
Jm = 200e-6;

Lm = 1e-3; % indutancia motor
Rm = 1.6; % resistencia armadura
Tc = 0.167; % torque de coulumb

G = 107.83; % relacao de engrenamento
L = 0.8; % braço
M = 6; % massa do braço

wmax_plot = 1.534 * G;
Bmc = Bm + Tc/wmax_plot; % vel_max retirada do plot sem coulumb

Tmax = 0.9;
wmax = 165;

Jb = (L^2)*(M/3);
Jt = Jm + (Jb/G^2);

% Desconsiderando FEM
%num = [Km];
%den = [Jt Bm];
%ft_motor = tf(num, den);

% Considerando FEM
num = [Km];
den = [(Jt*Lm) (Bmc*Lm + Rm*Jt) (Rm*Bmc + Km^2)];
ft_motor = tf(num, den);

%% EFEITO GRAVITACIONAL

g = 9.81;
tau_g = (g * M * L)/(4 * G); % Média da influencia nao linear na gravidade

%% PARAMETROS CONTROLADOR DE VELOCIDADE

Ts = 0.001; % tempo de amostragem

[C1, info] = pidtune(ft_motor, 'PID');

Kp = C1.Kp
Ki = C1.Ki
Kd = C1.Kd

%% PARAMETROS CONTROLADOR DE POSICAO

vel_loop = C1*ft_motor;

[C2, info_2] = pidtune(vel_loop, 'PID');

Kpp = C2.Kp
Kip = C2.Ki
Kdp = C2.Kd

%% GERADOR DE TRAJETORIA

dt = Ts; % discretizacao do tempo = tempo de amostragem
vel_max = wmax / G; % velocidade max na perspectiva do braco

t_acel = 1; % 1 segundo -> valor empirico
acel_max = vel_max / t_acel;

distancia = 250 / G; % radianos

[t, pos, vel, acel] = ...
    gerarPerfilVelocidadeTrapezoidal(distancia, vel_max, acel_max, dt, false);

load('Trajetoria.mat')

%% FEED-FOWARD

Kff = 1;
