function [y,info] = prox_negative(x,par)
y = min(x,0);
info.rr = (x==y);
end