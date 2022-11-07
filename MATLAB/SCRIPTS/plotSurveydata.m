%% This scripts loads and plots USACE Survey Data

clear; clc; close all;

% Path to functions you use
addpath C:\Users\tajer\OneDrive\Documents\EGN495\capstone\MATLAB\FUNCTIONS
%% Path to data

% Path to data
fdir = 'C:\Users\tajer\OneDrive\Documents\EGN495\capstone\data\usace_survey_data';
files = dir(fullfile(fdir,'*.csv'));


%% Loading Data

survey = cell(length(files),1);
ct = 0;
for i = 1:length(files)
    ct = ct + 1;
    fname = files(i).name;
    fid = fopen(fullfile(fdir,fname)); % opening file
    if fname == 'NHC2019_Carolina_Beach_Profiles.csv'
        formatspec = '%s%s%s%f%s%f%f%f%f';
    elseif fname == 'NHC2020_Carolina_Beach_Profiles.csv'
        formatspec = '%s%s%s%f%s%f%f%f%f';
    elseif fname == 'NHC2021_Carolina_Beach_Profiles.csv'
        formatspec = '%s%s%s%f%s%f%f%f%f';
    else
        formatspec = '%s%s%f%s%s%f%f%f%f';
    end
    data = textscan(fid,formatspec,'headerlines',1,'delimiter',','); % reading .csv files
    fclose(fid); % closing file 

    s.location = data{1};
    s.profile = data{2};
    s.date = data{3};
    if fname == 'NHC2017_Carolina_Beach_Profiles.csv'
        s.time = datetime(data{4},'InputFormat','HH:mm:ss.ss');
    elseif fname == 'NHC2019_Carolina_Beach_Profiles.csv'
        s.time = datetime(data{5},'InputFormat','HH:mm:ss');
    elseif fname == 'NHC2020_Carolina_Beach_Profiles.csv'
        s.time = datetime(data{5},'InputFormat','HH:mm:ss');
    elseif fname == 'NHC2021_Carolina_Beach_Profiles.csv'
        s.time = datetime(data{5},'InputFormat','HH:mm:ss');
    else
        s.time = datetime(data{4},'InputFormat','HH:mm:ss');
    end
    s.method = data{5};
    s.x = data{6};
    s.y = data{7};
    s.z = data{8};
    s.DBL = data{9};

    [s.lon, s.lat] = sp_proj('North Carolina', 'Inverse', s.x, s.y, 'sf');

    survey{ct} = s;
end
clear s data fid files ct ans fdir fname

%% Plot on whole survey to determine gridding not geoscatter

figure(1);
scatter3(survey{1}.x, survey{1}.y, survey{1}.z, 15, survey{1}.z, 'filled');
view([0,90]); c = colorbar(); ylabel(c, 'Elevation [m, NAVD88]'); colormap(viridis);
xlabel('Eastings [ft, State Plane, NAD83]');
ylabel('Northings [ft, State Plane, NAD83]');
zlabel('Elevation [ft, NAVD88]');
set(gcf, 'Color', 'w');

%% Geoscatter plot

a = repmat(15, [1,length(survey{1}.lat)] );
figure(2);
geoscatter(survey{1}.lat, survey{1}.lon, a, survey{1}.z); geobasemap satellite;
c = colorbar();


%% Plotting all years on same geoscatter

colorList = ['r'; 'b'; 'k'; 'y'; 'g'; 'c'; 'm'; 'w'];
figure(3);
geobasemap satellite;
hold on;
for i = 1:length(colorList)
    a = repmat(15, [1,length(survey{i}.lat)]);
    geoscatter(survey{i}.lat, survey{i}.lon, a, 'filled');
    drawnow();
    pause(0.5);
end
legend('2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021');
% geoscatter(yg_lat(40,:), xg_lon(40,:), a, 'r', 'filled')
% WE PLOTTED ALONG 5TH TRANSECT FROM THE BOTTOM

%% Making grid (rotating)

coefficients = polyfit([2333590, 2338620], [98278.8, 96772.6], 1);
theta = 17.5;

eastings_origin = 2333590;
northings_origin = 98278.8;

eastings_local = survey{1}.x - eastings_origin;
northings_local = survey{1}.y - northings_origin;

% rotating data
xy = [eastings_local northings_local]';
rot_mat = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];
xy_rot = rot_mat * xy;

%% plotting rotated grid

figure(4);
plot(xy_rot(1,:), xy_rot(2,:), '.k')
xlabel('X Local');
ylabel('Y Local');

%% Making grid

x = 0:1:5000;
y = 0:100:17400;
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

figure(5);
plot(xg, yg, 'r');
hold on;
plot(survey{1}.x, survey{1}.y,'.k'); box on; grid on;

%% interpolating to get surface

for i = 1:length(survey)
    survey{i}.zq = griddata(survey{i}.x,survey{i}.y,survey{i}.z,xg,yg);
end

%% plotting transect

figure(7);
box on; grid on;
xlabel('Cross-shore [ft]');
ylabel('Elevation [ft, NAVD88]');
%title('Transect Evolution since 2014');
%ylim([min(survey{7}.zq(175,:)) max(survey{7}.zq(175,:))]);
%xlim([2334740 2336300]);
set(gcf, 'color', 'w');
hold on;
for i = 1:length(survey)
    plot(xg(1,:), survey{i}.zq(1,:), 'LineWidth', 2);
    drawnow();
    pause(0.5);
end
legend('2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021');

%% plotting transect on map

xg_lon = zeros(size(xg));
yg_lat = zeros(size(yg));

for i = 1:length(xg(:,1))
    [xg_lon(i,:), yg_lat(i,:)] = sp_proj('North Carolina','inverse',xg(i,:),yg(i,:),'sf');
end

figure(8);
geobasemap satellite;
hold on;
for i = 1:length(xg(:,1))
    a = repmat(15, [1,length(xg(i,:))]);
    geoscatter(yg_lat(i,:), xg_lon(i,:), a, 'b');
end
geoscatter(yg_lat(40,:), xg_lon(40,:), a, 'r', 'filled') %t05
geoscatter(yg_lat(175,:), xg_lon(175,:), a, 'r', 'filled') % t01
geoscatter(yg_lat(1,:), xg_lon(1,:), a, 'r', 'filled') % t06
geoscatter(yg_lat(80,:), xg_lon(80,:), a, 'r', 'filled') %t04
geoscatter(yg_lat(122,:), xg_lon(122,:), a, 'r', 'filled') %t03
geoscatter(yg_lat(149,:), xg_lon(149,:), a, 'r', 'filled') %t02

%% plotting cross shore profiles

figure(9);

box on; grid on; hold on;


%% surface evolution difference from 2014 to 2021

zq_diff1 = survey{7}.zq - survey{6}.zq;
zq_diff2 = survey{8}.zq - survey{7}.zq;

figure(10);
colormap viridis;
set(gcf, 'color', 'w');
hold on;

subplot(1,2,1)
pcolor(xg, yg, zq_diff1); shading flat;
axis equal;
caxis([-5 5]);
xlabel('Eastings [ft, State Plane, NAD83]');
ylabel('Northings [ft, State Plane, NAD83]');

subplot(1,2,2)
pcolor(xg, yg, zq_diff2); shading flat;
caxis([-5 5]);
axis equal;
xlabel('Eastings [ft, State Plane, NAD83]');


%% bs for jacob

xyz(:,2) = yg(:);
xyz(:,3) = xg(:);
xyz(:,4) = survey{8}.zq(:);

xyz(:,1) = 1:length(xg(:));



