function [Solar_Angle] = calc_SolarAngle(day,hour,lat,long)
%SOLARZENITH Calculates the solar zenith for given hour and day
%% INPUTS
    % day = day of year
    % hour = hour of day
    % lat = latitude of location of interest
    % long = longitude of location of interest

%% OUTPUT
    % Solar_Angle = the angle of the sun at given time and location
        % this can be negative if it is night time
        % angle of 0 means that it is sunset or sunrise
        % angle of 90 means the sun is directly above the surface
        % noon is not necessarily 90 deg
    
% note that time input should be in geenwich time, so +0 hour timezone!

%% calculations
latitude = lat;
longitude = long;

% difference with greenwich time
LSTM = 0;

% equation of time
B = (360/365)*(day-81);
EoT = 9.87*sind(2*B) - 7.53*cosd(B) - 1.5*sind(B);

% the Earth rotates 1° every 4 minutes
% time correction
TC = 4*(longitude-LSTM)+EoT; % [min]

% local solar time
LST = hour + TC/60; % [hour]

% hour angle, noon = 0deg
HRA = 15 * (LST-12); % [deg]

% declination
declination = 23.45 * sind(B); % [deg]


% Elevation and Azimuth
a = asind(sind(declination).*sind(latitude)+cosd(declination) .* ...
    cosd(latitude).*cosd(HRA));
%Azimuth = acosd((sind(declination).*cosd(latitude)+cosd(declination) .* ...
 %   sind(latitude).*cosd(HRA)) ./ cosd(a));

Solar_Angle = a;


end

