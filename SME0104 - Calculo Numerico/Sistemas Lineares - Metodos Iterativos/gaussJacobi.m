function [x,k] = gaussJacobi(A,b,x0,tol)
  n = size(A,1);
  D = diag(diag(A));
  C = eye(n)-D\A;
  g = D\b;
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
