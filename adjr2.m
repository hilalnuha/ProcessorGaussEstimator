function adjr2out=adjr2(a1,act2,k)
  r2x=rsquare(a1,act2);
  N=max(size(a1));
  adjr2out=1-(1-r2x)*(N-1)/(N-k);