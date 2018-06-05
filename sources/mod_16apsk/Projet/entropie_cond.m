










function ent=entropie_cond(X,Y,symb,sigma)
  sigma2=sigma^2;

  n=size(X,1);
  vec=zeros(n,1);
  for k=1:n
      res=exp( - abs(Y(k) - X(k))^2 / (2*sigma2) );
      res=res/sum( exp(-abs(Y(k)-symb).^2 / (2*sigma2) ));
      res=log2(res);
      vec(k)=res;
  end
  
ent=mean(vec);
end
