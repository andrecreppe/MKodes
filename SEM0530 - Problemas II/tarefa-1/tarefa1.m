# tarefa1.m

% Grafico equacao de equilibrio
i = 0:0.01:0.5;
plot(i, suspensao(i));
xlabel("u (m)");
ylabel("f(u)");
title("Grafico para a analise dos zeros de f");
pause;

% Zeros da equacao de equilibrio
int = [0 0.25];
x1 = fzero(@suspensao, int);
int = [0.25 0.5];
x2 = fzero(@suspensao, int);

plot(i, rigidez(i), 'r');
xlabel("u (m)");
ylabel("Kef(u) (N/m)");
title("Rigidez Efetiva (Kef) dado deslocamento (u)");

r1 = rigidez(x1);
r2 = rigidez(x2);
