function [x,k]=gaussSeidel(A,b,x0,tol)
  L = tril(A); R = triu(A,1);
  C = -L\R;
  g = L\b;
  kmax = 10000; k = 0;
  
  while (norm(b-A*x0)>tol && k<kmax)
    k = k+1;
    x0 = C*x0+g;
  end
  
  if (k == kmax)
    disp('Erro: o metodo nao converge.');
    return;
  end
  
  x = x0;
end
