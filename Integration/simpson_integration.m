function val = simpson_integration(a, b, n, f)
%SIMPSON_INTEGRATION - Integrates an array of numbers
%
% Syntax:  val = multiple_simpson13(h, n, f)
%
% Inputs:
%    a - Lower bound
%    b - Upper bound
%    n - The number of interal
%    f - An array to be integrated
%
% Outputs:
%    val - Integration result
%
% Other m-files required: trapezoidal.m, simpson38.m, multiple_simpson13.m
% Subfunctions: none
% MAT-files required: none
%
% See also: MULTIPLE_TRAPEZOIDAL, MULTIPLE_SIMPSON13
    
    if length(f) == 1
        val = 0;
        return;
    end

    sums = 0;
    h = (b-a)/n;
    if n == 1
        sums = trapezoidal(h, f(n), f(n+1));        
    else
        m = n;
        odd = n/2 - floor(n/2);
        if odd > 0 && n > 1
            sums = simpson38(h, f(n-2), f(n-1), f(n), f(n+1));
            m = n-3;
        end
        if m > 1
            sums = sums + multiple_simpson13(h, m, f);
        end
    end
    val = sums;
end
