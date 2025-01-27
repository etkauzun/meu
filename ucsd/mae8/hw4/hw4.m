clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 4;
%% Problem 1
% The built-in function clock returns a row vector that contains 6 elements: 
% the first three are the current date (year, month, day) 
% and the last three represent the current time in hours (24 hour clock), 
% minutes, and seconds. The seconds is a real number, 
% but all others are integers. Use function sprintf to accomplish 
% the following formatting exercises.

% a) Get the current date and time and store them in p1a. 
% The current date and time should be the date and time when the
% grader calls your script.
p1a = clock;

% b) Using the format 'YYYY:MM:DD', write the current date to string p1b.
% Here, YYYY, MM, and DD correspond to 4-digit year, 2-digit month, 
% and 2-digit day, respectively.
p1b = sprintf('%4.0d:%2.0d:%2.0d', p1a(1:3));

% c)  Using the format 'HH:MM:SS.SSSS', write the current time to string p1c. 
% Here, HH, MM, and SS.SSSS correspond to 2-digit hour, 2-digit minute 
% and 7-character second (2 digits before the decimal point and 4 
% digits after the decimal points), respectively.
p1c = sprintf('%2.0d:%2.0d:%6.4f', p1a(4:6));

% d) Remove the last 5 characters from the string in part (c) 
% so that the format is now 'HH:MM:SS'. Put the answer into string p1d.
p1d = sprintf('%2.0d:%2.0d:%2.0f', p1a(4:6));

% e) Combine the strings in part (b) and part (d) together separated by a 
% single space. Put the answer in string p1e.
p1e = sprintf('%s %s', p1b, p1d);
%% Problem 2
% Use the matrix matA below to perform the following exercises.
matA = [pi pi/4 pi/7; pi/2 pi/5 pi/8; pi/3 pi/6 pi/9];

% a) Write the first column of matrix matA into string p2a using a field 
% width of 6 characters with 4 decimal places for each element. 
% The string must show a column vector.
p2a = sprintf('%6.4f\n', matA(:,1));

% b) Write the middle row of matrix matA into string p2b using a field 
% width of 5 characters with 3 decimal places for each element. 
% The string must show a row vector.
p2b = sprintf('%5.3f %5.3f %5.3f', matA(2,:));

% c) Write matrix matA into string p2c using a field 
% width of 16 characters with 14 decimal places.
p2c = sprintf('%16.14f %16.14f %16.14f %16.14f %16.14f %16.14f %16.14f %16.14f %16.14f', matA);

% d) Write matrix matA into string p2d using %e having a field 
% width of 11 characters with 5 decimal places.
p2d = sprintf('%11.5e %11.5e %11.5e %11.5e %11.5e %11.5e %11.5e %11.5e %11.5e', matA);
%% Problem 3
% Download the file rainfall.dat from CANVAS. The file includes the San 
% Diego monthly-averaged rainfall data in inches from 1850 to 2021. 
% The data is comma delimited. The first column indicates the year and 
% the following 12 columns show the monthly-averaged rainfall from 
% January through December. Load this data file into MATLAB and answer 
% the following questions:
load('rainfall.dat');

% (a, b, c) Find the highest monthly rainfall 
% (over all months and all years) and put the answer in p3a. 
% In what month and what year did it occur? 
% Put the answer in p3b and p3c, respectively. 
% For p3b, use 1 for Jan, 2 for Feb, etc.
p3a = max(rainfall(length(rainfall(:,1))+1:end));
[r,c] = find(rainfall(:,2:end) == p3a);
p3b = c;
p3c = rainfall(r,1);

% (d) Between 1900 and 2000, how many times had the monthly rainfall been
% between 2 and 5 in inclusively? Put the answer in p3d.
p3dstart = find(rainfall == 1900);
p3dend = find(rainfall == 2000);
% access the columns for 1900-2000: rainfall(p3dstart:p3dend, 2:end) accesses the columns for 1900-2000
p3d = length(find(rainfall(p3dstart:p3dend, 2:end) <= 5 & rainfall(p3dstart:p3dend, 2:end) >= 2));

% (e) During the months of January between 1910 and 2010, 
% how many times had the monthly rainfall been higher than 4 in? 
% Put the answer in p3e.
p3estart = find(rainfall == 1910); 
p3end = find(rainfall == 2010);
% access the january column for 1910-2010: rainfall(p3estart:p3end, 2,:)
p3e = length(find(rainfall(p3estart:p3end, 2,:) > 4));
%% Problem 4
% Download the file temperature.dat from CANVAS. 
% The file includes the San Diego monthly-averaged temperature data from 
% 1852 to 2020. The data is comma delimited. The first column indicates 
% the year and the following 12 columns show the monthly-averaged 
% temperature from January through December. 
% Load this data file into MATLAB
load('temperature.dat');

% (a) Extract the years into row vector p4a.
p4a = temperature(:,1)';

% (b) Extract the temperatures during the months of October into row vector p4b.
p4b = temperature(:, end-2)';

