function fontsize(varargin)
%FONTSIZE change the font size of all axes objects and their labels
%
%   FONTSIZE changes the font size of all axes objects and their 
%   labels in the current figure to 14 point [default]
%
%   FONTSIZE(SIZE) changes the font size of all axes objects and their 
%   labels in the current figure to the size defined by SIZE (points)
%
%   FONTSIZE(SIZE, hfig) changes the font size of all axes objects and 
%   their labels in the figure with the handle, hfig, to the size defined
%   by SIZE (points)
%
%NOTE: in releases of MATLAB prior to R2014b, axes objects include:
%      (1) axes, (2) subplots and (3) colorbars
%
%--
%Author:       Ryan S. Mieras
%Last Updated: January 5, 2018
%Contact:      ryanmieras@gmail.com
%


% Parse input(s)
if isempty(varargin)
    hfig = gcf;
    fontsize = 14;
elseif nargin == 1
    hfig = gcf;
    fontsize = varargin{1};
elseif nargin == 2
    hfig = varargin{2};
    if isnumeric(varargin{1}) == 1
        fontsize = varargin{1};
    else
        error('SIZE must be numeric.')
    end
else
    error('Too many input arguments.')
end


ver = version;  % matlab version
fig_ch = get(hfig,'Children');  % get figure's children


% Check which release of MATLAB is being used...
old_ver = 0;
if str2double(ver(end-5:end-2)) < 2015
    old_ver = 1;
    
  % But now check if a or b
    if strcmp('R2014b',ver(end-6:end-1));  % it's b, so NOT old actually
        old_ver = 0;
    end
end


if old_ver % version pre-dates R2014b release
    
    for i=1:length(fig_ch)
        
        if strcmp(get(fig_ch(i),'Type'),'Axes') || strcmp(get(fig_ch(i),'Type'),'axes')  % this handle corresponds to an axes object!
            set(fig_ch(i),'FontSize',fontsize);
            
            set(get(fig_ch(i),'XLabel'),'FontSize',fontsize);
            set(get(fig_ch(i),'YLabel'),'FontSize',fontsize);
            set(get(fig_ch(i),'ZLabel'),'FontSize',fontsize);
            set(get(fig_ch(i),'Title'),'FontSize',fontsize);
        end

    end
    
else
    
    for i=1:length(fig_ch)
        
        if strcmp(get(fig_ch(i),'Type'),'Axes') || strcmp(get(fig_ch(i),'Type'),'axes')  % this handle corresponds to an axes object!
            set(fig_ch(i),'FontSize',fontsize);
        end
        
    end
    
end
