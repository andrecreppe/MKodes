T=1;
G=tf([0.057 0.053],[1 -1.72 0.779],T)
% [D,K]=rlocus(G,0.002,4.1,4.2);
length(D)

for k=1:length(D)
  M(k)=abs(D(1,k));
end

M(35)
Kc=4.1+35*0.002;
K=Kc/2;

figure
step((K*G)/(1+K*G))

Gc=tf([0.057 0.053],[1 -1.77 0.779],T)
K=0.154;

figure
step((K*G)/(1+K*G))
