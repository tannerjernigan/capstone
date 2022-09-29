%% EGN 495 - Engineering Capstone
% Purpose:      Find range and average of wave parameters for Carolina Beach.
% Parameters:   Significant Wave Height (Hs)    Unit: meters
%               Peak Wave Period (Tp)           Unit: seconds
%               Peak Wave Direction (Dp)        Unit: degrees North
%
% Buoys:        CORMP - ILM2WAVE
%               UNCW  - MASE-01
%               UNCW  - BHI-E
% Date Range:   Sept 22, 2021 - Sept. 21, 2022
%
% Ashley Holsclaw
% Sept. 24, 2022
clear; clc
%% ILM2WAVE - Set Path to Data

user1 = 'D:\CLASSES_2021_2022\Fall_2022\EGN_495\';
fdir = [user1 'capstone\wave_buoy_data\CORMP_ILM2WAVE'];
files = dir(fullfile(fdir,'*.csv'));

%% ILM2WAVE - Load Data

for i = 1:length(files)
    fname = files(i).name;
    fid = fopen(fullfile(fdir,fname));
    formatspec = "%s%f%s"; % Datetime, Parameter Value, Data Quality
    if fname == "Hs_22sept2021_21sept2022.csv"
        ILM2WAVE.Hs = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % m
    elseif fname == "Tp_22sept2021_21sept2022.csv"
        ILM2WAVE.Tp = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % s
    elseif fname == "Dp_22sept2021_21sept2022.csv"
        ILM2WAVE.Dp = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % deg N
    end
    fclose(fid);
end

%% ILM2WAVE - Find Min, Max, & Mean Stats for each season

% Autumn 2021

