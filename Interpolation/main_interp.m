clc; clear; close all; format longg;

% POLYNOMIAL INTERPOLATION
x = [1,4,6,5]';
y = log(x);
table1 = table(x,y);
disp(table1);

n = length(x)-1;
poly = polynomial_interpolation(x,y); % Me-return polinomial f(x)
lagrange_poly = lagrange_interpolation(x,y,n);
% x = [2];
x = (0:0.1:15)';
y_interp = double(subs(poly));
y_interp_lagrange = double(subs(lagrange_poly));

plot(y_interp); hold on;
plot(y_interp_lagrange);

% SPLINE
x = [3, 4.5, 7, 9]';
y = [2.5, 1, 2.5, 0.5]';
x_interp = (3:0.1:9)';

[lspline, grads, y_interp_lspline] = linear_spline(x, y, x_interp);
[qspline, intervals, y_interp_qspline] = quadratic_spline(x, y, x_interp);
[cspline, intervals, y_interp_cspline] = cubic_spline(x, y, x_interp);

plot(y_interp_lspline, 'b', 'linewidth', 2);
hold on; grid on;
plot(y_interp_qspline, '--g', 'linewidth', 2);
plot(y_interp_cspline, 'r', 'linewidth', 2);
