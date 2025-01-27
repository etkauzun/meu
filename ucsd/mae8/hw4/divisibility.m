function [div] = divisibility(a) % divisibility
% DIVISIBILITY checks for a divisibility of input a by 3,5,7,11,13
%   Call format: [div] = divisibility(a)
div = [0 0 0 0 0];
if rem(a,3) == 0
    div(1,1) = 1;
end % if on line 5

if rem(a,5) == 0
    div(1,2) = 1;
end % if on line 9

if rem(a,7) == 0
    div(1,3) = 1;
end % if on line 13

if rem(a,11) == 0
    div(1,4) = 1;
end % if on line 17

if rem(a,13) == 0
    div(1,5) = 1;
end % if on line 21

end % function