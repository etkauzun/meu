clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 5;
%% Problem 1
% Write a function piecewise2d.m to compute the following 2-dimensional
% function f(x,y). Set f to be zero for other conditions of x and y. 
% Function piecewise2d.m should have the function declaration: 
% function f = piecewise2d(x,y) where x and y are number inputs and 
% f is a number output. Remember to include a description for the function.
% Use if elseif statements.
p1a = evalc('help piecewise2d');
p1b = piecewise2d(pi, pi);
p1c = piecewise2d(pi, (-1*pi));
p1d = piecewise2d(-1*pi, pi);
p1e = piecewise2d(-1*pi, -1*pi);
p1f = piecewise2d(0, 0);
p1g = piecewise2d(0, pi);
p1h = piecewise2d(0, -1*pi);
p1i = piecewise2d(pi, 0);
p1j = piecewise2d(-1*pi, 0);
%% Problem 2
% Write a function rgb color.m to display color (red, green, blue, yellow,
% magenta, cyan, white) as a result of mixing primary colors 
% (red, green, blue). The function should have the following declaration: 
% function color = rgb color(rgb) where the input rgb is a 3-element vector
% having value of either 0 or 1 to denote the three primary colors 
% (red, green, blue) respectively. The output color is a string denoting 
% the color of the mixture. For example, when rgb = [1 0 0], the resulting 
% color is red. When rgb = [1 1 1], the resulting color is white. 
% If the input rgb is not a valid input, the output color should be the 
% string 'Invalid input'. Remember to give the function a description. 
% Use nested if statements.
p2a = evalc('help rgb_color');
p2b = rgb_color([1 1 0]);
p2c = rgb_color([0 1 1]);
p2d = rgb_color([1 0 1]);
p2e = rgb_color([1 1 1]); 
p2f = rgb_color([1 0 0]); 
p2g = rgb_color([0 1 0]);
p2h = rgb_color([0 0 1]);
p2i = rgb_color([0 0 0]);
%% Problem 3
% Write a function days in month.m to display the number of days in a given 
% month. The function should have the declaration: function days = days in
% month(month, leap) where the input month is an all-lower-case string 
% denoting the first three letters of the month. The input leap has logical 
% value (0 or 1) indicating the leap year. The output days displays the 
% number of days in the input month. February has 28 days (29 days in leap 
% year). The following months have 30 days: April, June, September and 
% November. Other months have 31 days. In cases where the inputs are 
% invalid, the output days should be the string 'Invalid inputs'. 
% The function should include a description. Use nested switch statements.
p3a = evalc('help days_in_month');
p3b = days_in_month('jan', 0);
p3c = days_in_month('apr', 0);
p3d = days_in_month('aug', 1);
p3e = days_in_month('oct', 0);
p3f = days_in_month('nov', 1);
p3g = days_in_month('feb', 0); 
p3h = days_in_month('feb', 1);
p3i = days_in_month('Dec', 0);
%% Problem 4
% Write a function assign grade.m to compute total score and assign a 
% letter grade based on the homework, midterm, project and final exam 
% scores. The function should have the following declaration: function 
% [total score, letter] = assign grade(homework, midterm, project, final) 
% where the input homework is a 8-element vector to include the eight 
% homework scores. The other inputs are single number which includes the 
% scores of the midterm, project and final exam. The outputs are a single 
% number total score and a character-type string letter. The letter grade 
% is assigned based on the total score.
p4a = evalc('help assign_grade');
load('studentA.mat'); 
[p4b, p4c] = assign_grade(homework, midterm, project, final);
load('studentB.mat'); 
[p4d, p4e] = assign_grade(homework, midterm, project, final);
load('studentC.mat'); 
[p4f, p4g] = assign_grade(homework, midterm, project, final);
%% Problem 5
% Use for loop or nested for loops to evaluate the following expressions. 
% (a)
summation_a = 0;
for n = 1:100
    summation_a = summation_a + (1/ (n^2 + n));
end % for on line 88
p5a = summation_a;

% (b)
summation_b = 0;
for m = 0:50
    for n = 0:50
        summation_b = summation_b + (1 / 3^(m+n));
    end % for on line 96
end % for on line 95
p5b = summation_b;

% (c)
summation_c = 0;
for m = 0:50
    for n = 0:m
        summation_c = summation_c + (1 / 3^(m+n));
    end % for on line 105
end % for on line 104
p5c = summation_c;

% (d)
summation_d = 0;
for l = 1:50
    for m = 1:30
        for n = 1:30
            summation_d = summation_d + (1 / ( (2^l) * (2^m) * (2^n) ) );
        end % for on line 115
    end % for on line 114
end % for on line 113
p5d = summation_d;

% (e)
product_e = 1;
for n = 1:50
    product_e = product_e * ( (4 * (n^2)) / ( (4 * (n^2)) - 1));
end % for on line 124
p5e = product_e;
%% PROBLEM 6
p6 = evalc('type(''survey.dat'')');
%% THE END