dt_range.autumn.lower = find(contains(ILM2WAVE.Hs{1,1},'2021-09-22 00:11')); % first day of season
dt_range.autumn.upper = find(contains(ILM2WAVE.Hs{1,1},'2021-12-20 23:30')); % last day of season

    % Min Hs, Tp, Dp
    ILM2WAVE_stats.Hs.autumn.min = min(ILM2WAVE.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    ILM2WAVE_stats.Tp.autumn.min = min(ILM2WAVE.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    ILM2WAVE_stats.Dp.autumn.min = min(ILM2WAVE.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    
    % Max Hs, Tp, Dp
    ILM2WAVE_stats.Hs.autumn.max = max(ILM2WAVE.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    ILM2WAVE_stats.Tp.autumn.max = max(ILM2WAVE.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    ILM2WAVE_stats.Dp.autumn.max = max(ILM2WAVE.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));

    % Mean Hs, Tp, Dp
    ILM2WAVE_stats.Hs.autumn.mean = mean(ILM2WAVE.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    ILM2WAVE_stats.Tp.autumn.mean = mean(ILM2WAVE.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    ILM2WAVE_stats.Dp.autumn.mean = mean(ILM2WAVE.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));

% Winter 2021-2022

dt_range.winter.lower = find(contains(ILM2WAVE.Hs{1,1},'2021-12-21 00:00')); % first day of season
dt_range.winter.upper = find(contains(ILM2WAVE.Hs{1,1},'2022-03-19 23:30')); % last day of season

    % Min Hs, Tp, Dp
    ILM2WAVE_stats.Hs.winter.min = min(ILM2WAVE.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    ILM2WAVE_stats.Tp.winter.min = min(ILM2WAVE.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    ILM2WAVE_stats.Dp.winter.min = min(ILM2WAVE.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    
    % Max Hs, Tp, Dp
    ILM2WAVE_stats.Hs.winter.max = max(ILM2WAVE.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    ILM2WAVE_stats.Tp.winter.max = max(ILM2WAVE.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    ILM2WAVE_stats.Dp.winter.max = max(ILM2WAVE.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));

    % Mean Hs, Tp, Dp
    ILM2WAVE_stats.Hs.winter.mean = mean(ILM2WAVE.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    ILM2WAVE_stats.Tp.winter.mean = mean(ILM2WAVE.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    ILM2WAVE_stats.Dp.winter.mean = mean(ILM2WAVE.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));

% Spring 2022

dt_range.spring.lower = find(contains(ILM2WAVE.Hs{1,1},'2022-03-20 00:00')); % first day of season
dt_range.spring.upper = find(contains(ILM2WAVE.Hs{1,1},'2022-06-20 23:30')); % last day of season

    % Min Hs, Tp, Dp
    ILM2WAVE_stats.Hs.spring.min = min(ILM2WAVE.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    ILM2WAVE_stats.Tp.spring.min = min(ILM2WAVE.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    ILM2WAVE_stats.Dp.spring.min = min(ILM2WAVE.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    
    % Max Hs, Tp, Dp
    ILM2WAVE_stats.Hs.spring.max = max(ILM2WAVE.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    ILM2WAVE_stats.Tp.spring.max = max(ILM2WAVE.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    ILM2WAVE_stats.Dp.spring.max = max(ILM2WAVE.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));

    % Mean Hs, Tp, Dp
    ILM2WAVE_stats.Hs.spring.mean = mean(ILM2WAVE.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    ILM2WAVE_stats.Tp.spring.mean = mean(ILM2WAVE.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    ILM2WAVE_stats.Dp.spring.mean = mean(ILM2WAVE.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));

% Summer 2022

dt_range.summer.lower = find(contains(ILM2WAVE.Hs{1,1},'2022-06-21 00:00')); % first day of season
dt_range.summer.upper = find(contains(ILM2WAVE.Hs{1,1},'2022-09-21 23:30')); % last day of season

    % Min Hs, Tp, Dp
    ILM2WAVE_stats.Hs.summer.min = min(ILM2WAVE.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    ILM2WAVE_stats.Tp.summer.min = min(ILM2WAVE.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    ILM2WAVE_stats.Dp.summer.min = min(ILM2WAVE.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    
    % Max Hs, Tp, Dp
    ILM2WAVE_stats.Hs.summer.max = max(ILM2WAVE.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    ILM2WAVE_stats.Tp.summer.max = max(ILM2WAVE.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    ILM2WAVE_stats.Dp.summer.max = max(ILM2WAVE.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));

    % Mean Hs, Tp, Dp
    ILM2WAVE_stats.Hs.summer.mean = mean(ILM2WAVE.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    ILM2WAVE_stats.Tp.summer.mean = mean(ILM2WAVE.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    ILM2WAVE_stats.Dp.summer.mean = mean(ILM2WAVE.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));

%% MASE-01 - Set Path

fdir = [user1 'capstone\wave_buoy_data\UNCW_MASE-01'];
files = dir(fullfile(fdir,'*.csv'));

%% MASE-01 - Load Data

for i = 1:length(files)
    fname = files(i).name;
    fid = fopen(fullfile(fdir,fname));
    formatspec = "%s%f%s"; % Datetime, Parameter Value, Data Quality
    if fname == "Hs_22sept2021_21sept2022.csv"
        MASE_01.Hs = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % m
    elseif fname == "Tp_22sept2021_21sept2022.csv"
        MASE_01.Tp = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % s
        elseif fname == "Tm_22sept2021_21sept2022.csv"
        MASE_01.Tm = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % s
    elseif fname == "Dp_22sept2021_21sept2022.csv"
        MASE_01.Dp = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % deg N
    elseif fname == "Dm_22sept2021_21sept2022.csv"
        MASE_01.Dm = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % deg N
    end
    fclose(fid);
end

%% MASE-01 - Find Min, Max, & Mean Stats for each season

% Autumn 2021

dt_range.autumn.lower = find(contains(MASE_01.Hs{1,1},'2021-09-22 00:06')); % first day of season
dt_range.autumn.upper = find(contains(MASE_01.Hs{1,1},'2021-12-20 23:52')); % last day of season

    % Min Hs, Tp, Dp
    MASE_01_stats.Hs.autumn.min = min(MASE_01.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Tp.autumn.min = min(MASE_01.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Tm.autumn.min = min(MASE_01.Tm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Dp.autumn.min = min(MASE_01.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Dm.autumn.min = min(MASE_01.Dm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    
    % Max Hs, Tp, Dp
    MASE_01_stats.Hs.autumn.max = max(MASE_01.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Tp.autumn.max = max(MASE_01.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Tm.autumn.max = max(MASE_01.Tm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Dp.autumn.max = max(MASE_01.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Dm.autumn.max = max(MASE_01.Dm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));

    % Mean Hs, Tp, Dp
    MASE_01_stats.Hs.autumn.mean = mean(MASE_01.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Tp.autumn.mean = mean(MASE_01.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Tm.autumn.mean = mean(MASE_01.Tm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Dp.autumn.mean = mean(MASE_01.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    MASE_01_stats.Dm.autumn.mean = mean(MASE_01.Dm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));

% Winter 2021-2022

dt_range.winter.lower = find(contains(MASE_01.Hs{1,1},'2021-12-21 00:22')); % first day of season
dt_range.winter.upper = find(contains(MASE_01.Hs{1,1},'2022-03-19 23:33')); % last day of season

    % Min Hs, Tp, Dp
    MASE_01_stats.Hs.winter.min = min(MASE_01.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tp.winter.min = min(MASE_01.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tm.winter.min = min(MASE_01.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Dp.winter.min = min(MASE_01.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Dm.winter.min = min(MASE_01.Dm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    
    % Max Hs, Tp, Dp
    MASE_01_stats.Hs.winter.max = max(MASE_01.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tp.winter.max = max(MASE_01.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tm.winter.max = max(MASE_01.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Dp.winter.max = max(MASE_01.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tm.winter.max = max(MASE_01.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));

    % Mean Hs, Tp, Dp
    MASE_01_stats.Hs.winter.mean = mean(MASE_01.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tp.winter.mean = mean(MASE_01.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Tm.winter.mean = mean(MASE_01.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Dp.winter.mean = mean(MASE_01.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    MASE_01_stats.Dm.winter.mean = mean(MASE_01.Dm{1,2}(dt_range.winter.lower:dt_range.winter.upper));

% Spring 2022

dt_range.spring.lower = find(contains(MASE_01.Hs{1,1},'2022-03-20 00:03')); % first day of season
dt_range.spring.upper = find(contains(MASE_01.Hs{1,1},'2022-06-20 23:46')); % last day of season

    % Min Hs, Tp, Dp
    MASE_01_stats.Hs.spring.min = min(MASE_01.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Tp.spring.min = min(MASE_01.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Tm.spring.min = min(MASE_01.Tm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Dp.spring.min = min(MASE_01.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Dm.spring.min = min(MASE_01.Dm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    
    % Max Hs, Tp, Dp
    MASE_01_stats.Hs.spring.max = max(MASE_01.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Tp.spring.max = max(MASE_01.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Tm.spring.max = max(MASE_01.Tm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Dp.spring.max = max(MASE_01.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Dm.spring.max = max(MASE_01.Dm{1,2}(dt_range.spring.lower:dt_range.spring.upper));

    % Mean Hs, Tp, Dp
    MASE_01_stats.Hs.spring.mean = mean(MASE_01.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Tp.spring.mean = mean(MASE_01.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Tm.spring.mean = mean(MASE_01.Tm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Dp.spring.mean = mean(MASE_01.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    MASE_01_stats.Dm.spring.mean = mean(MASE_01.Dm{1,2}(dt_range.spring.lower:dt_range.spring.upper));

% Summer 2022

dt_range.summer.lower = find(contains(MASE_01.Hs{1,1},'2022-06-21 00:16')); % first day of season
dt_range.summer.upper = find(contains(MASE_01.Hs{1,1},'2022-09-21 23:46')); % last day of season

    % Min Hs, Tp, Dp
    MASE_01_stats.Hs.summer.min = min(MASE_01.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Tp.summer.min = min(MASE_01.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Tm.summer.min = min(MASE_01.Tm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Dp.summer.min = min(MASE_01.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Dm.summer.min = min(MASE_01.Dm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    
    % Max Hs, Tp, Dp
    MASE_01_stats.Hs.summer.max = max(MASE_01.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Tp.summer.max = max(MASE_01.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Tm.summer.max = max(MASE_01.Tm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Dp.summer.max = max(MASE_01.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Dm.summer.max = max(MASE_01.Dm{1,2}(dt_range.summer.lower:dt_range.summer.upper));

    % Mean Hs, Tp, Dp
    MASE_01_stats.Hs.summer.mean = mean(MASE_01.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Tp.summer.mean = mean(MASE_01.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Tm.summer.mean = mean(MASE_01.Tm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Dp.summer.mean = mean(MASE_01.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    MASE_01_stats.Dm.summer.mean = mean(MASE_01.Dm{1,2}(dt_range.summer.lower:dt_range.summer.upper));

%% BHI-E - Set Path

fdir = [user1 'capstone\wave_buoy_data\UNCW_BHI-E'];
files = dir(fullfile(fdir,'*.csv'));

%% BHI-E - Load Data

for i = 1:length(files)
    fname = files(i).name;
    fid = fopen(fullfile(fdir,fname));
    formatspec = "%s%f%s"; % Datetime, Parameter Value, Data Quality
    if fname == "Hs_22sept2021_21sept2022.csv"
        BHI_E.Hs = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % m
    elseif fname == "Tp_22sept2021_21sept2022.csv"
        BHI_E.Tp = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % s
        elseif fname == "Tm_22sept2021_21sept2022.csv"
        BHI_E.Tm = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % s
    elseif fname == "Dp_22sept2021_21sept2022.csv"
        BHI_E.Dp = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % deg N
    elseif fname == "Dm_22sept2021_21sept2022.csv"
        BHI_E.Dm = textscan(fid,formatspec,'headerlines',7,'delimiter',','); % deg N
    end
    fclose(fid);
end

%% BHI-E - Find Min, Max, & Mean Stats for each season

% Autumn 2021

dt_range.autumn.lower = find(contains(BHI_E.Hs{1,1},'2021-09-22 00:09')); % first day of season
dt_range.autumn.upper = find(contains(BHI_E.Hs{1,1},'2021-12-20 23:39')); % last day of season

    % Min Hs, Tp, Dp
    BHI_E_stats.Hs.autumn.min = min(BHI_E.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Tp.autumn.min = min(BHI_E.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Tm.autumn.min = min(BHI_E.Tm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Dp.autumn.min = min(BHI_E.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Dm.autumn.min = min(BHI_E.Dm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    
    % Max Hs, Tp, Dp
    BHI_E_stats.Hs.autumn.max = max(BHI_E.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Tp.autumn.max = max(BHI_E.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Tm.autumn.max = max(BHI_E.Tm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Dp.autumn.max = max(BHI_E.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Dm.autumn.max = max(BHI_E.Dm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));

    % Mean Hs, Tp, Dp
    BHI_E_stats.Hs.autumn.mean = mean(BHI_E.Hs{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Tp.autumn.mean = mean(BHI_E.Tp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Tm.autumn.mean = mean(BHI_E.Tm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Dp.autumn.mean = mean(BHI_E.Dp{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));
    BHI_E_stats.Dm.autumn.mean = mean(BHI_E.Dm{1,2}(dt_range.autumn.lower:dt_range.autumn.upper));

% Winter 2021-2022

dt_range.winter.lower = find(contains(BHI_E.Hs{1,1},'2021-12-21 00:09')); % first day of season
dt_range.winter.upper = find(contains(BHI_E.Hs{1,1},'2022-03-19 23:50')); % last day of season

    % Min Hs, Tp, Dp
    BHI_E_stats.Hs.winter.min = min(BHI_E.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Tp.winter.min = min(BHI_E.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Tm.winter.min = min(BHI_E.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Dp.winter.min = min(BHI_E.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Dm.winter.min = min(BHI_E.Dm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    
    % Max Hs, Tp, Dp
    BHI_E_stats.Hs.winter.max = max(BHI_E.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Tp.winter.max = max(BHI_E.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Tm.winter.max = max(BHI_E.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Dp.winter.max = max(BHI_E.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Dm.winter.max = max(BHI_E.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));

    % Mean Hs, Tp, Dp
    BHI_E_stats.Hs.winter.mean = mean(BHI_E.Hs{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Tp.winter.mean = mean(BHI_E.Tp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Tm.winter.mean = mean(BHI_E.Tm{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Dp.winter.mean = mean(BHI_E.Dp{1,2}(dt_range.winter.lower:dt_range.winter.upper));
    BHI_E_stats.Dm.winter.mean = mean(BHI_E.Dm{1,2}(dt_range.winter.lower:dt_range.winter.upper));

% Spring 2022

dt_range.spring.lower = find(contains(BHI_E.Hs{1,1},'2022-03-20 00:20')); % first day of season
dt_range.spring.upper = find(contains(BHI_E.Hs{1,1},'2022-06-20 23:48')); % last day of season

    % Min Hs, Tp, Dp
    BHI_E_stats.Hs.spring.min = min(BHI_E.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Tp.spring.min = min(BHI_E.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Tm.spring.min = min(BHI_E.Tm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Dp.spring.min = min(BHI_E.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Dm.spring.min = min(BHI_E.Dm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    
    % Max Hs, Tp, Dp
    BHI_E_stats.Hs.spring.max = max(BHI_E.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Tp.spring.max = max(BHI_E.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Tm.spring.max = max(BHI_E.Tm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Dp.spring.max = max(BHI_E.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Dm.spring.max = max(BHI_E.Dm{1,2}(dt_range.spring.lower:dt_range.spring.upper));

    % Mean Hs, Tp, Dp
    BHI_E_stats.Hs.spring.mean = mean(BHI_E.Hs{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Tp.spring.mean = mean(BHI_E.Tp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Tm.spring.mean = mean(BHI_E.Tm{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Dp.spring.mean = mean(BHI_E.Dp{1,2}(dt_range.spring.lower:dt_range.spring.upper));
    BHI_E_stats.Dm.spring.mean = mean(BHI_E.Dm{1,2}(dt_range.spring.lower:dt_range.spring.upper));

% Summer 2022

dt_range.summer.lower = find(contains(BHI_E.Hs{1,1},'2022-06-21 00:18')); % first day of season
dt_range.summer.upper = find(contains(BHI_E.Hs{1,1},'2022-09-21 23:48')); % last day of season

    % Min Hs, Tp, Dp
    BHI_E_stats.Hs.summer.min = min(BHI_E.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Tp.summer.min = min(BHI_E.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Tm.summer.min = min(BHI_E.Tm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Dp.summer.min = min(BHI_E.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Dm.summer.min = min(BHI_E.Dm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    
    % Max Hs, Tp, Dp
    BHI_E_stats.Hs.summer.max = max(BHI_E.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Tp.summer.max = max(BHI_E.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Tm.summer.max = max(BHI_E.Tm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Dp.summer.max = max(BHI_E.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Dm.summer.max = max(BHI_E.Dm{1,2}(dt_range.summer.lower:dt_range.summer.upper));

    % Mean Hs, Tp, Dp
    BHI_E_stats.Hs.summer.mean = mean(BHI_E.Hs{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Tp.summer.mean = mean(BHI_E.Tp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Tm.summer.mean = mean(BHI_E.Tm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Dp.summer.mean = mean(BHI_E.Dp{1,2}(dt_range.summer.lower:dt_range.summer.upper));
    BHI_E_stats.Dm.summer.mean = mean(BHI_E.Dm{1,2}(dt_range.summer.lower:dt_range.summer.upper));
