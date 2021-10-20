% PROGRAM INI DIPERSIAPKAN SEBELUM EVALUASI TENGAH SEMESTER
% ALDI EKA WAHYU WIDIANTO (6002211007)

function [polynomials, intervals, y_interp] = cubic_spline(x,y,x_interp)
    if nargin == 2
        x_interp = [];
    end
    xs = x; ys = y;
    
    % Sort values
    [xs,idx] = sort(xs,'ascend');
    ys = ys(idx);

    n = length(xs)-1; % The number of interval
    A = zeros(4*n); % 12x12
    B = zeros(4*n,1);
    
    % The function values must be equal at the
    % interior knots (2n − 2 conditions).
    flag = 0;
    j = 1;
    k = 1;
    for i = 1:2*((n+1)-2)
        if mod(flag,2) == 0
            k = k+1;
            A(i, j:j+3) = [xs(k)^3, xs(k)^2, xs(k), 1];
            B(i) = ys(k);
            flag = flag + 1;
        else
            j = j+4;
            A(i, j:j+3) = [xs(k)^3, xs(k)^2, xs(k), 1];
            B(i) = ys(k);
            flag = 0;
        end
    end
    
    % The first and last functions must pass through
    % the end points (2 conditions).
    A(2*((n+1)-2)+1, 1:4) = [xs(1)^3, xs(1)^2, xs(1), 1];
    B(2*((n+1)-2)+1) = ys(1);
    A(2*((n+1)-2)+2, end-3:end) = [xs(end)^3, xs(end)^2, xs(end), 1];
    B(2*((n+1)-2)+2) = ys(end);
    
    % The first derivatives at the interior knots
    % must be equal (n − 1 conditions)
    j = 5;
    k = 3;
    for i = 2*(n-1)+3 : 2*(n-1)+3 + (n-2)
        if i == 2*(n-1)+3
            A(i, 1:8) = [3*xs(2)^2, 2*xs(2), 1, 0, -3*xs(2)^2, -2*xs(2), -1, 0];
            % B(i) = 0;
            continue;
        end

        if n == 3
           A(i, j:j+7) = [3*xs(3)^2, 2*xs(3), 1, 0, -3*xs(3)^2, -2*xs(3), -1, 0];
           % B(i) = 0;
        else            
            A(i, j:j+7) = [3*xs(k)^2, 2*xs(k), 1, 0, -3*xs(k)^2, -2*xs(k), -1, 0];
            % B(i) = 0;
            j = j+4;
            k = k+1;
        end
    end
    
    % The second derivatives at the interior knots
    % must be equal (n − 1 conditions).
    j = 5;
    k = 3;
    for i = 2*(n-1)+3 + (n-1) : 2*(n-1)+3 +(2*n-3)
        if i == 2*(n-1)+3 + (n-1)
            A(i, 1:8) = [6*xs(2), 2, 0, 0, -6*xs(2), -2, 0, 0];
            % B(i) = 0;
            continue;
        end

        if n == 3
           A(i, j:j+7) = [6*xs(3), 2, 0, 0, -6*xs(3), -2, 0, 0];
           % B(i) = 0;
        else
            A(i, j:j+7) = [6*xs(k), 2, 0, 0, -6*xs(k), -2, 0, 0];
            % B(i) = 0;
            j = j+4;
            k = k+1;
        end
    end
    
    % The second derivatives at the end knots are zero (2 conditions).
    A(end-1, 1:2) = [6*xs(1), 2];
    A(end, end-3:end-2) = [6*xs(end), 2];
    
    % Coefficient matrix
    X = A\B;

    % Polynomials
    polynomials = zeros(n,4);
    j = 1;
    for i = 1:n
        polynomials(i,:) = X(j:j+3);
        j = j+4;
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
