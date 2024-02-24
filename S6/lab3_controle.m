clear all
close all

G = tf([0.333], [0.005 0.189]);
%bode(G)

G1 = tf([0.333], [0.005 0.189 0]);
%hold on
%bode(G1)

Kp = 158.5;
G2 = Kp * G1;
%bode(G2)

dphi = 75-21;
omegam = 100;
tp = tan((dphi * pi) / 180);
beta = tp + sqrt(tp.^2 + 1);

C = beta * tf([1 omegam/beta], [1 beta*omegam]);
G3 = G2 * C;
%bode(G3)

T = feedback(G3, 1)
bode(T)
