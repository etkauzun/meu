function [approx] = q6_CT_true
% q6_CT_appr computes the corrected trapezoid approximation at n = 10e5
%
% Call format: [approx] = q6_CT_appr
%
% input variables:
% a - interval end-point
% b - interval end-point
% n - number of steps
%
% output variables:
% approx - CT approximation value
b = 3; a = 0; n = 10e5;
h = (b-a) / n; % calculating step-size
approx = h * ( (q6_func(a)+q6_func(b)) / 2); % initiating the approximation value
approx = approx + h * ( (-1/24) * ( 3*q6_func(a) - 4*q6_func(a+h) + q6_func(a+(2*h)) ...
    + q6_func(b-(2*h)) - 4*q6_func(b-h) + 3*q6_func(b)) ); % calculating the correction in approximation

for i = 1:n-1 % for loop for the summation
    x = a + h*i; % finding the input value of the approximation
    approx = approx + (h * q6_func(x)); % finding the approximation for that step
end % for loop on line  22

end % function