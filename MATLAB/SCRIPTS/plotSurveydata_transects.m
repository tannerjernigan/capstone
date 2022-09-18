%%
fdir = 'D:\CLASSES_2021_2022\Fall_2022\EGN_495\capstone\usace_survey_data';
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

%%
figure();
geobasemap satellite;
hold on;
i = 8;
a = repmat(15, [1,length(survey{i}.lat)]);
geoscatter(survey{i}.lat, survey{i}.lon, a, 'filled');
for j = 1:length(survey{i,1}.profile)
    if survey{i,1}.profile{j,1} == 'CB_01'
        geoscatter(survey{i}.lat(j), survey{i}.lon(j), 'r', 'filled')
    elseif survey{i,1}.profile{j,1} == 'CB_06'
        geoscatter(survey{i}.lat(j), survey{i}.lon(j), 'r', 'filled')
    elseif survey{i,1}.profile{j,1} == 'CB_11'
        geoscatter(survey{i}.lat(j), survey{i}.lon(j), 'r', 'filled')
    elseif survey{i,1}.profile{j,1} == 'CB_15'
        geoscatter(survey{i}.lat(j), survey{i}.lon(j), 'r', 'filled')
    elseif survey{i,1}.profile{j,1} == 'CB_19'
        geoscatter(survey{i}.lat(j), survey{i}.lon(j), 'r', 'filled')
    elseif survey{i,1}.profile{j,1} == 'CB_23'
        geoscatter(survey{i}.lat(j), survey{i}.lon(j), 'r', 'filled')
    end
end