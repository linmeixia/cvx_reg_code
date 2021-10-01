function [mat,mat_inv,mat_inv_2] = generate_BstarBinv_X(X,XXT)
n = size(X,2);
mat = cell(n,1);
mat_inv = mat;
mat_inv_2 = mat;
Xe = X*ones(n,1);
d = size(X,1);
for i = 1:n
    Xi = X(:,i);
    XeXit = Xe*Xi';
    tmp = -XeXit-XeXit'+XXT+n*(Xi*Xi');
    mat{i} = tmp;
    mat_inv{i} = pinv(tmp);%tmp^(-1);
    mat_inv_2{i} = (eye(d)+tmp)^(-1);
end
end