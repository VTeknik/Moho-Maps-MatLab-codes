clear all
clc
close all

% -------------------load data------------------------------------------ 
load CeTe_V20220629.XYZ; % Import XYZ format Bouguer and topo data: 
datain = CeTe_V20220629; % Replace loaded data in "datain".
long = datain(:,1); % longitude of each point
lat = datain(:,2);% Latitude of each point
moho = datain(:,3); % moho
topo = datain(:,4); %  Topo
bg = datain(:,5); % Bouguer of XYZ format of loaded 
fa=datain(:,6);
% -------------------load data------------------------------------------ 


% -------------------------------------------------------------------------
ci = find (topo>=-200); % index for continetal type
Tc = topo(ci); long1 = long(ci);lat1 = lat(ci);
Mc = moho(ci);
gc = bg(ci);
oi = find (topo<-50); % index for oceanic type pf data
To = topo(oi);long2 = long(oi);lat2 = lat(oi);
Mo = moho(oi);
go = bg(oi);
%--------------------------------------------------------------------------

% ----------------------Remove NaN values----------------------------------
gc(isnan(Tc))=[]; gc(isnan(Mc))=[];
long1(isnan(Tc))=[]; lat1(isnan(Tc))=[];long1(isnan(Mc))=[]; lat1(isnan(Mc))=[];
long2(isnan(To))=[]; lat2(isnan(To))=[];long2(isnan(Mo))=[]; lat2(isnan(Mo))=[];
Tc(isnan(Tc)) = []; Mc(isnan(Tc)) = []; Tc(isnan(Mc)) = []; Mc(isnan(Mc)) = [];
To(isnan(To)) = []; Mo(isnan(Mo)) = [];
%--------------------------------------------------------------------------

Tc = Tc./1000; To = To./1000; % Convert topo from meter to km

% depth from MSL to Moho(M = M -T); crust thickening(Mo = Mo -To-mmoho)
Mc = Mc + Tc; Mo = Mo + To; 

%--------------------------Crustal thickening(M) Topo----------------------
fig1 = figure(1);
clf(fig1)
ax1 = axes('position',[0.1  0.1  0.82  0.82],'Visible','on');
set (fig1, 'Units', 'normalized', 'Position', [0.1  0.1  0.82  0.82]);
axis('square')
% meanmoho function estimates mean moho at elevation near to MSL and plots
% the region as a BGay shaded part
% due to formulation all 
[mmoho] = meanmoho(To*1000,Tc*1000,Mo*1000,Mc*1000);
[gcp,m1] =gcolorpalet(To*1000,Tc*1000,(Mo-To-(mmoho/1000))*1000,(Mc-Tc-(mmoho/1000))*1000,go,gc,fig1);% create 9 points
%Position the plot further to the left and down. Extend the plot to fill entire paper
set(gcf, 'PaperPosition', [0.6 0 20 18]); 
set(gcf, 'PaperSize', [20 18]); %Keep the same paper size
saveas(gcf, 'Moho_Topo', 'pdf') 
%--------------------------------------------------------------------------

%--------Bg-topo-----------------------------------------------------------
fig2 = figure(2);
clf(fig2)
ax1 = axes('position',[0.1  0.1  0.82  0.82],'Visible','on');
set (fig2, 'Units', 'normalized', 'Position', [0.05  0.05  0.82 0.82]);
axis('square')

[m2]=topogr(To*1000,Tc*1000,Mo,Mc,go,gc);% Plots gravity topo graph


set(gcf, 'PaperPosition', [0.6 0 20 18]); 
set(gcf, 'PaperSize', [20 18]); %Keep the same paper size
saveas(gcf, 'BG_Topo', 'pdf')
%--------------------------------------------------------------------------


%--------Bg-Moho------------------------------------------------------------
fig3 = figure(3);
clf(fig3)
ax1 = axes('position',[0.1  0.1  0.82  0.82],'Visible','on');
set (fig3, 'Units', 'normalized', 'Position', [0.05  0.05  0.82 0.82]);
axis('square')
% BgMoho(To,Tc,Mo,Mc,go,gc) % this makes the color to topography
BgMoho_fa_color(moho,bg,topo)% this makes the color to freeair
set(gcf, 'PaperPosition', [0.6 0 20 18]); 
set(gcf, 'PaperSize', [20 18]); %Keep the same paper size
P = polyfitn(bg,moho,1)
x0 = linspace (min(bg), max(bg), 100);
plot(x0,P.Coefficients(2) + (P.Coefficients(1)-10*P.ParameterStd(1))*x0,'k-')
plot(x0,P.Coefficients(2) + (P.Coefficients(1)+10*P.ParameterStd(1))*x0,'b-')


