for k=0:12
  y(k+1)=2^(k/2)*cos(pi*k/4);
end

G=tf([1 -2 1],[1 -2 2],1);
step(G,13);
