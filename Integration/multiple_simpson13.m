
function val = multiple_simpson13(h, n, f)
%MULTIPLE_SIMPSON13 - Integrates an array of numbers
%
% Syntax:  val = multiple_simpson13(h, n, f)
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
% See also: MULTIPLE_TRAPEZOIDAL

    sums = f(1);
    for i = (2:2:n-2)
        sums = sums + 4*f(i) + 2*f(i+1);
    end
    sums = sums + 4*f(n) + f(n+1);
    val = h*sums/3;
end
