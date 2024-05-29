clear all
clc
close all

% This code computes the Moho depth based on correlation of the availble
% seismic moho values and Bouguer gravity anomaly.


%---------------------------load  Moho _BG data----------------------------
datain = load('CeTe_V20220629.XYZ');
long = datain(:,1); lat = datain(:,2); topo = datain(:,4);% topo in m 
bg = datain(:,5); % Bougure anomaly from 
moho = datain(:,3); % Moho in km from CeTe_V20210507.gdb
clear datain; % clears unused varibles to free memory
%--------------------------------------------------------------------------


%---------------------------load topo_bg_fa data---------------------------
datain = load('TopoGR_v20220517.XYZ');
long_t = datain(:,1); lat_t = datain(:,2); topo_t = datain(:,3);% topo in m 
fa_t = datain(:,4); % Moho in km from TopoGR_v20220517.gdb
bg_t = datain(:,5); % Bougure anomaly from 
clear datain; % clears unused varibles to free memory
%--------------------------------------------------------------------------


%*************************plot whol data***********************************
% Grid the whole topo data 
cs = 0.25;%The cell size for griding whole of data
[longmesh,latmesh] = meshgrid( round(min(long_t)): cs : round(max(long_t)), round(min(lat_t)):cs:round(max(lat_t)) );
topomesh = griddata(long_t,lat_t,topo_t,longmesh,latmesh);
      %....................................................................
      % this function [point_xy] = pointxy(long,lat,win_l,overlap) defines.
      %  cordinate of the window centers
      % length of the win size is in degree
      win_i = 1; % window size in degree
      win_overlap= 50;
      [E,N] = pointxy(long,lat,win_i,win_overlap);
   
      %....................................................................
fig1 = figure(1); 
  clf(fig1)
%   axes('position',[0.01  0.1  0.95  0.95],'Visible','off')
  set (fig1, 'Units', 'normalized', 'Position', [0.1,0.05,0.8,0.85]);
ax1 = axes('position',[0.01  0.5  0.45 0.45],'Visible','on');


      contourf(ax1,longmesh,latmesh,topomesh,10,'LineColor','none');   
         hold on
      plot(ax1,E,N,'+','MarkerSize',2)% plots the center of windows 
      plot(ax1,long,lat,'o','MarkerSize',2)% plots the center of windows 
%         plot(ax1,long_t,lat_t,'*','MarkerSize',2)% plots the center of windows 
      
         zlimits = [min(topo) max(topo)]; % designes a limit for topo legend 
         demcmap(zlimits);contourcbar; 
         axis square; xlim(ax1,[min(long_t) max(long_t)]);  ylim(ax1,[min(lat_t) max(lat_t)]);
         xlabel(ax1,'Long');ylabel(ax1,'Lat');title(ax1,'The study area');

% ---------show plotical boundaries ------
shp = shaperead('world_borders.shp');
%extract Easting/Northing or Lat/long
x1 = extractfield(shp,'X');
y1 = extractfield(shp,'Y');
x1=x1';
y1=y1';
%show ascci data in map
mapshow(ax1,x1,y1,'Color','black')
%----------------------------------------
%**************************************************************************


%**************************Search win********************************

moho_bg_out = [];
moho_bg_out_t = [];

bg_t_int= []; %Moho and Bouguer values whitin window
long_t_int=  []; lat_t_int=  [];

moho_bg_out_t= []; % Calculates resudual bg after fitting a line to bg_topo
for i = 1:length(E)
win =win_i;  
w=1;% Counter of while loop
controlarray = [];
long_in= [];  lat_in= [];
topo_in = []; bg_in= [];
moho_in= []; mohobg_in= [];
data_win_t=[];
data_win= [];
r11= [];

  while true
%iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii 
      if win > 7 % breakes search if the size of window be beager than 1o degree
        break
      end
%iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii     
%------------------------------------------------------  
    %    window point location for BG_Moho graph
xv = [E(i)-(win/2) E(i)+(win/2) E(i)+(win/2) E(i)-(win/2) E(i)-(win/2)];
yv = [N(i)-(win/2) N(i)-(win/2) N(i)+(win/2) N(i)+(win/2) N(i)-(win/2)];
%    window point location for BG_topo graph
 [in,on] = inpolygon(long,lat,xv,yv); % finds for moho_bg
%------------------------------------------------------ 
  
%iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
      if (isempty(long(in)))
          break
         end
          % go to next iteration if there is less than 5 value moho
      if (length(unique(long(in)))<5)
                win =win+0.5;
          continue
      end
%iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii

