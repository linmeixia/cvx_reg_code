function y = pstar_2norm(x,par)
d = par.d;
n = par.n;
L = par.L;
y = 0;
if length(L) == 1
    for i = 1:n
        tmpx = x((i-1)*d+1:i*d);
        y = y+norm(tmpx);
    end
    y = L*y;
else
    for i = 1:n
        tmpx = x((i-1)*d+1:i*d);
        y = y+L(i)*norm(tmpx);
    end
end