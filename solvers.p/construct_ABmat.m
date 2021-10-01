function [Amat,Bmat,mat_inv,mat_inv_2] = construct_ABmat(X,I,J,n)
Bmatcell = cell(n,1);
nnzB = 0;
d = size(X,1);

uniqueJ = unique(J);
countJ = histc(J, uniqueJ);
cumJ = cumsum(countJ);
if length(uniqueJ) == n
    for i = 1:n
        if i == 1
            Iidx = I(1:cumJ(i));
        else
            Iidx = I(cumJ(i-1)+1:cumJ(i));
        end
        nnzB = nnzB+length(Iidx);
        tmp = X(:,i)-X(:,Iidx);
        Bmatcell{i,1} = -tmp';
    end
else
    i = 1;
    for tmpj = 1:length(uniqueJ)
        while uniqueJ(tmpj) ~= i
            i = i+1;
        end
        if tmpj == 1
            Iidx = I(1:cumJ(tmpj));
        else
            Iidx = I(cumJ(tmpj-1)+1:cumJ(tmpj));
        end
        nnzB = nnzB+length(Iidx);
        tmp = X(:,i)-X(:,Iidx);
        Bmatcell{i,1} = -tmp';
        i = i+1;
    end
end
nnzB = nnzB*d;
tmp = (1:length(I))';
Amat = sparse(tmp,I,1,length(I),n);
Amat = Amat-sparse(tmp,J,1,length(I),n);

BI = zeros(nnzB,1);
BJ = zeros(nnzB,1);
Bv = zeros(nnzB,1);
stepj = 0;
for i = 1:n
    totstepj = stepj*d;
    tmp = Bmatcell{i,1};
    sj = size(tmp,1);
    dsj = d*sj;
    Bv(totstepj+1:totstepj+dsj) = tmp(:);
    BI(totstepj+1:totstepj+dsj) = repmat([stepj+1:stepj+sj]',d,1);
    BJ(totstepj+1:totstepj+dsj) = repelem([(i-1)*d+1:i*d]',sj);
    stepj = stepj+sj;
end
Bmat = sparse(BI,BJ,Bv,length(I),d*n);
if nargout > 2
    mat_inv = cell(n,1);
    mat_inv_2 = mat_inv;
    for i = 1:n
        tmp = Bmatcell{i,1}'*Bmatcell{i,1};
        if isempty(tmp)
            mat_inv{i} = eye(d);
            mat_inv_2{i} = eye(d);
        else
            mat_inv{i} = tmp^(-1);%(tmp+1e-12*eye(d))^(-1);
            mat_inv_2{i} = (eye(d)+tmp)^(-1); 
        end
    end
end
end