%-----------------------------------------------
r1= rectangle(ax1,'Position',[mean(mean(long(in)))-(win/2), mean(mean(lat(in)))-(win/2) win win]');
r2= rectangle(ax1,'Position',[mean(mean(long(in)))-(win/2), mean(mean(lat(in)))-(win/2) win win]');
r1.FaceColor = 'none'; r2.FaceColor = 'none';
r1.EdgeColor = 'y'; r2.EdgeColor = 'm';
r1.LineWidth = 0.3;  r2.LineWidth = 3; 
%----------------------------------------------

%==================================================================
ax2 = axes('position',[0.5  0.545  0.3 0.4],'Visible','on');
%---------------------Theilen estimator------------------------------------
% This function is a quick two-dimensional implementation of Theil-Sen
% regression. See https://en.wikipedia.org/wiki/Theil%E2%80%93Sen_estimator
[a, b] = TheilSen([bg(in) moho(in)]);
mohobg=polyval([a, b],bg(in));
p1 = plot(ax2,bg(in),moho(in),'rO');
hold on
p2 = plot(ax2,bg(in),mohobg,'b-','LineWidth',2);
res_moho = moho(in) - mohobg;
rmse = sqrt(mean((res_moho).^2));

         %--------------------Calculate R2------------------
         mdl = fitlm(moho(in),mohobg);
         R2 = mdl.Rsquared.Ordinary;
%          R2 = 1 - (sum((moho(in) - mohobg).^2)/sum( (moho(in) - mean(moho(in))).^2)); %R2 initial just one number
%          R2 =corr(moho(in),mohobg).^2;
         %---------------------------------------------------
        
eqtxt = ['Fitted: Moho = ' num2str(a) '*bg + ' num2str(b) ';RMS = ' num2str(rmse) ';R2 = ' num2str(R2)];
          l1 = legend(ax2,'data',eqtxt ,'location','southwest');
          % l2 = legend(plt1,theString ,'Location','northeast');
          l1.FontSize = 9;                     % make the text larger
          l1.FontWeight = 'bold';
xlabel(ax2,'Bouguer (mGal)','FontSize',12,'FontWeight','bold','Color','k')
ylabel(ax2,'Moho (km)','FontSize',12,'FontWeight','bold','Color','k')
%--------------------------------------------------------------------------
%=================================================================
                  
%iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
if(rmse>10|a>-0.03|a<-0.3|R2<0.4) % dont consider for this slope less than this value
    delete(r2)
     delete(r1)
    delete(ax2) 
    win =win+0.5;
    continue
end
%iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
long_in(w,1:length(long(in)))= long(in);  lat_in(w,1:length(lat(in)))= lat(in);
topo_in(w,1:length(topo(in))) = topo(in); bg_in(w,1:length(bg(in)))= bg(in); 
moho_in(w,1:length(moho(in)))= moho(in);mohobg_in(w,1:length(mohobg))= mohobg;

controlarray(w,1)=a; controlarray(w,2)=b;
controlarray(w,3)=rmse;controlarray(w,4)=win;
controlarray(w,5)=w;
controlarray(w,6)=R2;

%=================================================================
ax3 = axes('position',[0.5  0.055  0.3 0.4],'Visible','on');
plot(ax3,controlarray(:,1),controlarray(:,3),'r*');
hold on
xlabel(ax3,'slope of moho ','FontSize',12,'FontWeight','bold','Color','k')
ylabel(ax3,'rmse fitted of Moho Bouguer','FontSize',12,'FontWeight','bold','Color','k')

text(controlarray(:,1),controlarray(:,3),num2str(controlarray(:,5)),...
    'VerticalAlignment','top',...
    'HorizontalAlignment','left',...
    'FontSize',10,'BackgroundColor','none')% label each point with name of the region
%------------------------------------%
ax4 = axes('position',[0.075  0.055  0.3 0.4],'Visible','on');
plot(ax4,controlarray(:,4),controlarray(:,6),'r*');
hold on
xlabel(ax4,'Window size (degree) ','FontSize',12,'FontWeight','bold','Color','k')
ylabel(ax4,'R2','FontSize',12,'FontWeight','bold','Color','k')

text(controlarray(:,4),controlarray(:,6),num2str(controlarray(:,5)),...
    'VerticalAlignment','top',...
    'HorizontalAlignment','left',...
    'FontSize',10,'BackgroundColor','none')% label each point with name of the region
%================================================================== 

%sssssssssssssss Select best window ssssssssssssssssssssssssssssssssss
d_slope = (controlarray(:,1)+0.08) - min(controlarray(:,1)+0.08); % -0.08 is optimum value 
d_rms = controlarray(:,3)- min(controlarray(:,3));
d = sqrt(d_slope.^2 + d_rms.^2);
ind = find (d==min(d));
plot(ax3,controlarray(ind,1),controlarray(ind,3),'bo');
%sssssssssssssss Select best window ssssssssssssssssssssssssssssssssss

    %====================data for output==========
    ind = ind(1);
   %Remove where there is more than one point
     slope_ind = controlarray(ind,1);i_moho_ind = controlarray(ind,2);
     rms_ind = controlarray(ind,3); win_ind = controlarray(ind,4);
     w_ind = controlarray(ind,5);R2_ind=controlarray(ind,6);
                     %--------------------------
                     ind_zero = find(long_in==0);
                     long_in(ind_zero) = NaN; 
                     lat_in(ind_zero)= NaN;
                     topo_in(ind_zero)= NaN; 
                     bg_in(ind_zero)= NaN;
                     moho_in(ind_zero)= NaN;
                     mohobg_in(ind_zero)= NaN;
                     %--------------------------
     long_in_ind = long_in(ind,:);lat_in_ind = lat_in(ind,:); topo_in_ind = topo_in(ind,:);
     bg_in_ind = bg_in(ind,:); moho_in_ind = moho_in(ind,:);mohobg_in_ind = mohobg_in(ind,:);
                          %--------------------------
                     %remove NaNs
                     ind_NaN = isnan(long_in_ind );
                     long_in_ind (ind_NaN) = []; 
                     lat_in_ind (ind_NaN) = []; 
                     topo_in_ind (ind_NaN) = []; 
                     bg_in_ind (ind_NaN) = []; 
                     moho_in_ind (ind_NaN) = [];
                     mohobg_in_ind (ind_NaN) = []; 
                     %--------------------------
    %=============================================


    
    
w = w+1; %Counter of while loop when all condition is true and we have some results
win=win+0.5;
pause(0.05)
delete(r2)
delete(ax2)  
delete(ax3) 
delete(ax4)
r11=[r11,r1];
  end

delete(r11)  
               %-----------------------------------------------
                  if(isempty(controlarray)) 
                     continue% when the window is empty
                  end
                  %-----------------------------------------------
                
             
%**************************Search win********************************
            %-----------------------------------------------
            % plot the final selected window
             r3= rectangle(ax1,'Position',[mean(long_in_ind(:))-(win_ind/2),...
                 mean(lat_in_ind(:))-(win_ind/2) win_ind win_ind]');
             r3.FaceColor = 'none';
             r3.EdgeColor = 'r';
             r3.LineWidth = 0.5; 
            %----------------------------------------------  

%------output for avarge of estimated values within win--------------------
data_win=[mean(long_in_ind(:)), mean(lat_in_ind(:)), mean(topo_in_ind(:)), mean(bg_in_ind(:) ), mean(moho_in_ind(:)),...
              mean(mohobg_in_ind(:)), slope_ind, i_moho_ind,rms_ind,win_ind,R2_ind];
 moho_bg_out= [moho_bg_out; data_win]; % Calculates resudual bg after fitting a line to bg_topo
%--------------------------------------------------------------------------
% pause

%--------------------------------------------------------
win_t = win_ind;% Define window size for MohoBG Grid
xv_t = [E(i)-(win_t/2) E(i)+(win_t/2) E(i)+(win_t/2) E(i)-(win_t/2) E(i)-(win_t/2)];
yv_t = [N(i)-(win_t/2) N(i)-(win_t/2) N(i)+(win_t/2) N(i)+(win_t/2) N(i)-(win_t/2)];
[in_t,on_t] = inpolygon(long_t,lat_t,xv_t,yv_t); % finds for moho_bg
bg_t_int=bg_t(in_t); %Moho and Bouguer values whitin window
long_t_int= long_t(in_t); lat_t_int= lat_t(in_t);


MohoBG_t=polyval([slope_ind, i_moho_ind],bg_t_int);

data_win_t=[long_t_int,lat_t(in_t),MohoBG_t];
moho_bg_out_t= [moho_bg_out_t; data_win_t]; % Calculates resudual bg after fitting a line to bg_topo
%--------------------------------------------------------------------------

end


%==========================================================================
dlmwrite('mohobg_win_CT20220721.txt',moho_bg_out)
%==========================================================================
dlmwrite('mohobg_win_t_CT20220721.txt',moho_bg_out_t)
%==========================================================================
saveas(gcf,'Barchart.fig')
 print('-painters', '-dpdf',gcf) 