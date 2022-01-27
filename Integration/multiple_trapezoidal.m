function val = multiple_trapezoidal(h, n, f)
%MULTIPLE_TRAPEZOIDAL - Integrates an array of numbers
%
% Syntax:  val = multiple_trapezoidal(h, n, f)
%
% Inputs:
%    h - Step size
%    n - The number of interval
%    f - An array to be integrated
%
% Outputs:
%    val - Integration result
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: MULTIPLE_SIMPSON13

    sums = f(1);
    for i = 1:n-1
        sums = sums + 2*f(i);
    end
    sums = sums + f(n);
    val = h * sums/2;
end
