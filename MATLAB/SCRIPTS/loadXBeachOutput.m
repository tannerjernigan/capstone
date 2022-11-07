%% EGN 495 - Load and Plot XBeach Output
% Carolina Beach, NC
% No Action - with 50-year SLR
%
% Ashley Holsclaw
% November 6, 2022
%%
clear; clc;
%% Load XBeach Output from NetCDF File
% x = ncread('xboutput.nc','globalx');
% y = ncread('xboutput.nc','globaly');
zb = ncread('xboutput.nc','zb');
% zs = ncread('xboutput.nc','zs');
% H = ncread('xboutput.nc','H');
% % H_mean = ncread('xboutput.nc','H_mean');
% t = ncread('xboutput.nc','globaltime');
%% Load XBeach Output
G = wlgrid('read','grid_D3D.grd');
% z = wldep('read','bed.dep',G);
% z = z(1:end-1, 1:end-1);

fdir = 'D:\CLASSES_2021_2022\Fall_2022\EGN_495\XBeach';
fn = 'xboutput.nc';

x = ncread(fn,'globalx');
y = ncread(fn,'globaly');
t = ncread(fn,'globaltime');

% ctheta = ncread(fn,'ctheta');
% thet = ncread(fn,'thet');
% thetamean = ncread(fn,'thetamean');

zb = ncread(fn,'zb');
% zb_mean = ncread(fn,'zb_mean');
zs = ncread(fn,'zs');
H = ncread(fn,'H');
% Hmean = ncread(fn,'H_mean');
% dzbdt = ncread(fn,'dzbdt');
% Subg = ncread(fn,'Subg');
% Susg = ncread(fn,'Susg');
% Sutot = Subg + Susg;
% Svbg = ncread(fn,'Svbg');
% Svsg = ncread(fn,'Svsg');
% Svtot = Svbg + Svsg;
sedero = ncread(fn,'sedero');
u = ncread(fn,'u');
v = ncread(fn,'v');
D = ncread(fn,'D');
E = ncread(fn,'E');
hh = ncread(fn,'hh');
iwl = ncread(fn,'iwl');
vmag = ncread(fn,'vmag');

% UTM to Cross-shore Distance
% USACE Baseline = 0 m
X = -flipud(x(:,round(size(y,2))) - x(1,round(size(y,2))));
Y = -flipud(y(round(size(y,1)),:) - y(round(size(y,1)),1));
%% 2D Bathymetric Map
figure;
for i = 1:size(zb,3)
    h = pcolor(x,y,zb(:,:,i));
    colormap(parula)
    shading interp
    set(h,'edgecolor','none')
    clim([-5 1])
    c = colorbar;
    c.Label.String = 'Elevation [m]';
    xlabel('Easting [UTM]')
    ylabel('Northing [UTM]')
    title_text = sprintf('Bathymetry at time = %5.2f s', (i-1)*60);
    title(title_text)
    
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
end
%% 2D Wave Height Map
figure;
for i = 1:size(zb,3)
    h = pcolor(x,y,H(:,:,i));
    colormap(parula)
    shading interp
    set(h,'edgecolor','none')
    clim([0 4])
    c = colorbar;
    c.Label.String = 'Wave Height [m]';
    title('Significant Wave Height')
    xlabel('Easting [UTM]')
    ylabel('Northing [UTM]')
    title_text = sprintf('Wave Height at time = %5.2f s', (i-1)*60);
    title(title_text)
    
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
end
%% cross-shore transect of water level through center of domain
figure;
for i = 1:15:size(zs,3)
    plot(X(:,round(size(X,2)/2)),zs(:,round(size(zs,2)/2),i))
    xlim([X(end,round(size(X,2)/2)) X(1,round(size(X,2)/2))])
    xlabel('Cross-shore Distance [m]')
    ylabel('water level [m]')
    grid on
    hold on
    if i == size(zs,3)
        legend('0 s','900 s','1800 s','2700 s','3600 s')
    end

%     title_text = sprintf('Wave Height at time = %5.2f s', (i-1)*60/4);
%     title(title_text)
    
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
end
%% 2D Sedimentation/Erosion Map
% Assuming sedimentation > 0 and erosion < 0
figure;
for i = 1:size(zb,3)
    h = pcolor(x,y,sedero(:,:,i));
    colormap(parula)
    shading interp
    set(h,'edgecolor','none')
    clim([-0.8877 0.3225])
    c = colorbar;
    c.Label.String = 'Sedimentation/Erosion [m]';
    xlabel('Easting [UTM]')
    ylabel('Northing [UTM]')
    title_text = sprintf('Sedimentation/Erosion at time = %5.2f s', (i-1)*60);
    title(title_text)
    
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
end
%% 2D Velocity Map
figure;
for i = 1:size(zb,3)
    h = pcolor(x,y,vmag(:,:,i));
    colormap(parula)
    shading interp
    set(h,'edgecolor','none')
    clim([0 3.217])
    c = colorbar;
    c.Label.String = 'Velocity [m/s]';
    xlabel('Easting [UTM]')
    ylabel('Northing [UTM]')
    title_text = sprintf('Velocity at time = %5.2f s', (i-1)*60);
    title(title_text)
    
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
end