aa=(2*3.14*6.672*(10^-11)*10^5*10^3) % 10^3 to convert gr/cm3 to kg/m3;
mm= (P.Coefficients(1)+10*P.ParameterStd(1))
% mm= (P.Coefficients(1))
1/(aa*mm)

y=bg;x1=moho;
[y,k] = sort(y);
x1 = x1(k);
surface_area_model = fitlm(y,x1,'linear')

[p,s]=polyfit(y,x1,1);
% [Y,DELTA] = polyconf(p,X,S,alpha) gives 100(1-alpha)% confidence intervals. For example, alpha = 0.1 yields 90% intervals.
alpha1 = 0.2;
 [yfit,dy]=polyconf(p,y,s,'predopt','curve');
% [yfit,dy]=polyconf(p,y,s,'alpha',alpha1,'curve');
a= 100;
% h1= scatter(y,x1,a,'ob','LineWidth',1.2);
% dy = 5*dy
line(y,yfit,'color','b','LineWidth',2);
line(y,yfit-(5*dy),'color','g','linestyle',':','LineWidth',2);
line(y,yfit+(5*dy),'color','g','linestyle',':','LineWidth',2);

print(fig3,'-painters', '-dpdf',fullfile('D:\V\MEdata\Matlabcode','BG_Moho_fa_color')) 
%--------------------------------------------------------------------------

%--------Bg-Moho only -20<fa<20--------------------------------------
% fig4 = figure(4);
% clf(fig4)
% ax1 = axes('position',[0.1  0.1  0.82  0.82],'Visible','on');
% set (fig4, 'Units', 'normalized', 'Position', [0.05  0.05  0.82 0.82]);


% ind = find(fa>-500&fa<500);
%-----------------------------------------------------
%     s = scatter(bg(ind),moho(ind),45,[0.5 0.5 0.5],'filled','MarkerEdgeColor',[0.1 0.1 0.1],'LineWidth',1);
%     hold on
%     [h1,p1,delta1]= polyplot(bg(ind),moho(ind),2,1,'k','linewidth',6,'error','m--','linewidth',2);
%     xlabel('Bougur Anomaly(mGal)','FontSize',12,'FontWeight','bold','Color','k')
%     ylabel('Moho (km)','FontSize',12,'FontWeight','bold','Color','k')
%     ax = gca;
%     ax.Color = 'white';
%     ax.FontSize = 30;                     % make the text larger
%     ax.FontWeight = 'bold';               % make the text bold
%     xlim([min(bg)-4 max(bg)-35 ])
%     grid on
%     box on
%     axis('square')
%     
%     set(gcf, 'PaperPosition', [0.6 0 20 18]); 
%     set(gcf, 'PaperSize', [20 18]); %Keep the same paper size
%------------------------------------------------------
% print(fig3,'-painters', '-dpdf',fullfile('D:\V\MEdata\Matlabcode','BG_Moho_fa_lsthan minus2bg20')) 

%--------------------------------------------------------------------------


%--------------------------------------------------
% This function plots topo-Bg-Moho Graphs versus each other
% slopeplot
%--------------------------------------------------

%================Computing avarge crust and mantle density=================
%m1 and m2 dervied by manual fitting not the result of above functions
m1 = 6.0617; m2 =  0.069615; % coefficient for contintal crust
m1 = 4.0146; m2 =  0.047717; % coefficient for contintal oceanic
G = 6.67408*(10^(-11)); % gravitational constant SI
m2 =m2*(10^(-5)); % to convert mGal to SI multiply to *(10^(-5))
% For free correction also we need to convert mGal to SI multiply to 0.3086**(10^(-5))
Rho_avg_crust = (m2 - (0.3086*(10^(-5))) )/(2*m1*pi*G);
display([' Avg the density of crust = ' num2str(Rho_avg_crust)]) 
Rho_avg_UpMantle = ((Rho_avg_crust/m1) + Rho_avg_crust);
display([' Avg the density of upper mantle = ' num2str(Rho_avg_UpMantle)])
%==========================================================================
%--------------------------------------------------------------------
% % in this part we want to compare data for spesific region
% topomap(lat, long) % This function plots topo, country boundaries and moho points
% 
% [in] = vprofile(lat, long);

%  for i=1:1
%      figure(2)% wants to redraw maps and points that selected inside a interested region
%     [in] = selectp(lat, long); % This function plots selected moho poins for moho region
%    figure(1)
%     p3(i) = scatter(T(in),M(in),70, gcp(in,1:3),'o','filled','MarkerEdgeColor',[0 0 0],'LineWidth',1.5);
%      end
%----------------------------------------------------------- 
