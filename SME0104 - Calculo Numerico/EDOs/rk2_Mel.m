% Euler Melhorado
function [X,Y]=rk2_Mel(func,x0,y0,N,h)
  X=zeros(1,N);
  Y=X;
  X(1)=x0;
  Y(1)=y0;
  
  for i=1:N
    k1 = func(X(i), Y(i));
    k2 = func(X(i) + h, Y(i) + (h*k1));
      
    Y(i+1) = Y(i) + (0.5 * h* (k1 + k2));
    X(i+1) = X(i) + h;
  end
end
