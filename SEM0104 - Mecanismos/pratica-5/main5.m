% main5.m
% ========== Inicializacao ==========

clear all;
clc;

% ========== Problema ==========

P1 = [0 0];
P2 = [-1.236 2.138];
P3 = [-2.5 2.931];
beta2 = (pi/180)*(30);
beta3 = (pi/180)*(60);
gamma2 = (pi/180)*(-10);
gamma3 = (pi/180)*(25);

% ========== Calculos Iniciais ==========

ref = [1 0];
p2 = sqrt((-1.236)^2+(2.138)^2);
p3 = sqrt((-2.5)^2+(2.931)^2);

phi2 = acos(((P2(1,1)*ref(1,1))+(P2(1,2)*ref(1,2)))/(p2)); 
phi3 = acos(((P3(1,1)*ref(1,1))+(P3(1,2)*ref(1,2)))/(p3));
alfa2 = (pi/180)*(147.5 - 210);
alfa3 = (pi/180)*(110.2 - 210);

% ========== Sistema I ==========

A = cos(beta2)-1;
B = sin(beta2);
C = cos(alfa2)-1;
D = sin(alfa2);
E = p2*cos(phi2);
F = cos(beta3)-1;
G = sin(beta3);
H = cos(alfa3)-1;
K = sin(alfa3);
L = p3*cos(phi3);
M = p2*sin(phi2);
N = p3*sin(phi3);

a = [A -B C -D ; F -G H -K ; B A D C ; G F K H];
b = [E;L;M;N];
sol = pinv(a)*b;

W1 = [sol(1,1) sol(2,1)]; 
Z1 = [sol(3,1) sol(4,1)];
w = sqrt((W1(1))^2+(W1(2))^2);
z = sqrt((Z1(1))^2+(Z1(2))^2);

clearvars A B C D E F G H K L M N a b sol;

% ========== Sistema II ==========

A = cos(gamma2)-1;
B = sin(gamma2);
C = cos(alfa2)-1;
D = sin(alfa2);
E = p2*cos(phi2);
F = cos(gamma3)-1;
G = sin(gamma3);
H = cos(alfa3)-1;
K = sin(alfa3);
L = p3*cos(phi3);
M = p2*sin(phi2);
N = p3*sin(phi3);

a = [A -B C -D ; F -G H -K ; B A D C ; G F K H];
b = [E;L;M;N];
sol = pinv(a)*b;

U1 = [sol(1,1) sol(2,1)]; 
S1 = [sol(3,1) sol(4,1)]; 
u = sqrt((U1(1))^2+(U1(2))^2); 
s = sqrt((S1(1))^2+(S1(2))^2);

clearvars A B C D E F G H K L M N a b sol;

% ========== Resultados ==========

theta = atan2(W1(2), W1(1));
phi = atan2(Z1(2), Z1(1));
sigma = atan2(U1(2), U1(1));
psi = atan2(S1(2), S1(1));

O2 = [((-z*cos(phi))-(w*cos(theta))) ((-z*sin(phi))-(w*sin(theta)))];
O4 = [((-s*cos(psi))-(u*cos(sigma))) ((-s*sin(psi))-(u*sin(sigma)))];

V1 = Z1 - S1; 
v = sqrt((V1(1))^2+(V1(2))^2);
G1 = W1 + V1 - U1; 
g = sqrt((G1(1))^2+(G1(2))^2);
theta1 = atan2(G1(2), G1(1));
theta3 = atan2(V1(2), V1(1));
theta2i = theta - theta1;
theta2f = theta2i + beta3;
oinic = theta - theta1;
ofinal = oinic + beta3;
rp = z;
deltap = phi - theta3;

% ========== Apresentacao ==========

fprintf('========== Comprimentos ========== \n')
fprintf('Elo de atuacao (w): %.3f \n', (w))
fprintf('Elo de acoplamento (v): %.3f \n', (v))
fprintf('Elo de saida (u): %.3f \n', (u))
fprintf('Entre os pivos fixos (g): %.3f \n', (g))
fprintf('Ponteira (z): %.3f \n', (z))

fprintf('\n========== Angulos (graus) ========== \n')
fprintf('Elo de Atuacao: %.3f \n', ((180/pi)*(theta)))
fprintf('Elo de Acoplamento: %.3f \n', ((180/pi)*(theta3)))
fprintf('Elo de Saida: %.3f \n', ((180/pi)*(sigma)))
fprintf('Vetor G: %.3f \n', ((180/pi)*(theta1)))
fprintf('Ponteira: %.3f \n', ((180/pi)*(deltap)))
fprintf('Inicial em relacao a G: %.3f \n', ((180/pi)*(theta2i)))
fprintf('Final em relacao a G: %.3f \n', ((180/pi)*(theta2f)));

clearvars P1 P2 P3 Lb Ld alfa2 alfa3 beta2 beta3 gama2 gama3 phi2 phi3 ref p2 p3 psi sigma s u w;
