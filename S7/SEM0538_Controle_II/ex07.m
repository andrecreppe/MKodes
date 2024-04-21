T=1;
G=tf([0.1 0.1],[1 -1.1 0.3],T)
C=tf([3 -3.9 1.4],[1 -1 0],T)

figure
step((C*G)/(1+C*G))

figure
step(C/(1+C*G))
