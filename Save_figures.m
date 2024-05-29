hFigs = findall(groot,'type','figure');
% 
% print(hFigs(1),'confusion matrix','-depsc');%For eps figure with name: ROC
 print(hFigs(1),'-painters', '-dpdf',fullfile('D:\V\MEdata\ML\MLfigures','Reg_predMohh vs FA')) 
 
 
 
 % =======================================
 % plot the deuffrences of real and MLmoho plotes
%---------------------------load  Moho _BG data----------------------------
datain = load('CT_RealandPerdiction.XYZ');% for Calasification result
% datain = load('CT_realAndRegrPrediction_v20220720.XYZ');% for regression result
long = datain(:,1); lat = datain(:,2); mohos = datain(:,3);% topo in m 
mohoml = datain(:,4); % Moho in km from CeTe_V20210507.gdb
clear datain; % clears unused varibles to free memory
%--------------------------------------------------------------------------
fig1 = figure(1); 
clf(fig1)
set (fig1, 'units','normalized','outerposition',[0.003 0.04 0.995 0.95]);
%  s = scatter(mohos,mohoml,30,'MarkerEdgeColor',[0.01 0.09 0.49],'LineWidth',1);
 scatter_kde(mohos,mohoml, 'filled', 'MarkerSize', 50);
 hold on
  ax = gca;
%  bar(mohos-mohoml);
 grid on
 box on
 xlabel('Seismic Moho(km)','FontSize',12,'FontWeight','bold','Color','k')
 ylabel('Predicted Moho(km)','FontSize',12,'FontWeight','bold','Color','k')
 axis('square'); ax.Color = 'white'; ax.FontSize = 30;ax.FontWeight = 'bold'; 

minmax= [min(mohos)-2 max([mohos])+2 ];
xlim(minmax)
ylim(minmax)
plot(minmax,minmax,'--')
    %--------------------------------------------------
        colormap('parula')
        cb = colorbar; 
        set(cb,'position',[.63 .125 0.015 .15])
        set(cb,'YTick',[0.002 0.004 0.006])
        set(cb,'YTickLabel',{'0.002','0.004','0.006'})
        cb.Title.String = ['Probability Density'];
        cb.FontSize = 20;                     % make the text larger
        cb.FontWeight = 'bold';               % make the text bold
     %--------------------------------------------------
%
set(fig1, 'PaperSize', [15 12]); %Keep the same paper size
print(fig1,'-painters', '-dpdf',fullfile('D:\V\MEdata\ML\MLfigures','Mohs vs MohoML_Class')) 
%===============================================




fig2 = figure(2); 
clf(fig2)
set (fig2, 'units','normalized','outerposition',[0.003 0.04 0.995 0.95]);
scatterhist(mohos,mohoml)
 grid on
 box on
 xlabel('Seismic Moho(km)','FontSize',12,'FontWeight','bold','Color','k')
 ylabel('Predicted Moho(km)','FontSize',12,'FontWeight','bold','Color','k')
 axis('square')
 ax.Color = 'white';
 ax.FontSize = 30;                     % make the text larger
ax.FontWeight = 'bold'; 
xlim([min(mohos)-2 max([mohos])+2 ])
ylim([min(mohos)-2 max([mohos])+2 ])

 print(fig2,'-painters', '-dpdf',fullfile('D:\V\MEdata\ML\MLfigures','Mohs vs MohoML with hist')) 
 
 
 
 
 
fig3 = figure(3); 
clf(fig3)
set (fig3, 'units','normalized','outerposition',[0.003 0.04 0.995 0.95]);
histogram(mohos-mohoml,30)
 grid on
 box on
 xlabel('Residual Moho (km)','FontSize',12,'FontWeight','bold','Color','k')
 ylabel('Fre','FontSize',12,'FontWeight','bold','Color','k')
 axis('square')
 ax.Color = 'white';
 ax.FontSize = 30;                     % make the text larger
ax.FontWeight = 'bold'; 
%  xlim([0 length(mohos)+2])
% ylim([min(mohos)-2 max([mohos])+2 ])
 print(fig3,'-painters', '-dpdf',fullfile('D:\V\MEdata\ML\MLfigures','Mohs vs MohoML with hist')) 
 
 % save residual for plot in the geosoft
  dataout= [long lat mohos-mohoml];
  dlmwrite('Res_MohosMohoml.txt',dataout)