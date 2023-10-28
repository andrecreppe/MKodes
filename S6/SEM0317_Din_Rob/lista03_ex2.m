clc
clear all
close all

syms th1 real

J0omg = [0 0 -sin(sym(th1));
         0 0 cos(sym(th1));
         1 0 0];

R01 = [cos(sym(th1)) 0 -sin(sym(th1));
       sin(sym(th1)) 0 cos(sym(th1));
       0 -1 0];

J1omg = simplify(R01 * J0omg)