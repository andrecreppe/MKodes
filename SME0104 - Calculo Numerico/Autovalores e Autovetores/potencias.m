function [lambda,y,k] = potencias(A,tol)
  k = 0; 
  kmax = 1000; 
  erro = inf;
  
  n = size(A,1); 
  y0 = zeros(n,1); 
  y0(1) = 1;
  
  while (erro>tol && k<kmax)
    x = A*y0;
    y = x/norm(x);
    erro = abs(abs(y0'*y)-1);
    y0 = y; k = k+1;
  end
  
  lambda = y'*A*y;
end
