function [poly, coefs, y_interp] = lagrange_interpolation(x,y,n,x_interp)
    if nargin == 3
        x_interp = [];
    end
    xs = x; ys = y;
    poly = 0;
    coefs = zeros(length(xs),1);
    coef = 1;
    for i = 1:n+1
        product = ys(i);        
        syms x;       
        for j = 1:n+1
            if i ~= j
                product = product*(x-xs(j))/(xs(i)-xs(j));
                coef = coef*(xs(i)-xs(j));
            end
        end        
        coefs(i) = ys(i)/coef;
        coef = 1;
        poly = poly+product;
    end
    x = x_interp;
    y_interp = double(subs(poly));
end
