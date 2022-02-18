clc; clear; close all; format longg;

% Example 1: Chapra page 628 number 21.10
x = [0, 0.1, 0.2, 0.3, 0.4, 0.5];
y = [1, 8, 4, 3.5, 5, 1];

a = x(1);
b = x(end);
n = length(x) - 1;
simpson_integration(a, b, n, y);

% Example 2: Chapra page 628 number 21.11
x = [-2, 0, 2, 4, 6, 8, 10];
y = [35, 5, -10, 2, 5, 3, 20];

a = x(1);
b = x(end);
n = length(x) - 1;
simpson_integration(a, b, n, y);
