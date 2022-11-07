%% This script loads, plots, and interpolates survey data collected on 20 September 2022

close all; clc; clear;

addpath C:\Users\tajer\OneDrive\Documents\EGN495\capstone\MATLAB\FUNCTIONS

%% Loading data

fdir = 'C:\Users\tajer\OneDrive\Documents\EGN495\capstone\data\20220919_survey_data';
files = dir(fullfile(fdir,'*.csv'));

% Name,Easting,Northing,Elevation,Description,Longitude,Latitude,Ellipsoidal height,
% Easting RMS,Northing RMS,Elevation RMS,Lateral RMS,Antenna height,Antenna height units,
% Solution status,Averaging start,Averaging end,Samples,PDOP,Base easting,Base northing,
% Base elevation,Base longitude,Base latitude,Base ellipsoidal height,Baseline,CS name

formatspec = '%s%f%f%f%s%f%f%f%f%f%f%f%f%s%s%s%s%f%f%f%f%f%f%f%f%f%s';
fname = files.name;
fid = fopen(fullfile(fdir,fname)); % opening file
data = textscan(fid,formatspec,'headerlines',1,'delimiter',','); % reading .csv files
fclose(fid); % closing file 

antennaheight = 6.345;

s.lat = data{7};
s.lon = data{6};
s.x = data{2};
s.y = data{3};
s.z_ellip = data{4};

survey{1} = s;

clear ans fdir fid files fname formatspec s

%% Getting into NAVD88

survey{1}.z = zeros(length(survey{1}.x), 1);
for i = 1:length(survey{1}.x)
    survey{1}.z(i) = ((survey{1}.z_ellip(i)/3.281) - geoidheight(survey{1}.lat(i), survey{1}.lon(i)) - (antennaheight/3.281))*3.281;
end

%% Plotting to check locations and height

a = repmat(15, [1,length(survey{1}.lat)] );
figure(1);
geoscatter(survey{1}.lat, survey{1}.lon, a, survey{1}.z, 'filled'); geobasemap satellite;
c = colorbar();
set(gcf, 'Color', 'w');
ylabel(c, 'Elevation [ft, NAVD88]');

%% Plotting ENU for gridding

figure(2);
scatter3(survey{1}.x, survey{1}.y, survey{1}.z, 15, survey{1}.z, 'filled');
view([0,90]); c = colorbar(); ylabel(c, 'Elevation [m, NAVD88]'); colormap(viridis);
xlabel('Eastings [ft, State Plane, NAD83]');
ylabel('Northings [ft, State Plane, NAD83]');
zlabel('Elevation [ft, NAVD88]');
set(gcf, 'Color', 'w');

%% Making a grid

theta = 17.5;

eastings_origin = 2333650;
northings_origin = 98261.5;

eastings_local = survey{1}.x - eastings_origin;
northings_local = survey{1}.y - northings_origin;

% rotating data
xy = [eastings_local northings_local]';
rot_mat = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];
xy_rot = rot_mat * xy;

%% plotting rotated grid

figure(3);
plot(xy_rot(1,:), xy_rot(2,:), '.k')
xlabel('X Local');
ylabel('Y Local');

%% Making grid

x = 0:10:700;
y = 0:100:17000;
[xg, yg] = meshgrid(x, y);

%% getting back to og points

theta = -theta;
xy = [xg(:) yg(:)]';
rot_mat = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];
xygrid = rot_mat * xy;

% reshaping grid
Xqr = reshape(xygrid(1,:), size(xg,1), []);
Yqr = reshape(xygrid(2,:), size(yg,1), []);

% adding origin
xg = Xqr + eastings_origin;
yg = Yqr + northings_origin;

clear Xqr Yqr zy rot_mat theta northings_origin eastings_origin eastings_local northings_local coefficients x y xygrid

%% plotting to check

figure(4);
plot(xg, yg, 'r');
hold on;
plot(survey{1}.x, survey{1}.y,'.k'); box on; grid on;

%% interpolating and grid in lat/lon

for i = 1:length(survey)
    survey{i}.zq = griddata(survey{i}.x,survey{i}.y,survey{i}.z,xg,yg);
end

xg_lon = zeros(size(xg));
yg_lat = zeros(size(yg));

for i = 1:length(xg(:,1))
    [xg_lon(i,:), yg_lat(i,:)] = sp_proj('North Carolina','inverse',xg(i,:),yg(i,:),'sf');
end


%% geoscatter surface

figure(5);
geobasemap satellite;
hold on;
for i = 1:length(xg(:,1))
    a = repmat(15, [1,length(xg(i,:))]);
    geoscatter(yg_lat(i,:), xg_lon(i,:), a, 'b');
end
geoscatter(yg_lat(40,:), xg_lon(40,:), a, 'r', 'filled')


%% cs profile

% figure(6);
% box on; grid on;
% xlabel('Cross-shore [ft]');
% ylabel('Elevation [ft, NAVD88]');
% title('Transect Elevation Change');
% ylim([min(survey{1}.zq(40,:)) max(survey{1}.zq(40,:))]);
% % xlim([2334740 2336300]);
% set(gcf, 'color', 'w');
% hold on;
% 
% plot(xg(40,:), surf2022(1:10:710), 'LineWidth', 2);
% 
% 
% 
% plot(xg(40,:), survey{1}.zq(40,:), 'LineWidth', 2);
% legend('2022', '2022 Surveyed');
% 


%% 

figure(6);
colormap viridis;
set(gcf, 'color', 'w');
hold on; box on; grid on;

pcolor(xg, yg, survey{1}.zq); shading flat;
xlabel('Eastings [ft, State Plane, NAD83]');
ylabel('Northings [ft, State Plane, NAD83]');



