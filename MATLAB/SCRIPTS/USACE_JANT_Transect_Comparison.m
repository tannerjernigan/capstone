%% This script compares our survey data to USACE survey transect

clear; clc; close all;

% Path to functions you use
addpath C:\Users\tajer\OneDrive\Documents\EGN495\capstone\MATLAB\FUNCTIONS

%% Loading Data

% Path to data
fdir = 'C:\Users\tajer\OneDrive\Documents\EGN495\capstone\data\usace_survey_data';
files = dir(fullfile(fdir,'*.csv'));

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

%% Loading our data

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

survey_JANT{1} = s;

clear ans fdir fid files fname formatspec s data

%% Getting into NAVD88

survey_JANT{1}.z = zeros(length(survey_JANT{1}.x), 1);
for i = 1:length(survey_JANT{1}.x)
    survey_JANT{1}.z(i) = ((survey_JANT{1}.z_ellip(i)/3.281) - geoidheight(survey_JANT{1}.lat(i), survey_JANT{1}.lon(i)) - (antennaheight/3.281))*3.281;
end

%% PLOTTING TO GET INDICES

figure(1);
scatter3(survey{8}.x, survey{8}.y, survey{8}.z, 15, 'b', 'filled');
view([0,90]);
xlabel('Eastings [ft, State Plane, NAD83]');
ylabel('Northings [ft, State Plane, NAD83]');
zlabel('Elevation [ft, NAVD88]');
set(gcf, 'Color', 'w');

hold on;

scatter3(survey_JANT{1}.x, survey_JANT{1}.y, survey_JANT{1}.z, 20, 'r', 'filled');
legend('2021 USACE', '2022 JANT Engineering', 'Location','southeast')

%% Our Transect

%(20:125) %t01
%(20181:20287) %t05

ct = 1:length(survey{8}.x);

figure(2);
scatter3(survey{8}.x, survey{8}.y, ct, 15, 'b', 'filled');
view([0,90]);
xlabel('Eastings [ft, State Plane, NAD83]');
ylabel('Northings [ft, State Plane, NAD83]');
zlabel('Elevation [ft, NAVD88]');
set(gcf, 'Color', 'w');

hold on;

%(1:18) %to1
%(116:146) %to5

ct1 = 1:length(survey_JANT{1}.x);

scatter3(survey_JANT{1}.x, survey_JANT{1}.y, ct1, 20, 'r', 'filled');
legend('2021 USACE', '2022 JANT Engineering', 'Location','southeast')

%% Cross-shore profile

ind1 = (24478:24560);
ind2 = (147:169);

cs_usace = survey{8}.x(ind1) - survey{8}.x(ind1(1));
cs_jant = survey_JANT{1}.x(ind2) - survey_JANT{1}.x(ind2(1));

figure(3);
plot(cs_usace, survey{8}.z(ind1), 'r', 'LineWidth', 2);
box on; grid on;
hold on;
xlim([cs_usace(1) cs_usace(end)]);
plot(cs_jant, survey_JANT{1}.z(ind2), 'b', 'LineWidth', 2);
xlabel('Cross-shore Distance [ft]'); ylabel('Elevation [ft, NAVD88]');
legend('2021 USACE', '2022 JANT Engineering')
set(gcf, 'Color', 'w');

%% trying to interpolate
% 
% Vq = interp1(unique(survey{8}.x(20182:20295)), unique(survey{8}.z(20182:20295)), unique(survey_JANT{1}.x(116:146)));
% plot(flip(survey_JANT{1}.x(116:146)), Vq, 'k', 'LineWidth', 2);

colorList = ['r'; 'b'; 'k'; 'y'; 'g'; 'c'; 'm'; 'w'];
figure(4);
geobasemap satellite;
hold on;
for i = 1:length(colorList)
    a = repmat(15, [1,length(survey{i}.lat)]);
    geoscatter(survey{i}.lat, survey{i}.lon, a, 'filled');
    drawnow();
    pause(0.5);
end
a = repmat(15, [1,length(survey_JANT{1}.lat)] );
geoscatter(survey_JANT{1}.lat, survey_JANT{1}.lon, a, 'filled'); geobasemap satellite;

set(gcf, 'Color', 'w');
legend('2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022');