function [V,D] = francis(A,tol)
  n = size(A,1);
  V = eye(n);
  erro = inf;
  
  while erro>tol
    [Q,R] = qrDecompMod(A);
    A = R*Q;
    V = V*Q;
    erro = max(max(abs(tril(A,-1))));
  end
  
  D = diag(A);
end
