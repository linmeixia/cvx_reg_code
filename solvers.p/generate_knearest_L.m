function L = generate_knearest_L(X,Y,n,k,ops)
L = zeros(n,1);
if strcmp(ops,'1-norm')
    D = pdist(X','minkowski',1);
elseif strcmp(ops,'2-norm')
    D = pdist(X','minkowski',2);
elseif strcmp(ops,'inf-norm')
    D = pdist(X','minkowski',inf);
end
D = squareform(D);
for i = 1:n
    Dtmp = D(i,:);
    Dtmp(i) = inf;
    [Dtmp2,idx] = mink(Dtmp,k);
    Ytmp = Y(idx);
    Ytmp2 = abs(Ytmp-Y(i));
    L(i) = median(Ytmp2'./Dtmp2);
end
end