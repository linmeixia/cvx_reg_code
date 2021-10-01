function u = projection_simplex(v,n)
r = sort(v,'descend');
j = 1;
s = r(1);
signal = 1;
while (signal == 1)&&(j < n)
    s = s+r(j+1);
    if  s-(j+1)*r(j+1)<1
        j = j+1;
    else 
        signal = 0;
    end
end
if j ~= n
    s = s-r(j+1);
end
q = (s-1)/j;
u = zeros(n,1);
for i = 1:n
    d = v(i)-q;
    if d > 0
        u(i) = d;
    end
end
end