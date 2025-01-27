clear all;
close all;
clc;
format long;

name = 'Etka Uzun';
id = 'A15956274';
hw_num = 3;
%% Problem 1
matA = (-1).^(- 40:40).*(-40:40); matA = abs(rot90(reshape(matA,9,9)));

% (a) Set p1a to be equal to matA. Use logical indexing to replace 
% the median values of each column in matrix p1a with -88,888. 
% Look up function median.
p1a = matA;
p1a(p1a == median(p1a))= -88888;

% (b) Set p1b to be equal to matA. Use logical indexing to replace 
% the median values of the entire matrix p1b with -99,999.
p1b = matA;
p1b(p1b == median(median(p1b)))= -99999;

% (c) Use function isprime to check whether any element in matA is 
% a prime number. Put the answer in a logical number p1c.
p1c = isprime(matA); % CORRECTION: any(any(isprime(matA)))

% (d) Identify the elements in matA that are the prime numbers. 
% Use linear indexing to report the answer in a column vector p1d.
p1d = matA(isprime(matA) == 1); % CORRECTION: find(isprime(matA))
%% Problem 2
%{
Use blackslash (\) operator to solve the system of equations, Ax = b, 
for unknown x’s and put the answer in p2. The coefficient matrix A has 
a dimension of 30 rows by 30 columns. All elements are zero except for 
those on the diagonal, subdiagonal and superdiag- onal. To create A, 
first create a 30 × 30 matrix with all zero and then modify the non-zero 
elements using linear indexing. Another method is to explore function diag.
%}
coeff2 = zeros(30,30);
coeff2(1:31:900) = 3:32;
coeff2(2:31:870) = -2;
coeff2(31:31:899) = -2;
Bvalues = [-2; zeros(28,1); 1];
p2 = coeff2\Bvalues;
%% Problem 3
x = 1:2:20; y = 10:20:200;

% (a) x2y. Put the answer in p3a.
p3a = x.^2.*y;

% (b) xlog10(2y). Put the answer in p3b.
p3b = x.^(log10(y.*2));

% (c) sin(0.5yx)/e0.5y/x . Put the answer in p3c.
p3c = (sin(0.5.*(y.^x)))/(exp(0.5.*y./x)); % CORRECTION: sin(0.5*y.^x)./exp(0.5*y./x)

% (d) x+e−2yx/2y+ln(2xy). Put the answer in p3d.
p3d = (exp(-2.*(y.^x)) + x) / ( (2.*y) + log(2.*(x.^y)));
%% Problem 4
% Use forward difference formula to estimate the derivative of the 
% function f (x) = cos(x)e^sin(x) for 0 ≤ x ≤ 4.

% (a) Create a vector x with values from 0 to 4 with a grid spacing of 
% 0.1 and compute f. Use function diff to estimate the derivative 
% and put the answer in p4a.
x = 0:0.1:4;
f = cos(x).*exp(sin(x));
p4a = diff(f)./diff(x);

% (b) Repeat part (a) but with a grid spacing of 0.001 and 
% put the answer in p4b.
x = 0:0.001:4;
f = cos(x).*exp(sin(x));
p4b = diff(f)./diff(x);

% (c) Use the answer in part (b) to find the derivative at x = 0.34. 
p4c = p4b(x == 0.34);

% (d) Use the answer in part (b) to find the value of x where 
% the derivative is maximum. Put the answer in p4d.
p4d = x(find(p4b == max(p4b)));
%% Problem 5
% Use the trapezoid formulation discussed in class to 
% estimate the following integral: -1 to 1 g(z) dz 
% where g(z) = cosh2(z) + cos4(z) by performing the following exercises.

% (a) Create a vector z that has values from -1 to 1 with 
% a grid spacing of 0.1. Compute vector g. Estimate the integral and 
% put the answer in p5a.
z = -1:0.1:1;
g = (cosh(z)).^2 + (cos(z)).^4;
dz = z(2) - z(1);
p5a = dz * (0.5*(g(1) + g(end)) + sum(g(2:end-1)) );

% (b) Repeat part (a) but with a grid spacing of 0.001. 
% Put the answer in p5b.
z = -1:0.001:1;
g = (cosh(z)).^2 + (cos(z)).^4;
dz = z(2) - z(1);
p5b = dz * (0.5*(g(1) + g(end)) + sum(g(2:end-1)) );
%% Problem 6 
% A two-dimensional spiral can be created by the following expressions:
% x = 0.2 θ cos(θ)
% y = 0.2 θ sin(θ)
% for 0 ≤ θ ≤ 20π (in radians).

% (a) Create a vector theta to include values from 0 to 20π with 
% a consecutive difference of 0.05π. Use the expressions above 
% to obtain the values for vectors x and y. 
% Create figure 1 and use function plot with the vectors x and y 
% to plot the pattern. Use red solid line and red diamond symbols 
% to mark the curve. Remember to provide axis labels and figure title. 
% Set p6a='See figure 1'.
theta = 0:0.05*pi:20*pi;
x = 0.2.*theta.*cos(theta);
y = 0.2.*theta.*sin(theta);
figure(1); plot(x,y,'-rd'); 
xlabel('x = 0.2*θ*cos(θ)');
ylabel('y = 0.2*θ*sin(θ)'); 
title('figure 1');
p6a= 'See figure 1';

% (b) Estimate the arc length of the two-dimensional spiral. 
% Approximate the arc length with straight lines between 
% consecutive points. Put the answer in p6b.

p6function = @(theta) sqrt( (0.2.*theta.*-1.*sin(theta)).^2 + ...
    (0.2.*theta.*cos(theta)).^2 );
p6b = integral(p6function,0,20*pi);
%% Problem 7
%{
A three-dimensional spiral can be created by the following expressions:
x = 0.2 θ cos(θ)
y = 0.2 θ sin(θ)
z = 0.2θ
for 0 ≤ θ ≤ 20π (in radians). %}

% (a) Create a vector theta to include values from 0 to 20π with 
a consecutive difference of 0.05π. Use the expressions above to obtain 
the values for vectors x, y and z. Create figure 2 and use function plot3 
with the vectors x, y and z to plot the pattern. Use magenta solid line 
and magenta circle symbols to mark the curve. Remember to provide axis 
labels and figure title. Set p7a='See figure 2'. 
%}
theta = 0:0.05*pi:20*pi;
x = 0.2.*theta.*cos(theta);
y = 0.2.*theta.*sin(theta);
z = 0.2.*theta;
figure(2); plot3(x,y,z,'-mo');
xlabel('x = 0.2*θ*cos(θ)');
ylabel('y = 0.2*θ*sin(θ)');
zlabel('z = 0.2*theta');
title('figure 2');
p7a = 'See figure 2';

% (b) Estimate the arc length of the three-dimensional spiral. 
% Approximate the arc length with straight lines between 
% consecutive points. Put the answer in p7b.

p7function = @(theta) sqrt((0.2.*theta.*-1.*sin(theta)).^2 + ...
    (0.2.*theta.*cos(theta)).^2 + (0.2).^2);
p7b = integral(p7function,0,20*pi);
%% THE END.