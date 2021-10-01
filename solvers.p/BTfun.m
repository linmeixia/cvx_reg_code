function y = BTfun(u,X,d,n)
y = X*u-X.*sum(u);
y = y(:);
end