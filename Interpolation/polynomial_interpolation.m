function [poly,y_interp] = polynomial_interpolation(x,y,x_interp)
    if nargin == 2
        x_interp = [];
    end

    xs = x; ys = y;
    n = length(xs);
    fdd = zeros(n,n);
    fdd(:,1) = ys;
    for j = 2:n
        for i = 1:n-j+1
            fdd(i,j) = (fdd(i+1,j-1) - fdd(i,j-1)) / (xs(i+j-1) - xs(i));
        end
    end

    syms x;
    poly = fdd(1,1);
    for p = 1:n-1
        term = 1;
        for q = 1:p
            term = term * (x-xs(q));
        end
        poly = poly + fdd(1,p+1)*term;
    end
    x = x_interp;
    y_interp = double(subs(poly));
end
