% Exercicio do consumo de combustivel (aula 13/Out)

cont = 1;

for v=20:0.5:30
  for m=1:1000
    C = 10*rand(1,1) + 20;
    L(m) = 90*v*(v<C) + (100*C - 10*v)*(v>=C); % if v<C else v>=C
  end

  E(cont) = mean(L)
  cont = cont + 1;
end

max(E)
