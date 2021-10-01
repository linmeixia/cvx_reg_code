function y = BstarBinv_X_2(rhs,d,n,mat_inv,mat_inv_2,flag)
y = rhs;
for i = 1:n
    tmp = rhs((i-1)*d+1:i*d);
    if flag
        y((i-1)*d+1:i*d) = mat_inv_2{i}*tmp;
    else
        y((i-1)*d+1:i*d) = mat_inv{i}*tmp;
    end
end
end