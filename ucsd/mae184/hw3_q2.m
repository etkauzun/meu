% hw3_q2
clc; clear all; close all;

table = [113 9.4;122 10; 131 10.6;...
        140 11.3; 147 11.9; 156 12.6;...
        166 13.3;175 14];

table(:,2) = table(:,2)*6; % converting from gal/hr to lbf/hr

figure(1); plot(table(:,1), table(:,2)); 

ans = 0.4506 % slope of the line = cp

% since dw/dt = -cp*P, the slope corresponds to co

