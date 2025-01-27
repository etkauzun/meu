function [X_arr] = FP_hw6q1(n,X0)
% FP_hw6q1 computes the solution of n equations in n unknowns 
%
% FP Method: x_k+1 = f(x_k)
%
% Call format: [X_arr] = FP_hw6q1(n,X0)
%
% input variables
% f1 - function 1

% n - number of iterations
% X0 - array of initial condition
%
% output variables:
% X_arr - matrix of X values


% setting up the functions
% x1 = @(x,y,z) 0.25*sin(x+y+atan(z/2));
% x2 = @(x,y,z) 0.25*cos(x+y+atan(z/2));
% x3 = @(x,z) 1 + 0.25*cos(x+atan(z/2));

% Pre-allocation of arrays
x_arr = [X0(1)]; % x1 values
y_arr = [X0(1)]; % x2 values
z_arr = [X0(3)]; % x3 values
X_arr = []; % X array

for j = 1:n
    % X_arr(:,j) = [x1(x_arr(j),y_arr(j),z_arr(j)); x2(x_arr(j),y_arr(j),z_arr(j)); x3(x_arr(j), z_arr(j))];
    
    % Calling function Feval to get the values of x1n x2n x3n
    [x1_val,x2_val, x3_val] = Feval_hw6q1(x_arr(j),y_arr(j),z_arr(j));

    % Updating X array with x1n x2n x3n values
    X_arr(:,j) = [x1_val; x2_val; x3_val];

    % Updating x1 x2 and x3 values from the X array
    x_arr = [x_arr, X_arr(1,j)];
    y_arr = [y_arr, X_arr(2,j)];
    z_arr = [z_arr, X_arr(3,j)];

end % for line

% Approximating error
err = X_arr(:,n) - X_arr(:,n-1)

% end function

