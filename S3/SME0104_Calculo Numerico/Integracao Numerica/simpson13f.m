function I = simpson13f(fun,a,b,N)
  % fun: funcao a ser integrada
  % [a,b]: intervalo dado
  % N: quantidade de sub-intervalos
  h = (b-a)/N;
  xi = linspace(a,b,N+1);
  yi = fun(xi);
  yi(2:end-1) = 2*yi(2:end-1);
  I = h*sum(yi)/6;
  xi = linspace(a+h/2,b-h/2,N);
  yi = fun(xi);
  I = I + 2*h*sum(yi)/3;
end
