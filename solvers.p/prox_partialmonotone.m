function [y,info] = prox_partialmonotone(x,par)
y = x;
if isfield(par,'positiveindex')
    y(par.positiveindex) = max(x(par.positiveindex),0);
end
if isfield(par,'negativeindex')
    y(par.negativeindex) = min(x(par.negativeindex),0);
end
info.rr = (y==x);
end