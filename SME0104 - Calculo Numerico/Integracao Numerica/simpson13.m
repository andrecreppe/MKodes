function I = simpson13(xi,yi)
  % xi: igualmente espacados e qtdade impar de pontos
  h = xi(2)-xi(1);
  I = 4*sum(yi(2:2:end-1)) + 2*sum(yi(3:2:end-2));
  I = h*(yi(1) + I + yi(end))/3 ;
end
