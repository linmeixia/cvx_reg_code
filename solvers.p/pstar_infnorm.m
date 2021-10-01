function y = pstar_infnorm(x,par)
d = par.d;
n = par.n;
L = par.L;
y = 0;
if length(L) == 1
    y = L*norm(x,1);
else
    for i = 1:n
        tmpx = x((i-1)*d+1:i*d);
        y = y+L(i)*norm(tmpx,1);
    end
end