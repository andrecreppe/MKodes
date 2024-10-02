close all; clear all;
clc

syms x(t) f;
T3 = diff(x, 3);
T2 = diff(x, 2);
T1 = diff( x );

exemplo = 1;

switch exemplo
    case 1
    % Ex. 01:
        sol = dsolve( T3 + 2*T1 + 3*x == 10*f );
        pretty(sol);
    case 2
        % Ex. 01 com CI's:
        sol = dsolve( T3 + 2*T1 + 3*x == 10*f, T2(0) == 5, T1(0) == 15, x(0) == -20 ); 
        pretty(sol);
    case 3
    % Ex. 01 com CI's e termo forçante:
        sol = dsolve( T3 + 2*T1 + 3*x == 50*cos(5*t), T2(0) == 5, T1(0) == 15, x(0) == -20 ); 
        pretty(simplify( sol));
end
