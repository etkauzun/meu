clear all; clc; close all; format long
%% hw4_q2

load('T-38Aileron.mat');
JD = table2array(JSBsimData(:,:))*180/pi;
t = [0:0.1:25];
c2 = JD(:,1);
c1 = JD(:,2);
figure(1)
plot(t,c1,'g','LineWidth',2)
hold on
plot(t,c2,'m','LineWidth',2)
xline(1,':')
xline(9,'-')
xline(5,'--')
xline(13,'-.')
hold off
title('T-38 Pitch: Time Response')
xlabel('Time [s]')
ylabel('Pitch Rate Response [deg/s]')
legend('Pitch (SAS)','Pitch (no SAS)','Normalized Elevator Command: 0','Normalized Elevator Command: 0.1','Normalized Elevator Command: 0.1','Normalized Elevator Command: 0')