clc; clear all; close all;

%% Cinemática Direta Simbólica

% Descrição das variáveis simbólicas

syms q1 q2 q3 q4
syms l1 l2 l4

% Parâmetros de DH: theta d a alpha

DH = [ 0   l1   0    pi/2 ;
       0   l2   0   -pi/2 ;
       0   0    0    pi/2 ;
       0   l4   0    0   ];
   
% Criação dos links do robô
% Formato da criação theta d a alpha tipo offset

L(1) = Link([DH(1,:) 0 0],'standard'); 
L(2) = Link([DH(2,:) 0 0],'standard');
L(3) = Link([DH(3,:) 1 0],'standard'); % prismática
L(4) = Link([DH(4,:) 0 0],'standard');

% Criação do modelo do robô

q0 = [q1 q2 q3 q4];
coletor = SerialLink(L,'name','Coletor');

%Cálculo da cinemática direta

T = coletor.fkine(q0);
A_01 = L(1).A(q1);
A_12 = L(2).A(q2);
A_23 = L(3).A(q3);
A_34 = L(4).A(q4);

A_04 = simplify(A_01 * A_12 * A_23 * A_34)

%% Cinemática Direta Analítica / Simulação

% Parâmetros de DH: theta d a alpha

l1 = 2; l2 = 1; l4 = 1;
DH = [ 0   l1   0    pi/2 ;
       0   l2   0   -pi/2 ;
       0   0    0    pi/2 ;
       0   l4   0    0   ];
   
% Criação dos links do robô

L(1) = Link([DH(1,:) 0 0],'standard'); 
L(2) = Link([DH(2,:) 0 0],'standard');
L(3) = Link([DH(3,:) 1 0],'standard'); % prismática
L(4) = Link([DH(4,:) 0 0],'standard');

% Definindo os limites das juntas

L(1).qlim = [-170 170]*pi/180;
L(2).qlim = [-170 170]*pi/180;
L(3).qlim = [5 40]*0.0254;
L(4).qlim = [-170 170]*pi/180;

% Criação do modelo do robô

%q = [pi/4 0 1.0 0];
q = [0 0 0 0];
coletor = SerialLink(L, 'name', 'Coletor');

% Plot do robô

coletor.teach(q)

%% Cinemática Inversa

T_1 = coletor.fkine(q)
qi_1 = coletor.ikine(T_1, 'mask', [1 1 1 0 0 1])

qd = [pi/3, pi/4, 0.5, -pi/2];

T_2 = coletor.fkine(qd)
qi_2 = coletor.ikine(T_2, 'mask', [1 1 1 0 0 1])

coletor.teach(qd)
