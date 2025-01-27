% hw1_q3
clear; clc; format long

coord = ... 
   [32.7335556, -117.1896667; % KSAN
    30.2858333, -131.6361111; % ETECO
    28.7016667, -139.4266667; % DIALO
    26.0061111, -146.1675000; % DUSAC
    23.0241667, -152.5777778; % DRAYK
    21.3178275, -157.9202627];% PHNL
coord = deg2rad(coord);

% finding the great cirlce path
a = 6378137 / 1000; % WGS-84 semi-major axis [km]
Dgc = a * acos( sin(coord(1,1))*sin(coord(6,1)) ...
    + cos(coord(1,1))*cos(coord(6,1))*cos(coord(6,2)-coord(1,2)));

% finding the rhumb line path
rhumb = []; % the rhumb course array
% φ: latitude
% λ: longitude

for i=2:length(coord)
    lat_a = coord(i-1,1); lat_b = coord(i,1);
    longt_a = coord(i-1,2); longt_b = coord(i,2);
    tau_a = log(sec(lat_a) + tan(lat_a));
    tau_b = log(sec(lat_b) + tan(lat_b));
    heading = atan((longt_b-longt_a)/(tau_b-tau_a));
    Drh = a*abs(lat_b-lat_a)*abs(sec(heading));
    rhumb = [rhumb, Drh];
end % for loop

rhumb_dist = sum(rhumb);

ans = abs(rhumb_dist-Dgc)