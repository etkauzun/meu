clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 2;
%% Problem 1
% (a) Using function linspace, create a row vector p1a containing even 
% integer numbers starting from 2 and ending at 998.
p1a = linspace(2, 998, 499);

% (b) Using colon operator, create a row vector p1b containing odd 
% integer numbers starting from 1 and ending at 999.
p1b = 1:2:999; % first, step, last

% (c) Combine the vectors created in parts (b) and (a) into to a 
% longer vector p1c. Put part (b) first, then part (a).
p1c = [p1b, p1a];

% (d) What is the length of the vector in part (c)?
p1d = length(p1c);

% (e) Which element of the vector in part (c) is the number 500?
p1e = find(p1c == 500);

% (f) Add the number 0 at the beginning of the vector in part (c) 
% to create vector p1f.
p1f = [0, p1c];

% (g) Write an expression to extract the second quarter of the 
% vector in part (f) into vector p1g.
p1g = p1f(250:499);

% (h) Write an expression to extract the fourth quarter of the vector 
% in part (f) into vector p1h.
p1h = p1f(750:999);

% (i) Create a column vector p1i to list all odd numbers from -1 to -1999. 
% The vector should be listed in decreasing order.
p1i = -1:-2:-1999;

% (j) Square all of the elements of the vector in part (i) 
% and put the answer in p1j.
p1j = p1i.*p1i;

% (k) Sum all elements of the vector in part (i) and put the answer in p1k.
p1k = sum(p1i); 

% (l) Find the product of the last five elements of the vector in part (i)
% and put the answer in p1l.
p1l = p1i(end - 4) * p1i(end - 3) * p1i(end - 2) * p1i(end - 1) * p1i(end);

% (m) Find the cumulative sum of the vector in part (i). 
% Put the answer in p1m.
p1m = cumsum(p1i);
%% Problem 2
% (a) Create a 5 x 5 matrix p2a with a value of 7 for every element.
p2a = randi([7,7],5);

% b) Copy the matrix in part a into a new matrix p2b. Modify the matrix 
% p2b such that all elements on the second column have a value of 2.
p2b = p2a;
p2b(:,2) = 2;

% (c) Transpose the matrix in part (b) and put the answer in p2c.
p2c = p2b';

% (d) Rotate the matrix in part (b) 90◦ counterclockwise 3 times 
% and put the answer in p2d.
p2d = rot90(p2b, 3);

% (e) Are the matrices in part (c) and (d) the same? 
% Put the answer in p2e. Do not use function isequal for this problem.
p2e = p2c == p2d;
%% Problem 3
% (a) Create the following matrix and put the answer in p3a.
a = [1 2; 3 4]; b = zeros(2,2); corner = [a b; b a];
middleoftop4 = 5*ones(4,2); top4 = [corner middleoftop4 fliplr(corner)];
line5and6 = [5*ones(2,4) a 5*ones(2,4)]; top6 = [top4; line5and6];
bcornerl = [b fliplr(a); fliplr(a) b];
bottom4 = [bcornerl 5*ones(4,2) fliplr(bcornerl)];
p3a = [top6; bottom4];

% (b) Sum all elements on the fifth column of the matrix in part (a) 
% and put the answer in p3b.
p3b = sum(p3a(:,5));

% (c) Sum all elements on the two diagonals of the matrix in part (a) 
% and put the answer in p3c.
p3c = sum(diag(p3a)) + sum(diag(fliplr(p3a)));

% (d) Sum all elements of the matrix in part (a) and put the answer in p3d.
p3d = sum(sum(p3a));

% (e) How many elements of the matrix in part (a) are greater than 2? 
% Put the answer in p3e.
p3e = length(find(p3a > 2));
%% Problem 4
% (a) Create a row vector p4a to store the numerators of each term 
% in the series. Put the answer in p4a.
p4a = [1 2:2: 98];

% (b) Create a row vector p4b to store the denominators of each term 
% in the series. Put the answer in p4b.
p4b = 1:2:99;

% (c) Create a row vector p4c to store the signs of each term in the 
% series, e.g. 1 or positive and -1 for negative. Put the answer in p4c.
p4c = repmat([1,-1],1,25);

% (d) Use function sum with the vectors in parts (a-c) to obtain the sum
% of the series. Put the answer in p4d.
p4d = sum(p4a.*p4c./p4b);
%% Problem 5
A = [2 5 10;3 8 5];
B = [8 3;7 4;2 1];
C = [2 4 6;1 2 3;3 5 7];
D = [1 3;5 7];

% (a) Compute A2 and put the result in p5a.
p5a = A.^2;

% (b) Compute A ∗ B and put the result in p5b.
p5b = A*B;

% (c) Compute A ∗ C and put the result in p5c.
p5c = A*C;

% (d) Compute A ∗ D and put the result in p5d.
p5d = 'error';

% (e) Compute B ∗ A and put the result in p5e.
p5e = B*A;

% (f) Compute B ∗ D and put the result in p5f.
p5f = B*D;

% (g) Compute B ∗ C and put the result in p5g.
p5g = 'error';

% (h) Compute C2 and put the result in p5h.
p5h = C.^2;

% (i) Compute D2 and put the result in p5i.
p5i = D.^2;

% (j) Is A∗B equal to B∗A ? Put the answer in p5j. 
% The answer should be a logical, look up in MATLAB help isequal.
p5j = isequal(A*B, B*A);
%% Problem 6
solex = [4 1 1 1; 1 4 1 1; 1 1 4 1; 1 1 1 4];
soleb = [0; 2; 4; 6];
% (a) Using \ operator, solve the system of equations in the form Ax=b 
% to obtain x. Set p6a=x.
x = solex \ soleb;
p6a = x;

% (b) Using function inv, solve the system of equations Ax=b for x. 
% Set p6b=x.
x = inv(solex) * soleb;
p6b = x;

% (c) Is the answer in part (a) and part (b) the same? 
% Put the answer in p6c. Hint: Check by setting them equal.
p6c = p6a == p6b;

% (d) Compute the absolute difference between 
% part (a) and (b) and put the answer in p6d.
p6d = abs(p6a - p6b);
%% THE END

%% Note for p5a,i,h: if the matrix is not square, mat squared gives an error
% like in 5a but not in 5h and i matrix^2