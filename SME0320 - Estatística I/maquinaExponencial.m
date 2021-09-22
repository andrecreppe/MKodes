close all
clear all

p = 0.5;
size = 30;

p0 = [1 zeros(1, size)];
L = diag(p * ones(size, 1), 1) - diag(p * ones(size+1, 1));

pf = p0 * expm(L * size);
plot(pf);
