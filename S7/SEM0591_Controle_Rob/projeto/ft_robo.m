%% PARAMETROS DO MOTOR

Km = 7.19e-3;
Bm = 817e-6;
Jm = 9.19e-7;

G = 92.33;

Tmax = 10.28e-3;
wmax = 11000*(pi/30);

% L = 0.8
% M = 6
% 
% Jb = (L*L)*M/3
% 
% Jt = Jm + Jb/(G*G)

num = [Km];
den = [Jm Bm];

ft_motor = tf(num, den)

% %% EFEITO GRAVITACIONAL
% g = 9.81
% tau_g = g*(L*L)*M/(6*G)
% 
% %% PARAMETROS CONTROLADOR DE VELOCIDADE
% 
% Ts = 0.001
% Kp = 0.00374*G*0.8
% Ki = 0.0295*G*0.8
% 
% [C, info] = pidtune(ft_motor, 'PI')

M1.Kp = 1e-6;
M1.Ki = 1e-6;
M1.Kd = 1e-6;

M2.Kp = 5e-7;
M2.Ki = 5e-8;
M2.Kd = 2e-6;

M3.Kp = 1e-6;
M3.Ki = 1e-6;
M3.Kd = 1e-6;
