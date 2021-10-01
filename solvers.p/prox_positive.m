function [y,info] = prox_positive(x,par)
y = max(x,0);
info.rr = (x==y);
end