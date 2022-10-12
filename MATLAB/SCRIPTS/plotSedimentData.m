%% EGN 495 - Engineering Capstone
% JANT Engineering
% Sand Sieve Analysis
% October 3, 2022
clear; clc
%% T01
T01.dune.num = [10,18,35,60,120,230];
T01.dune.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T01.dune.pmp = [99.97208437,98.79652605,63.0117866,5.477667494,0.108560794,0.006203474]; %percent mass passed

T01.berm.num = [10,18,35,60,120,230];
T01.berm.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T01.berm.pmp = [99.98884634,99.48321374,84.58564152,59.18503922,22.5935978,2.539316652]; %percent mass passed

T01.water.num = [10,18,35,60,120,230];
T01.water.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T01.water.pmp = [99.94713656,97.57885463,36.94096916,3.034361233,0.757709251,0.028193833]; %percent mass passed

figure; hold on;
plot(T01.dune.size,T01.dune.pmp,'linewidth',1.5)
plot(T01.berm.size,T01.berm.pmp,'linewidth',1.5)
plot(T01.water.size,T01.water.pmp,'linewidth',1.5)
xline(2,'-','10','LabelHorizontalAlignment','left','LabelOrientation','horizontal');...
xline(1,'-','18','LabelOrientation','horizontal');xline(0.71,'-','25','LabelOrientation','horizontal');...
xline(0.355,'-','45','LabelOrientation','horizontal');xline(0.25,'-','60','LabelOrientation','horizontal');...
xline(0.18,'-','80','LabelOrientation','horizontal');xline(0.125,'-','120','LabelOrientation','horizontal');...
xline(0.063,'-','230','LabelOrientation','horizontal');
set(gca,'xscale','log');
set(gcf,'position',[130.6,122.6,1332.8,645.6]);
grid on;
xlabel('Grain Size [mm]','fontsize',16)
ylabel('Cumulative Percent Passing [%]','fontsize',16)
title('Grain Size Distribution - T01','fontsize',18)
legend('Dune','Berm','Water Line','location','SE')

%% T03
T03.dune.num = [10,18,35,60,120,230];
T03.dune.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T03.dune.pmp = [99.98929336,99.46199143,47.61777302,0.634368308,0.053533191,0]; %percent mass passed

T03.berm.num = [10,18,35,60,120,230];
T03.berm.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T03.berm.pmp = [99.99069652,98.1858215,57.79631582,1.575389196,0.065124357,0.031011598]; %percent mass passed

T03.water.num = [10,18,35,60,120,230];
T03.water.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T03.water.pmp = [99.9857636,99.3771577,64.89304908,6.950920027,0.462682849,0.010677297]; %percent mass passed

figure; hold on;
plot(T03.dune.size,T03.dune.pmp,'linewidth',1.5)
plot(T03.berm.size,T03.berm.pmp,'linewidth',1.5)
plot(T03.water.size,T03.water.pmp,'linewidth',1.5)
xline(2,'-','10','LabelHorizontalAlignment','left','LabelOrientation','horizontal');...
xline(1,'-','18','LabelOrientation','horizontal');xline(0.71,'-','25','LabelOrientation','horizontal');...
xline(0.355,'-','45','LabelOrientation','horizontal');xline(0.25,'-','60','LabelOrientation','horizontal');...
xline(0.18,'-','80','LabelOrientation','horizontal');xline(0.125,'-','120','LabelOrientation','horizontal');...
xline(0.063,'-','230','LabelOrientation','horizontal');
set(gca,'xscale','log');
set(gcf,'position',[130.6,122.6,1332.8,645.6]);
grid on;
xlabel('Grain Size [mm]','fontsize',16)
ylabel('Cumulative Percent Passing [%]','fontsize',16)
title('Grain Size Distribution - T03','fontsize',18)
legend('Dune','Berm','Water Line','location','SE')

%% T05
T05.dune.num = [10,18,35,60,120,230];
T05.dune.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T05.dune.pmp = [99.98680158,99.38847338,67.42630884,4.88341399,0.017597888,0]; %percent mass passed

T05.berm.num = [10,18,35,60,120,230];
T05.berm.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T05.berm.pmp = [99.60923898,98.89348861,69.7798584,18.29999613,2.94811777,1.222579023]; %percent mass passed

T05.water.num = [10,18,35,60,120,230];
T05.water.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T05.water.pmp = [99.98903108,99.40036563,55.36380256,14.29981718,4.252285192,1.389396709]; %percent mass passed

figure; hold on;
plot(T05.dune.size,T05.dune.pmp,'linewidth',1.5)
plot(T05.berm.size,T05.berm.pmp,'linewidth',1.5)
plot(T05.water.size,T05.water.pmp,'linewidth',1.5)
xline(2,'-','10','LabelHorizontalAlignment','left','LabelOrientation','horizontal');...
xline(1,'-','18','LabelOrientation','horizontal');xline(0.71,'-','25','LabelOrientation','horizontal');...
xline(0.355,'-','45','LabelOrientation','horizontal');xline(0.25,'-','60','LabelOrientation','horizontal');...
xline(0.18,'-','80','LabelOrientation','horizontal');xline(0.125,'-','120','LabelOrientation','horizontal');...
xline(0.063,'-','230','LabelOrientation','horizontal');
set(gca,'xscale','log');
set(gcf,'position',[130.6,122.6,1332.8,645.6]);
grid on;
xlabel('Grain Size [mm]','fontsize',16)
ylabel('Cumulative Percent Passing [%]','fontsize',16)
title('Grain Size Distribution - T05','fontsize',18)
legend('Dune','Berm','Water Line','location','SE')

%% T06
T06.dune.num = [10,18,35,60,120,230];
T06.dune.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T06.dune.pmp = [99.98980182,99.78923752,79.37587109,12.12224224,0.523506816,0.016996975]; %percent mass passed

T06.berm.num = [10,18,35,60,120,230];
T06.berm.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T06.berm.pmp = [99.98649379,99.79470556,87.67693139,18.68719611,0.259319287,0.040518639]; %percent mass passed

T06.water.num = [10,18,35,60,120,230];
T06.water.size = [2,1,0.5,0.25,0.125,0.063]; %sieve sizes in mm
T06.water.pmp = [99.99675777,99.17971663,3.660474014,2.515967967,0.295042635,0.058360082]; %percent mass passed

figure; hold on;
plot(T06.dune.size,T06.dune.pmp,'linewidth',1.5)
plot(T06.berm.size,T06.berm.pmp,'linewidth',1.5)
plot(T06.water.size,T06.water.pmp,'linewidth',1.5)
xline(2,'-','10','LabelHorizontalAlignment','left','LabelOrientation','horizontal');...
xline(1,'-','18','LabelOrientation','horizontal');xline(0.71,'-','25','LabelOrientation','horizontal');...
xline(0.355,'-','45','LabelOrientation','horizontal');xline(0.25,'-','60','LabelOrientation','horizontal');...
xline(0.18,'-','80','LabelOrientation','horizontal');xline(0.125,'-','120','LabelOrientation','horizontal');...
xline(0.063,'-','230','LabelOrientation','horizontal');
set(gca,'xscale','log');
set(gcf,'position',[130.6,122.6,1332.8,645.6]);
grid on;
xlabel('Grain Size [mm]','fontsize',16)
ylabel('Cumulative Percent Passing [%]','fontsize',16)
title('Grain Size Distribution - T06','fontsize',18)
legend('Dune','Berm','Water Line','location','SE')