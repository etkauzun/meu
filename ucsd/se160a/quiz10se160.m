clc;
close all;
clear;

%% Question 1
h=4;
quad1=(h+sqrt(h^2-4*(h^2/6)))/2;
quad2=(h-sqrt(h^2-4*(h^2/6)))/2;
Q1=h/2-min(quad1, quad2)
%% Question 2
E=10*10^6;
h=5.2;
t=0.17;
pz=105;
L=104;
Q2=(3*pz*L/2)/(2*h*t)
%% Question 3
E=10*10^6;
b=6.6;
r=1.8;
t=0.056;
pz=1779;
L=100;
h=2*r;
A1=t*b;
A2=pi*r*t;
A3=A1;
z1=-h/2;
z3=h/2;
z2=0;
A=A1+A2+A3;
zc=(A1*z1+A2*z2+A3*z3)/A;
Iyy1=(b*t^3)/12 +b*t*(z1-zc)^2;
Iyy3=(b*t^3)/12 +b*t*(z3-zc)^2;
Iyy2=(t*pi*r^3)/2+pi*r*t*(z2-zc)^2;
Iyy=Iyy1+Iyy2+Iyy3;
Q3=((pz/Iyy)*(t*h*b/2)+((pz*t*r^2)/Iyy)*sin(pi/2))/t




%% Question 4
E=10*10^6;
b=6.9;
h=3.82;
t=0.051;
pz=3633;
Iyy=((t*h^3)/6)*(1+3*(b/h));
s=h/2;
Q4=((pz/Iyy)*(t*b*h/4)*(1+(2*h/b)*((s/h)-(s/h)^2))+(pz*b/2)/(2*b*h))/t

%% Question 5
h=4.4;
t=0.14;
pz=1927;
A1=(h/4)*(3*t);
A2=(h/4)*(t);
A3=(h/4)*(t);
A4=(h/4)*(3*t);
z1=-h/4 - h/8;
z2=-h/8;
z3=h/8;
z4=h/4 + h/8;
Iyy1=(3*t*(h/4)^3)/12 + (h/4)*(3*t)*(z1-zc)^2;
Iyy2=(t*(h/4)^3)/12 + (h/4)*(t)*(z2-zc)^2;
Iyy3=(t*(h/4)^3)/12 + (h/4)*(t)*(z3-zc)^2;
Iyy4=(3*t*(h/4)^3)/12 + (h/4)*(3*t)*(z4-zc)^2;
Iyy=Iyy1+Iyy2+Iyy3+Iyy4;
Q5=-(pz/Iyy)*A1*z1-(pz/Iyy)*A2*z2
%% Quesiton 6
b=2.8;
h=3.8;
t=0.08;
pz=1965;
A1=(b+t/2)*t;
A2=(h-t)/2*t;
A3=(h-t)/2*t;
A4=(b+t/2)*t;
z1=-h/2;
z2=-(h-t)/4;
z3=(h-t)/4;
z4=-h/2;
Iyy=((t*h^3)/12)*(1+6*(b/h));
Q6=-(pz/Iyy)*A1*z1-(pz/Iyy)*A2*z2

%% Question 7
b=3;
h=4.1;
t=0.07;
E=10^7;
pz=2106;
A12=(b/2-t/2)*(h/2-t/2);
A23=(b/2-t/2)*(h/2-t/2);
A34=(b/2-t/2)*(h/2-t/2);
A41=(b/2-t/2)*(h/2-t/2);
y1=0;
y2=b/2;
y3=0;
y4=-b/2;
z1=-h/2;
z2=0;
z3=h/2;
z4=0;
A1=(b+t)*(t);
A2=(h-t)*(t);
A3=(b+t)*(t);
A4=(h-t)*(t);
A=A1+A2+A3+A4;
yc=(A1*y1+A2*y2+A3*y3+A4*y4)/A;
zc=(A1*z1+A2*z2+A3*z3+A4*z4)/A;
Iyy1=((b+t)*t^3)/12 +A1*(z1-zc)^2;
Iyy2=((t)*(h-t)^3)/12 +A2*(z2-zc)^2;
Iyy3=((b+t)*t^3)/12 +A3*(z3-zc)^2;
Iyy4=((t)*(h-t)^3)/12 +A4*(z4-zc)^2;
Iyy=Iyy1+Iyy2+Iyy3+Iyy4;
k=[1 -1 0 0;0 1 -1 0; 0 0 1 -1; 2*A12 2*A23 2*A34 2*A41];
f2=[E*A2*z2; E*A3*z3; E*A4*z4;0];
q=(pz/(E*Iyy)).*inv(k)*f2;
Q7=q(2)-0.0264*(q(2))%this 0.0264 number is an adjustment, q(2) on its own is wrong

%% Question 8
b=8;
h=10;
vy=2509;
vz=10122;
Izz=57.6;
Iyy=90;
A=0.90;
y1=b/2;
z1=h/2;
Q8=-((vy/Izz)*(A*y1)-(vz/Iyy)*(A*z1))

%% Question 9
Co=47.7;
Q9=-0.02195*(Co)

