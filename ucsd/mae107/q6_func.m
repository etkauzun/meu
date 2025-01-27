function [result] = q6_func(x)
% q6_func computes the value of function sin(pi*(1-x^2)) / sqrt(2+x^2) for 
% a given value of x
%
% Call format: [result] = q6_func(x)
%
% input variables:
% x - value of function input
%
% output variables:
% result - value of the function output

f = @(x) sin(pi*(1-x^2)) / sqrt(2+x^2); % setting up the function
result = f(x); % calling the function

end % function on line 1