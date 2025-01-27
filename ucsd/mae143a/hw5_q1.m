clear all; clc; close all;

% b
roots = RR_roots([1,2,2,1,0]);
p1 = roots(1);
p2 = roots(2);
p3 = roots(3);
p4 = roots(4);
A = 1 / ((p1-p2)*(p1-p3)*(p1-p4));
B = 1 / ((p2-p1)*(p2-p3)*(p2-p4));
C = 1 / ((p3-p1)*(p3-p2)*(p3-p4));
D = 1 / ((p4-p1)*(p4-p2)*(p4-p3));
t = 0:0.01:100;
f = A*exp(p1*t) + B*exp(p2*t) + C*exp(p3*t) + D*exp(p4*t);
figure(1); plot(t,f)

% d


%f 
roots_f = RR_roots([1221,-4398,5960,-3602,819]);
p1f = roots_f(1);
p2f = roots_f(2);
p3f = roots_f(3);
p4f = roots_f(4);
Af = (p1f^3 + 3*p1f^2 + 3*p1f + 1) / ((p1f-p2f)*(p1f-p3f)*(p1f-p4f));
Bf = (p2f^3 + 3*p2f^2 + 3*p2f + 1) / ((p2f-p1f)*(p2f-p3f)*(p2f-p4f));
Cf = (p3f^3 + 3*p3f^2 + 3*p3f + 1) / ((p3f-p1f)*(p3f-p2f)*(p3f-p4f));
Df = (p4f^3 + 3*p4f^2 + 3*p4f + 1)/ ((p4f-p1f)*(p4f-p2f)*(p4f-p3f));
t = 0:0.01:100;
ff = Af*p1f.^t + Bf*p2f.^t + Cf*p3f.^t + Df*p4f.^t;
figure(2); plot(t,ff)
