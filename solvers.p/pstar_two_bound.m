function y = pstar_two_bound(x,par)
LB = par.LB;
UB = par.UB;
d = par.d;
n = par.n;
y = zeros(n,1);
for i = 1:n
    tmpx = x((i-1)*d+1:i*d);
    y(i) = sum(max(UB.*tmpx,LB.*tmpx));
end
y = sum(y);
end