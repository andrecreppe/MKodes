function [lambda,y,k] = potenciaInv(A,tol,alpha)
  if(nargin==2) 
    alpha = 0; 
  end
  
  k = 0; 
  kmax = 1000; 
  erro = inf;
  
  n = size(A,1); 
  y0 = zeros(n,1); 
  y0(1) = 1;
  
  B = A - alpha*eye(n);
  [L,U] = lu(B);
  
  while (erro>tol && k<kmax)
    x = U\(L\y0);
    y = x/norm(x);
    erro = abs(abs(y0'*y)-1);
    y0 = y; k = k+1;
  end
  
  lambda = y'*A*y;
end
