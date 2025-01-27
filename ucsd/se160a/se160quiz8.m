clc;
clear;
close;

%% question 1
% p=247;
% L=1.3;
% d=p/4;
% f=p-d;
% Q1=((f-p)*(L/2 *L^2))/(L^4*1/12)/2

%% question 2
p=389;
Q2=p*3/8

%% question 3
L=107;
c=L/15;
pzo=0.44;
Q3=-pzo*(L-L/5)*(c/2 - c/4)

%% question 4
L=110;
c=L/15;
pzo=0.33;
Q4=(-pzo*((L^2)/2 - (L^2)/6))

%% question 5
A=4;
Iyy=8;
Izz=600;
Iyz=9;
Vx=0;
Vy=500;
Vz=2000;
Mx=-20000;
My=-177353;
Mz= 42163;
sigmaxxT=40000;
sigmaxxC=-35000;
y=-10;
z=-2;
testload=Vx/A -y*((Iyy*Mz+Iyz*My)/(Iyy*Izz-Iyz^2)) +z*((Izz*My+Iyz*Mz)/(Iyy*Izz-Iyz^2));
Q5=sigmaxxT/testload-1