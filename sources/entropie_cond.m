












function res=entropie_cond(X,Y,symb,sigma)
  sigma2=sigma^2;
  res=exp( - abs(Y - X)^2 / (2*sigma2) );
  res=res/sum( exp(-abs(Y-symb).^2 / (2*sigma2) ));
  res=log2(res);
end
