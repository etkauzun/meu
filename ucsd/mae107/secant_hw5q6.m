function [x_arr, f_arr] = secant_hw5q6(x0,x1,n)
% secant_hw5q6 computes the root of 
%   f(x) = sin(x) + (5/4)*x - 2
%
% Call format: [x_arr, f_arr] = secant_hw5q6(x0,x1,n)
%
% input variables:
% x0 - initial guess at xn, n=0
% x1 - initial guess at xn, n=1
% n - number of steps
%
% output variables:
% x_arr - array of x values
% f_arr - array of function f(x) values

% Defining function f(x)
f = @(x) sin(x) + (5/4)*x - 2;

% Pre-allocation of arrays 
x_arr = [x0,x1];
f_arr = [f(x0), f(x1)];

for i = 2:n
    x_i = x_arr(i) - ( f(x_arr(i)) * ( x_arr(i)-x_arr(i-1) ) / (f(x_arr(i)) - f(x_arr(i-1))) );
    x_arr = [x_arr, x_i];
    f_arr = [f_arr, f(x_i)];   
end % for on line 23

end % function on line 1