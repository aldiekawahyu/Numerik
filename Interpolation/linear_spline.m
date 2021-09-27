function [line_eqs, grads, y_interp] = linear_spline(x,y,x_interp)
    if nargin == 2
        x_interp = [];
    end
    xs = x; ys = y;
    
    % Sort values
    [xs,idx] = sort(xs,'ascend');
    ys = ys(idx);
    
    grads = zeros(length(xs)-1,1);
    % poly = zeros(length(x)-1,1);
    syms x
    for i = 1:length(xs)-1
        grads(i) = (ys(i+1)-ys(i)) / (xs(i+1)-xs(i));
        line_eqs(i) = ys(i) + grads(i)*(x - xs(i));
    end
    
    y_interp = zeros(length(x_interp),1);
    for i = 1:length(x_interp)
        % Find position
        j = 1;
        while x_interp(i) > xs(j) && x_interp(i) <= xs(j+1) == 0
            j = j + 1;
        end
        x = x_interp(i);
        y_interp(i) = double(subs(line_eqs(j)));
    end
end
