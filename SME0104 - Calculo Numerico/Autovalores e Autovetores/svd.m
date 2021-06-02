function [U,S,V] = svd(A)
  tol = 1e-5;
  [m,n] = size(A);
  k = min(m,n);
  S = zeros(m,n);
  [U,~] = francis(A*A',tol);
  [V,D] = francis(A'*A,tol);
  S(1:k,1:k) = diag(sqrt(D));
end
