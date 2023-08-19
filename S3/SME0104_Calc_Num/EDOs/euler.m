function [X,Y]=euler(func,x0,y0,N,h)
  X=zeros(1,N);
  Y=X;
  X(1)=x0;
  Y(1)=y0;
  
  for i=1:N
    Y(i+1) = Y(i) + h*func(X(i),Y(i));
    X(i+1) = X(i) + h;
  end
end
