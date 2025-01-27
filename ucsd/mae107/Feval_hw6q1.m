function [x1_val, x2_val, x3_val] = Feval_hw6q1(xval, yval, zval)
% Feval_hw6q1 evaluates the right hand side of the functions
%
% Call format: 
%
% input variables:
% xval: value of x to go into the function
% yval: value of y to go into the function
% zval: value of z to go into the function
%
% output variables:
% x1_val: value of x1 at given x1, x2, x3 values
% x2_val: value of x2 at given x1, x2, x3 values
% x3_val: value of x3 at given x1, x3 values

% setting up the functions
x1 = @(x,y,z) 0.25*sin(x+y+atan(z/2));
x2 = @(x,y,z) 0.25*cos(x+y+atan(z/2));
x3 = @(x,z) 1 + 0.25*cos(x+atan(z/2));

% Evaluating the functions to find the values
x1_val = x1(xval,yval,zval);
x2_val = x2(xval,yval,zval);
x3_val = x3(xval,zval);

end % function