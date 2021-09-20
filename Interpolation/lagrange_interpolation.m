function [poly,y_interp] = lagrange_interpolation(x,y,n,x_interp)
    if nargin == 3
        x_interp = [];
    end
    xs = x; ys = y;
    poly = 0;
    for i = 1:n+1
        product = ys(i);
        syms x;
        for j = 1:n+1
            if i ~= j
                product = product*(x-xs(j))/(xs(i)-xs(j));
            end
        end
        poly = poly+product;
    end
    x = x_interp;
    y_interp = double(subs(y));
end
