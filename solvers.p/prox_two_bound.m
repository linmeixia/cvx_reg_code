function [y,info] = prox_two_bound(x,par)
LB = par.LB;
UB = par.UB;
n = par.n;
LB = repmat(LB,n,1);
UB = repmat(UB,n,1);
y = max(x,LB);
y = min(y,UB);
info.rr = (x==y);
end