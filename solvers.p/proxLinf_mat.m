function [y,info] = proxLinf_mat(x,par)
d = par.d;
n = par.n;
L = par.L;
y = x;
if length(L) == 1
    for i = 1:n
        xtmp = x((i-1)*d+1:i*d);
        if L == 0
            y((i-1)*d+1:i*d) = 0;
        else
            y((i-1)*d+1:i*d) = max(-L,min(xtmp,L));
        end
    end
    info.rr = (abs(x)<=L);
else
    info.rr = x;
    for i = 1:n
        xtmp = x((i-1)*d+1:i*d);
        if L(i) == 0
            y((i-1)*d+1:i*d) = 0;
        else
            y((i-1)*d+1:i*d) = max(-L(i),min(xtmp,L(i)));
        end
        info.rr((i-1)*d+1:i*d) = (abs(xtmp)<=L(i));
    end
end