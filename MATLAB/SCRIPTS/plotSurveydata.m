%% This scripts loads and plots USACE Survey Data

clear; clc; close all;

% Path to functions you use
addpath C:\Users\tajer\OneDrive\Documents\EGN495\capstone\MATLAB\FUNCTIONS
%% Path to data

% Path to data
fdir = 'C:\Users\tajer\OneDrive\Documents\EGN495\capstone\usace_survey_data';
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

a = repmat( 15, [1,length(survey{1}.lat)] );
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

%% Making grid





