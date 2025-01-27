function f = piecewise2d(x,y)
% PIECEWISE2D computes the 2-dimensional function given in the problem
%   f is the output of the function with x and y being the input values

if x > 0 
    if y > 0
        f = 4*x + 4*y;
    elseif y < 0 | y <= 0
        f = 4*x - 4*y;
    end % if on line 6
elseif x == 0
    if y > 0
        f = 4*x + 4*y;
    elseif y < 0
        f = -4*x - 4*y;
    elseif y == 0
        f = 0;
    end % if on line 12
elseif x < 0
    if y > 0 | y == 0
        f = -4*x + 4*y;
    elseif y < 0
        f = -4*x - 4*y;
    end % if on line 18

end % if on line 5

end % function 