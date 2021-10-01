function [y,info] = proxL1_mat(x,par)
d = par.d;
n = par.n;
L = par.L;
y = x;
info.rr = cell(n,1);
info.flag = cell(n,1);
info.P = cell(n,1);
if length(L) == 1
    for i = 1:n
        xtmp = x((i-1)*d+1:i*d);
        if norm(xtmp,1) <= L
            y((i-1)*d+1:i*d) = xtmp;
            info.flag{i} = 0;
        else
            info.P{i} = sign(xtmp);
            xtmpdL = abs(xtmp)/L;
            xtmp2 = projection_simplex(xtmpdL,d);
            y((i-1)*d+1:i*d) = L*(info.P{i}.*xtmp2);
            info.rr{i} = (xtmp2~=0);%~(xtmp2<1e-12);
            info.flag{i} = sum(info.rr{i});
        end
    end
else
    for i = 1:n
        xtmp = x((i-1)*d+1:i*d);
        if norm(xtmp,1) <= L(i)
            y((i-1)*d+1:i*d) = xtmp;
            info.flag{i} = 0;
        else
            info.P{i} = sign(xtmp);
            xtmpdL = abs(xtmp)/L(i);
            xtmp2 = projection_simplex(xtmpdL,d);
            y((i-1)*d+1:i*d) = L(i)*(info.P{i}.*xtmp2);
            info.rr{i} = (xtmp2~=0);%~(xtmp2<1e-12);
            info.flag{i} = sum(info.rr{i});
        end
    end
end