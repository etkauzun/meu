function [result] = q7_func(x)
% q5_func computes the value of function abs(x - sqrt(2)) for 
% a given value of x
%
% Call format: [result] = q5_func(x)
%
% input variables:
% x - value of function input
%
% output variables:
% result - value of the function output

f = @(x) abs(x - sqrt(2)); % setting up the function
result = f(x); % calling the function

end % function on line 1