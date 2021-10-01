function y = Bfun(xi,X,d,n)
xi = reshape(xi,d,n);
y = X'*xi-sum(X.*xi,1);
end