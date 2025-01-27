clear all; clc;

f = @(x) sin(x) + (5/4)*x - 2;

x = [3,2];
err = [];

for n = 2:100
    x_val = x(n) - (( f(x(n))* (x(n) - x(n-1))) /  (f(x(n)) - f(x(n-1))) );
    x = [x, x_val];
    if abs(f(x_val)) <= 10e-8
        break
    end
end

x_val
x