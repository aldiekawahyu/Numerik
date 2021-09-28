function [polynomials, intervals, y_interp] = quadratic_spline(x,y,x_interp)
    % Function
    xs = x; ys = y;

    % Sort values
    [xs,idx] = sort(xs,'ascend');
    ys = ys(idx);

    n = length(xs)-1; % The number of interval
    A = zeros(3*n-1);
    B = zeros(3*n-1,1);

    % The function values of adjacent polynomials
    % must be equal at the interior knots.
    flag = 0;
    j = 3;
    k = 1;
    for i = 1:2*(n-1)
        if i == 1
            A(1, 1:2) = [xs(2), 1];
            B(1) = ys(2);
            continue;
        end

        if mod(flag,2) ~= 0 || flag == 0
            k = k+1;
            A(i, j:j+2) = [xs(k)^2, xs(k), 1];
            B(i) = ys(k);
            flag = flag + 1;        
        else
            j = j+3;
            A(i, j:j+2) = [xs(k)^2, xs(k), 1];
            B(i) = ys(k);
            flag = 1;       
        end
    end

    % The first and last functions must
    % pass through the end points
    A(2*(n-1)+1, 1:2) = [xs(1), 1];
    B(2*(n-1)+1) = ys(1);
    A(2*(n-1)+2, end-2:end) = [xs(end)^2, xs(end), 1];
    B(2*(n-1)+2) = ys(end);

    % The first derivatives at the interior knots
    % must be equal.
    j = 3;
    for i = 2*(n-1)+3 : length(A)
        if i == 2*(n-1)+3
            A(i, 1:5) = [1, 0, -2*xs(2), -1, 0];
            % B(i) = 0;
            continue;
        end

        if n == 3
           A(i, j:j+5) = [2*xs(3), 1, 0, -2*xs(3), -1, 0];
           % B(i) = 0;
        else
            for k = 3:n-1
                A(i, j:j+5) = [2*xs(k), 1, 0, -2*xs(k), -1, 0];
                % B(i) = 0;
                j = j+3;
            end
        end
    end

    % Coefficient matrix
    X = [0; A\B];

    % Polynomials
    polynomials = zeros(n,3);
    j = 1;
    for i = 1:n
        polynomials(i,:) = X(j:j+2);
        j = j+3;
    end

    % Intervals
    intervals = zeros(n,2);
    for i = 1:n
        intervals(i,:) = xs(i:i+1);
    end

    % Evaluation
    y_interp = zeros(length(x_interp),1);
    for i = 1:length(x_interp)
        if max(x_interp) > max(xs) || min(x_interp) < min(xs)        
            warning('x value is out of range. Return an empty array.')
            y_interp = [];
            break;
        end

        % Find polynomial
        found = false;
        idx = 1;
        while found == false
            if x_interp(i) >= intervals(idx,1) && x_interp(i) <= intervals(idx,2)
               found = true;
               y_interp(i) = polyval(polynomials(idx,:), x_interp(i));
            end
            idx = idx + 1;
        end
    end
end
