clear all; close all; clc;

% data 
airspeed_m = [117, 122, 127, 131, 135, 138, 141, 144]* 1.68781; % manufacturer
horsepower_hp = [113, 122, 131, 140, 147, 156, 166, 175];
jsb_horsepower = [116.136855, 124.312669, 133.553586, 141.638287, 150.251436, 157.164603, 164.469718, 172.170393]; % from manually running JSBSim


figure;
hold on;
plot(airspeed_m, horsepower_hp, 'b-');
plot(airspeed_m, jsb_horsepower, 'ro', 'MarkerSize', 5);
xlabel('True Airspeed [kts]');
ylabel('Brake Horsepower [hp]');
legend('Manufacturer Suggested Brake Horsepower', 'JSBSim Brake Horsepower');
title('Cessna 182 Cruise Performance');
hold off;

