function [y,info] = proxL2_mat(x,par)
d = par.d;
n = par.n;
L = par.L;
y = x;
info.flag = cell(n,1);
info.L = L;
info.xnorm = cell(n,1);
info.x = cell(n,1);
if length(L) == 1
    for i = 1:n
        xtmp = x((i-1)*d+1:i*d);
        normxtmp = norm(xtmp);
        if normxtmp <= L
            y((i-1)*d+1:i*d) = xtmp;
            info.flag{i} = 1;
        else
            y((i-1)*d+1:i*d) = (L/normxtmp)*xtmp;
            info.flag{i} = 0;
            info.xnorm{i} = normxtmp;
            info.x{i} = xtmp;
        end
    end
else
    for i = 1:n
        xtmp = x((i-1)*d+1:i*d);
        normxtmp = norm(xtmp);
        if normxtmp <= L(i)
            y((i-1)*d+1:i*d) = xtmp;
            info.flag{i} = 1;
        else
            y((i-1)*d+1:i*d) = (L(i)/normxtmp)*xtmp;
            info.flag{i} = 0;
            info.xnorm{i} = normxtmp;
            info.x{i} = xtmp;
        end
    end
end