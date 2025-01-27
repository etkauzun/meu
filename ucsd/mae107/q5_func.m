function [result] = q5_func(x)
% q5_func computes the value of function sin(pi*x) - 0.5*cos(2*pi*x) for 
% a given value of x
%
% Call format: [result] = q5_func(x)
%
% input variables:
% x - value of function input
%
% output variables:
% result - value of the function output

f = @(x) sin(pi*x) - 0.5*cos(2*pi*x); % setting up the function
result = f(x); % calling the function

end % function on line 1