function [Xo,Yo,Zo,Uo,Vo,Wo] = read_input(input_filename, sat_id)
% READ_INPUT reads the input
%   Inputted the filename & satellite number, the function gives the
%   initial position and velocity values

input_data = importdata(input_filename, ',', 2);

[row, col] = size(input_data.data);

if sat_id < 1 || sat_id > row
    Xo = NaN;
    Yo = NaN;
    Zo = NaN;
    Uo = NaN;
    Vo = NaN;
    Wo = NaN;
    disp('Error: sat_id is invalid.')
    return;
end % if

Xo = input_data.data(sat_id,2);
Yo = input_data.data(sat_id,3);
Zo = input_data.data(sat_id,4);
Uo = input_data.data(sat_id,5);
Vo = input_data.data(sat_id,6);
Wo = input_data.data(sat_id,7);

end % function 
