function [x,k] = gradientes(A,b,x0,tol)
  % A: matriz SPD
  kmax = 1000;
  
  for k=1:kmax
    r = b - A*x0;
    
    if norm(r)<tol
      x = x0;
      k = k-1;
      return;
    end
    
    alpha = (r'*r)/(r'*A*r);
    x0 = x0 + alpha*r;
  end
  
  disp('Erro: o metodo nao converge.');
end
