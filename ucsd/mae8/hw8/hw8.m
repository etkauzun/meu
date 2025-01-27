clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 8;
%% PROBLEM 1
% Download the file cellA.mat from CANVAS and load it into MATLAB. 
% The file contains a cell array named cellA. 
load("cellA.mat")
% (a) What is the dimension (size) of cellA. Put the answer in p1a.
p1a = size(cellA);

% (b) Extract all elements in the first column of cellA and put them 
% into a column cell array p1b.
for n = 1:p1a(1)
    p1b{n} = cellA{n,1};
end
p1b = p1b';

% (c) Extract all elements in the last row of cellA and put them into 
% a row cell array p1c.
for n = 1:p1a(2)
    p1c{n,1} = cellA{end,n};
end
p1c = p1c';
% (d) Extract the content of the 3rd-row 2nd-column element of cellA and 
% put it into a row vector p1d. Note that p1d should have integer datatype, 
% not a cell class.
p1d = cellA{3,2};

% (e) Copy cell array p1b into cell array p1e. Use for loop to modify cell 
% array p1e such that the first letters of both first and last names in 
% each element of the cell array are capitalized. 
% Hint: the first letter of the last name is preceded by a blank space.
p1e = p1b; 
for n = 1:numel(p1e)
    p1e{n}(1) = upper(p1e{n}(1));
    for m = 1:numel(p1e{n})
        if p1e{n}(m) == ' '
            p1e{n}(m+1) = upper(p1e{n}(m+1));
        end % if 
    end % for 
end % for

%% PROBLEM 2
% Use table 1 to create a vector of structure named student to store the 
% records of three students. The data structure should have the following 
% fields: name, PID, homework, project, midterm and final exam. The name 
% and PID fields are strings. The homework field is a vector of 7 homework 
% grades. The project, midterm and final exam fields contain a single number.

student(1) = struct('name','Peter Hamilton','PID', 'A01','homework',...
    [90 91 92 93 94 95 96] ,'project',86, 'midterm', 83,'final_exam', 93);
student(2) = struct('name','Susan West','PID', 'A02','homework',...
    [80 81 82 83 84 85 86] ,'project',85, 'midterm', 73,'final_exam', 90);
student(3) = struct('name','Jack Lew','PID', 'A03','homework',...
    [70 71 72 73 74 75 76] ,'project',87, 'midterm', 93,'final_exam', 86);

p2a = student(1);
p2b = student(2);
p2c = student(3);

hw_ave = [((90+91+92+93+94+95+96)/7) ((80+81+82+83+84+85+86)/7) ...
    ((70+71+72+73+74+75+76)/7)];

for n = 1:3
    student(n).hw_average = hw_ave(n);
end % for

p2d = [student.hw_average];
%% PROBLEM 3
survey_ans = importdata('survey.txt');

% (a) Make a bar graph to show the numbers of students who expect A, B, C, 
% D and F in the course. Label the axes and give a title. 
% Set p3a = 'See figure 1'.

numA = 0;
numB = 0;
numC = 0;
numD = 0;
numF = 0;
numNull = 0;

for n = 1:length(survey_ans)
    if survey_ans{n,1}(40) == 'A'
        numA = numA + 1;
    elseif survey_ans{n,1}(40) == 'B'
        numB = numB + 1;
    elseif survey_ans{n,1}(40) == 'C'
        numC = numC + 1;
    elseif survey_ans{n,1}(40) == 'D'
        numD = numD + 1;
    elseif survey_ans{n,1}(40) == 'F'
        numF = numF + 1;
    else
        numNull = numNull + 1;
    end % if
end % for

X = categorical({'A', 'B', 'C', 'D' 'F' 'No Entry'});
grade_vec = [numA numB numC numD numF numNull];
figure(1); bar( X,grade_vec, 'black'); xlabel('Expected Grades');
ylabel('Number of Grades'); title('Students & Their Expexted Grades');
p3a = 'See figure 1';

% (b) How many students have previous MATLAB/coding experience? Put the answer into p3b.

p3b = 0;
for n = 1:length(survey_ans)
    if survey_ans{n,1}(18) == 'Y'
        p3b = p3b + 1;
    end % if
end % for

% (c) How many students spend less than 7 hours studying outside of class? 
% Put the answer into p3c.

p3c = 0;
for n = 1:length(survey_ans)
    if survey_ans{n,1}(46) == '0'
        p3c = p3c + 1;
    elseif survey_ans{n,1}(46) == '4'
        p3c = p3c + 1;
    end % if
end % for

% (d) How many sophomores said that they often attend the Friday lab session? 
% Put the answer into p3d.

p3d = 0;
for n = 1:length(survey_ans)
    if survey_ans{n,1}(2) == 'S' && survey_ans{n,1}(28) == 'F'
            p3d = p3d + 1;
    end % if
end % for
%% THE END

