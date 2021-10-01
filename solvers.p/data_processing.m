function [X,Y,meanX,normX,meanY,normY] = data_processing(X,Y,options)
d = size(X,1);
if options.scale == 1
    meanY = mean(Y);
    Y = Y-meanY;
    meanX = mean(X,2);
    for i = 1:d
        X(i,:) = X(i,:)-meanX(i);
    end
    normY = norm(Y);
    normX = sum(X.^2,2).^(1/2);
    Y = Y/normY;
    for i = 1:d
        X(i,:) = X(i,:)/normX(i);
    end
else
    meanY = 0;
    meanX = zeros(d,1);
    normY = 1;
    normX = ones(d,1);
end
end