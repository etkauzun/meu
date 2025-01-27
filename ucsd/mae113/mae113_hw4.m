clear all; clc; close all;

B = 10;
To4 = 1400;
Toa = 295;
To2 = Toa;
Poa = 100000;
Po2 = Poa;
Pa = 100000;
R = 287;
grat = 1.35/0.35;
grat2 = 0.35/1.35;
Prf = 1.5;
Prc = 10:0.01:30;
% Calculating Values
Po8 = Po2*Prf;
To8 = To2*(1 + 1 * (Prf^(grat2) -1 ));
uef = sqrt(2 * 1 * grat * R * To8 * (1 - (Pa/Po8)^grat2));
To3 = To2*(1 + 1 * (Prc.^grat2 - 1));
To5 = To4 - (To3 - To2) - (B * (To8 - Toa));
To6 = To5;
P04 = Po2*Prc;
Po5 = P04.*((1 - (1 - To5./To4)).^grat) ;
Po6 = Po5;
ue = sqrt (2*1*grat*287*To6.*(1-(Pa./Po6).^grat2));
T = ue + B * uef;
[V, I] = max (T);
T_max = T(I) ;
Prc_max = Prc(I);
plot (Prc, T)
title( 'Takeoff Thrust as func. of Compressor Pressure Ratio')
xlabel('Compressor Pressure Ratio (Prc)')
ylabel ('Takeoff Thrust [N]')
hold on
plot (Prc_max, T_max, ' r')
hold off
grid('on')
legend ('Takeoff Thrust Curve', 'Maximum Takeoff Thrust' ,Location='South')
Prc_max
T_max