% (c) Use function mean with the result in part (b) to compute the average 
% temperature for the months of October. Create a row vector p4c with the
% same length as the vector in part (a) but all elements have the average 
% temperature value.
p4c = zeros(1,length(p4a))+mean(p4b);

% (d) During the months of October, what are the maximum and minimum 
% temperatures? Put the answers in a 2-element row vector p4d where the 
% first element is the maximum and the second is the minimum.
p4d = [max(p4b) min(p4b)];

% (e) For the months of October, during which years do the maximum and 
% minimum temperatures occur? Put the answer in a 2-element row vector 
% p4e where the first element is the year with the maximum temperature 
% and the second is the year with the minimum temperature.
max_row = temperature(find(p4b == p4d(1)),:);
min_row = temperature(find(p4b == p4d(2)),:);
p4e = [max_row(1) min_row(1)];

% (f) Create figure 1 and set p4f='See figure 1'. The figure should include the following:
% A line plot showing the temperatures for the months of October, use black solid line.
% A line plot showing the average temperature for the months of October, use blue solid line.
% The maximum temperature for the months of October use red square marker.
% The minimum temperature for the months of October, use green diamond marker.
% Give the figure a title and a legend, and label the axes.

figure(1); hold on; plot(p4a, p4b,'-k'); plot(p4a, p4c,'-b');
plot(p4e(1), p4d(1), '-rs'); plot(p4e(2), p4d(2),'-gd');
title('Temperature in San Diego in October from 1852-2020');
xlabel('Years (1852-2020)'); ylabel('Temperature (in F)');
legend('Temperature', 'Average Temperature'); hold off;
p4f = 'See figure 1';

% (g) Extract the temperatures during the year 1900 (from Jan to Dec) into
% row vector p4g.
year1900 = temperature(find(temperature(:,1) == 1900),:);
p4g = year1900(2:end);

% (h) Create row vector p4h to indicate the months from Jan (1) to Dec (12).
p4h = [1:12];

% (i) Create figure 2 with a bar graph showing the monthly temperatures 
% for the year 1900. The figure should include a title and labels for the axes. 
% Set p4i='See figure 2'.
figure(2); hold on; bar(p4h, p4g);
title('Monthly Temperatures in San Diego in 1900'); 
xlabel('Months'); ylabel('Temperatures'); hold off;
p4i = 'See figure 2';

% (j) Extract the temperature from 1900 to 1910 (all columns including 
% the year) into matrix output data and save the matrix into a new file 
% named temperature 1900 1910.dat using ASCII format. 
% Set p4j= evalc('type(''temperature 1900 1910.dat'')').
% Note: Your homework script must produce the file during execution. 
% If you include the file in your submission folder, the file will be 
% removed before being graded.
output_data = temperature(temperature(:,1) >= 1900 & temperature(:,1) <= 1910,:);
save('temperature_1900_1910.dat', 'output_data', '-ascii');
p4j = evalc('type(''temperature_1900_1910.dat'')');
%% Problem 5
% For a = 1 and b = 0, manually evaluate the following relational 
% expressions on a piece of paper and then enter the answer into your 
% homework script. The answer should be true or false.
a = 1; b = 0; 

% (a) ∼ (a||b) ==∼ a|| ∼ b. Put the answer in p5a.
p5a = true; 

% (b) ∼ (a&&b) == (∼ a|| ∼ b)
p5b = true; 

% (c) ∼ (a||b) == (∼ a&& ∼ b)
p5c = true;

% (d) ∼ (a||b) == (∼ a|| ∼ b)
p5d = false;
%% Problem 6
% For vector v=[1:-1:-1], manually evaluate the following relational 
% expressions on a piece of paper and then enter the answer into your 
% homework script. The answer should be true or false.
v = [1:-1:-1];

% (a) ∼ all(v) == any(∼ v)
p6a = true;

% (b) ∼ any(v) == all(∼ v)
p6b = true;

% (c)  ∼ (all(v) && any(v)) == (∼ all(v) || ∼ any(v))
p6c = true;

% (d) ∼ (all(v) || any(v)) == (∼ all(v) && ∼ any(v))
p6d = true;
%% Problem 7
% Write a function divisibility.m that checks the divisibility of a 
% given number by 3, 5, 7, 11 and 13. The function should have the 
% following declaration: function div = divisibility(a) 
% where a is a number input and div is a logical vector output. 
% Vector div should have 5 elements corresponding to the divisibility 
% by 3, 5, 7, 11 and 13, respectively. For example, the output of 
% divisibility(14) would be [0 0 1 0 0]. The function should also 
% include a description. Use if statement.

p7a = evalc('help divisibility');

% (b) Check the divisibility of 55 and put the answer to p7b. 
p7b = divisibility(55);

% (c) Check the divisibility of 273 and put the answer to p7c. 
p7c = divisibility(273);

% (d) Check the divisibility of 5505 and put the answer to p7d. 
p7d = divisibility(5505);

% (e) Check the divisibility of 15015 and put the answer to p7e.
p7e = divisibility(15015);
%% THE END.





