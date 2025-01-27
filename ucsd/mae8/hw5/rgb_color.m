function color = rgb_color(rgb)
% RGB_COLOR displays the color name 
%   color is the output given the values in the rgb vector

% if any of rgb is not equal to 0 or 1, early exit
if any(rgb ~= 0 & rgb ~=1) | (rgb == [0 0 0])
    color = 'Invalid input';
    return;
end

if rgb(1) == 1
    if rgb(2) == 1
        if rgb(3) == 1 % [1 1 1]
            color = 'white';
        else % [1 1 0]
            color = 'yellow';
        end % if on line 13
    else
        if rgb(3) == 1 % [1 0 1]
            color = 'magenta';
        else % [1 0 0]
            color = 'red';
        end % if on line 19
    end % if on line 12
else 
    if rgb(2) == 1
        if rgb(3) == 1 % [0 1 1]
            color = 'cyan';
        else % [0 1 0]
            color = 'green';
        end % if on line 27
    else 
        if rgb(3) == 1 % [0 0 1]
            color = 'blue';
        else % [0 0 0]
            color = 'Invalid input';
        end % if on line 33
    end % if on line 26
end % if on line 11

end % function 
