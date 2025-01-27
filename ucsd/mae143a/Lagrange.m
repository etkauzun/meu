function [f] = Lagrange(x, xd, fd)
    n = length(xd); 
    m = length(x); 
    f = zeros(size(x));
    for j = 1:m
        for k = 1:n
            L = 1; 
            for i = 1:n
                if i ~= k
                    L = L * (x(j) - xd(i)) / (xd(k) - xd(i));
                end
            end
            f(j) = f(j) + fd(k) * L;
        end
end