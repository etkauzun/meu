function [xbar] = bisection_hw5q3(a0, b0, err)
% bisection_hw5q3 computes the root of 
%   g(c) = min( (0.5 + sin(pi*c) + 3*c), (5 - 2*c*exp(1/(1+c^2))) )
%
% Call format: [xbar] = bisection_hw5q3(a0, b0, err)
%
% input variables:
% a0 - interval end-point
% b0 - interval end-point
% err - error
%
% output variables:
% xbar - root of the function g from the bisection method

% Defining function g(c) & xbar
g = @(c) min( (0.5 + sin(pi*c) + 3*c),(5 - 2*c*exp(1/(1+c^2))) );
g0 = g(a0);

% Finding the number of steps for the given error err
n = (log(b0-a0)/err) / log(2); % calculating n number of steps given error
if ~isinteger(n)
    n = round(n+1); % rounding the n to integer
end % if on line 21

for i = 0:n
    c = a0 + (b0-a0)*0.5; % calculating midpoint
    g_val = g(c); % function g value for the midpoint
    if g0 * g_val < 0
        b0 = c;% assigning bn value to midpoint if g_val < 0
    elseif g0 * g_val > 0 
        a0 = c; % assigning an value to midpoint if g_val > 0
        g0 = g_val; % assigning g(x0) to current g_value
    else
        xbar = c;
    end % if on line 28
end % for on line 25

xbar = c; % root is midpoing

end % function on line 1