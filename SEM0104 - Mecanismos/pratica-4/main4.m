% main4.m
% ========== Inicializacao ==========

close all
clear all
clc

% ========== Controle ==========

% Circuito cruzado = 0 (false)
% Circuito aberto = 1 (true)
aberto = 0;

% Somente valores numericos = 0
% Roda os graficos = 1 (true)
graphics = 0;

% ========== Problema ==========

t2i = 40/180 * pi; 
w2 = 4 * pi;
alpha2 = 0;
rho = 3;

% nUSP = 118029(72)
del = (72/4);

a = (40 - del)/1000; % mm -> m
b = (120 + del)/1000;
c = (80 - del)/1000;
d = (100 + del)/1000;

m2 = rho*a;
m3 = rho*b;
m4 = rho*c;

Ig2 = m2*(a^2)/12;
Ig3 = m3*(b^2)/12;
Ig4 = m4*(c^2)/12;

% ========== Simulacao ==========

% Chutes iniciais
if aberto
    t3 = 20.30/180 * pi ; t4 = 57.33/180 * pi;
else
    t3 = -60.98/180 * pi; t4 = -98.01/180 * pi;
end

% Passos e Tolerancia
N = 1000;
tol = 0.001;

t=linspace(0,1,N)';

t2v = t2i+w2*t; 
w2v = w2*ones(size(t)); 
a2v = zeros(size(t));

% ===============================

% Metodo de Newton-Raphson
for it2 = 1:length(t2v)
   t2 = t2v(it2); 
   B1 = tol+1; 
   iconv=0;
   
   while norm(B1)>tol
       iconv=iconv+1;
       A1 = [-b*sin(t3) c*sin(t4); b*cos(t3) -c*cos(t4)];
       B1 = [a*cos(t2)+b*cos(t3)-c*cos(t4)-d ; a*sin(t2)+b*sin(t3)-c*sin(t4)];
       Dt = -A1\B1;
       t3 = t3+Dt(1); t4 = t4+Dt(2);
   end
   
   t3v(it2,1)= t3; 
   t4v(it2,1)= t4;

   % Velocidades Angulares
   w3 = (a/b)*w2*((sin(t4-t2))/(sin(t3-t4)));
   w4 = (a/c)*w2*((sin(t2-t3))/(sin(t4-t3)));
   w3v(it2,1)= w3;
   w4v(it2,1)= w4;

   % Velocidades Lineares
   vA = a*w2; 
   vB = c*w4; 
   vAv(it2,1) = vA; 
   vBv(it2,1) = vB;
   
   % Aceleracoes Angulares
   A = c*sin(t4);
   B = b*sin(t3);
   C = a*alpha2*sin(t2) + a*(w2)^2*cos(t2) + b*(w3)^2*cos(t3) - c*(w4)^2*cos(t4);
   D = c*cos(t4);
   E = b*cos(t3);
   F = a*alpha2*cos(t2) - a*(w2)^2*sin(t2) - b*(w3)^2*sin(t3) + c*(w4)^2*sin(t4);
   alpha3 = ((C*D)-(A*F))/((A*E)-(B*D)); 
   alpha4 = ((C*E)-(B*F))/((A*E)-(B*D)); 

   % Aceleracoes dos CMs
   a2x = - (w2^2)*(a/2)*cos(t2);
   a2y = - (w2^2)*(a/2)*sin(t2);   
   
   a3x = 2*a2x - alpha3*(b/2)*sin(t3) - (w3^2)*(b/2)*cos(t3);
   a3y = 2*a2y + alpha3*(b/2)*cos(t3) - (w3^2)*(b/2)*sin(t3);
   
   a4x = - alpha4*(c/2)*sin(t4) - (w4^2)*(c/2)*cos(t4);
   a4y = - alpha4*(c/2)*cos(t4) - (w4^2)*(c/2)*sin(t4);  
   
   % Raios
   R12x = -(a/2)*cos(t2); R12y = -(a/2)*sin(t2); 
   R32x = -R12x; R32y = -R12y;
   R23x = -(b/2)*cos(t3); R23y = -(b/2)*sin(t3);
   R43x = -R23x; R43y = -R23y;
   R14x = -(c/2)*cos(t4); R14y = -(c/2)*sin(t4);
   R34x = -R14x; R34y = -R14y;

   % Sistema Linear do Problema
   Matb = [ m2*a2x; m2*a2y; Ig2*alpha2; m3*a3x; m3*a3y; Ig3*alpha3; 
   m4*a4x; m4*a4y; Ig4*alpha4];
   
   MatA = [-1 0 1 0 0 0 0 0 0; 
   0 -1 0 1 0 0 0 0 0; 
   R12y -R12x -R32y R32x 0 0 0 0 1;
   0 0 -1 0 1 0 0 0 0;
   0 0 0 -1 0 1 0 0 0; 
   0 0 R23y -R23x -R43y R43x 0 0 0; 
   0 0 0 0 -1 0 -1 0 0; 
   0 0 0 0 0 -1 0 -1 0;
   0 0 0 0 R34y -R34x R14y -R14x 0];
   
   MatX = MatA\Matb;
   
   F21x = MatX(1);
   F21y = MatX(2);
   F41x = MatX(7);
   F41y = MatX(8);
   T12 = MatX(9);
   F21 = (F21x^2 + F21y^2)^1/2;
   F41 = (F41x^2 + F41y^2)^1/2; 
   
   T12v(it2,1) = T12;
   F21xv(it2,1) = F21x;
   F21yv(it2,1) = F21y;
   F21v(it2,1) = F21;
   F41xv(it2,1) = F41x;
   F41yv(it2,1) = F41y;
   F41v(it2,1) = F41; 
end

% ========== Resultados ==========

% Torque Elo 2
min_T12 = min(T12v)
max_T12 = max(T12v)

% Força Apoio 2
min_F21x = min(F21xv)
max_F21x = max(F21xv)
min_F21y = min(F21yv)
max_F21y = max(F21yv)
min_F21 = min(F21v)
max_F21 = max(F21v)

% Força Apoio 4
min_F41x = min(F41xv)
max_F41x = max(F41xv)
min_F41y = min(F41yv)
max_F41y = max(F41yv)
min_F41 = min(F41v)
max_F41 = max(F41v)

% ========== Graficos ==========

if graphics
    % Torque Elo 2
    figure
    plot(t, T12v, 'g')
    
    grid on
    xlabel('Tempo (s)')
    ylabel('Torque (N.m)')
    title('Torque Elo 2 x Tempo')

    % Força Apoio 2
    figure
    plot(t, F21xv, 'b')
    hold on
    plot(t, F21yv, 'r')
    hold off
    
    grid on
    legend('x', 'y');
    xlabel('Tempo (s)')
    ylabel('Força (N)')
    title('Força Apoio 2 x Tempo')

    % Força Apoio 2 (modulo)
    figure
    plot(t, F21v, 'm')
    
    grid on
    xlabel('Tempo (s)')
    ylabel('Força (N)')
    title('Força Apoio 2 (em modulo) x Tempo')

    % Força Apoio 4
    figure
    plot(t, F41xv, 'k')
    hold on
    plot(t, F41yv, 'color', [1 0.5 0])
    hold off
    
    grid on;
    legend('Componente X', 'Componente Y');
    xlabel('Tempo (s)')
    ylabel('Força (N)')
    title('Força Apoio 4 x Tempo')

    % Força Apoio 4 (modulo)
    figure
    plot(t, F41v, 'c')
    grid on
    
    xlabel('Tempo (s)')
    ylabel('Força (N)')
    title('Força Apoio 4 (em modulo) x Tempo')
end
