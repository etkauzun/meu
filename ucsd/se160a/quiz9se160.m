clc;
clear;
close all; 

%% Question 1
T=548;
MS=0.09;
shearmax=27000;
Q1=(((MS+1)*T)/(shearmax*pi/2))^(1/3)

%% Question 2
twist=4.6;
G=3.75*10^6;
a=2;
b=0.5;
L1=14;%circular section
L2=10;%elliptical section
J1=(pi/2)*(b^4);%circle
J2=(pi*a^3*b^3)/(a^2+b^2);%ellipse
Q2=(twist/((L1/(G*J1))+(L2/(G*J2))))*pi/180

%% Question 3
a=11.7;
t=0.21;
b=3*a;
Q3=1/3*(2*b*t^3+2*a*t^3)

%% Question 4
a=10.4;
t=0.25;
h=3*a;
b=a;
Q4=(2*b^2*h^2)/((b/t)+(h/t))

%% Question 5
a=4.9;
to_sk=0.11;
Co=2*a+2*a+4*a;
tmax=a;
Circum= ((1/2)*pi*( 3*(Co/4 + tmax/2) - sqrt( (3*Co/4 + tmax/2) * (Co/4 + 3*tmax/2) ) ) + 2*(Co/4) + 2*(sqrt( (tmax/2).^2 + (Co/2).^2)) );
A=(pi*(Co/4)*(tmax/2))/2 + (Co/4)*(tmax) +((tmax)*(Co/2))/2;
Q5=(4*to_sk*A^2)/Circum


%% Question 6
a=4.1;
to_sk=0.08;
Mx=212338;
Co=2*a+2*a+4*a;
tmax=a;
A=(pi*(Co/4)*(tmax/2))/2 + (Co/4)*(tmax) +((tmax)*(Co/2))/2;
Q6=Mx/(2*A*to_sk)



%% Question 7
a=4;
to_sk=0.09;
Co=2*a+2*a+4*a;
tmax=a;
Circum= ((1/2)*pi*( 3*(Co/4 + tmax/2) - sqrt( (3*Co/4 + tmax/2) * (Co/4 + 3*tmax/2) ) ) + 2*(Co/4) + 2*(sqrt( (tmax/2).^2 + (Co/2).^2)) );
A=(pi*(Co/4)*(tmax/2))/2 + (Co/4)*(tmax) +((tmax)*(Co/2))/2;
Q7=(4*to_sk*A^2)/Circum

%% Question 8
G=3.75*10^6;
a=4.1;
to_sk=0.06;
Mx=217086;
% Co=2*a+2*a+4*a;
% tmax=a;
A1=1/2*pi*a^2;
A2=4*a^2;
S1=1/2*pi*(3*(2*a+1/2*a)-sqrt((6*a+1/2*a)*(2*a+3/2*a)));
S2=a;
S3=2*sqrt((4*a)^2+(a/2)^2)+2*(2*a);
B=[pi*a^2, 8*a^2; ((S1+S2)/A1 + S2/A2), -(S2/A1 + (S2+S3)/A2)];
mx=[Mx;0];
q=inv(B)*mx;
%DthetaDx=1/(2*A1*G*to_sk)*((S1+S2)*q(1)-S2*q(2));
%J=G/DthetaDx;
Q8=q(1)/to_sk
%% Question 9
G=3.75*10^6;
a=4.5;
L=200;
to_sk=0.06;
Mx=206854;
Co=2*a+2*a+4*a;
tmax=a;
A1=1/2*pi*a^2;
A2=4*a^2;
S1=1/2*pi*(3*(2*a+1/2*a)-sqrt((6*a+1/2*a)*(2*a+3/2*a)));
S2=a;
S3=2*sqrt((4*a)^2+(a/2)^2)+2*(2*a);
B=[pi*a^2 8*a^2; ((S1+S2)/A1 + S2/A2) -(S2/A1 + (S2+S3)/A2)];
mx=[Mx;0];
q=inv(B)*mx;
DthetaDx=1/(2*A1*G*to_sk)*((S1+S2)*q(1)-S2*q(2));
%J=G/DthetaDx;
Q9=DthetaDx*L*180/pi
