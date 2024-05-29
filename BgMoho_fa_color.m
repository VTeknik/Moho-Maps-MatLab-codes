function  BgMoho_fa_color(moho,bg,fa)


hold on
grid on
box on


 s = scatter(bg,moho,25,'filled','MarkerEdgeColor',[0.09 0.09 0.09],'LineWidth',1);

% =============fa linear color for Moho===========================
for i= 1:length(moho)
   
     if (fa(i)<=-100)
    gcp(i, 1:3) =[0    0    0.8 ]; % dark blue
 % plots errorbar for each topo intervales
%  BgMoho_errbarplot(g,M,T,(T(i)<=-1.5),gcp(i, 1:3))
     end
    
     if (fa(i)>-100 & fa(i)<=-50)
    gcp(i, 1:3) = [0.5  0.5  1];%    'light blue';
%      BgMoho_errbarplot(g,M,T,(T(i)>-1.5 & T(i)<=-0.5),gcp(i, 1:3))
     end
     
      if (fa(i)>-50 & fa(i)<=0 )
    gcp(i, 1:3) = [0    0.5  0];%    {'dark green','forest green'};
%      BgMoho_errbarplot(g,M,T,(T(i)>-0.5 & T(i)<=0.5 ),gcp(i, 1:3))
      end
     
      
       if (fa(i)>0 & fa(i)<=50 )
    gcp(i, 1:3)= [1    1    0];%    yellow
%      BgMoho_errbarplot(g,M,T,(T(i)>0.5 & T(i)<=1.5 ),gcp(i, 1:3))
       end
     
        if (fa(i)>50 & fa(i)<=100 )
    gcp(i, 1:3) =[1    0.6    0];%    'orange';
%      BgMoho_errbarplot(g,M,T,(T(i)>1.5 & T(i)<=2.5 ),gcp(i, 1:3))
        end
         if (fa(i)>100 & fa(i)<=150 )
    gcp(i, 1:3) =[1    0    0];%    'orange';
%      BgMoho_errbarplot(g,M,T,(T(i)>1.5 & T(i)<=2.5 ),gcp(i, 1:3))
        end    
        
            if (fa(i)>=150)
    gcp(i, 1:3) = [1    0    1];%    'magenta';
%      BgMoho_errbarplot(g,M,T,(T(i)>=2.5),gcp(i, 1:3))
            end
     

end
% =============fa linear color for BGavity===========================









 %---------------linear coller with legend ---------------------------
ind1 = find (gcp(: , 1) == 0 & gcp(: , 2) == 0 & gcp(: , 3) == 0.8);% dark blue
s1 = scatter(bg(ind1),moho(ind1),50,gcp(ind1,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);

ind2 = find (gcp(: , 1) == 0.5 & gcp(: , 2) == 0.5 & gcp(: , 3) == 1);% 'light blue';
s2 = scatter(bg(ind2),moho(ind2),50,gcp(ind2,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind3 = find (gcp(: , 1) == 0.0 & gcp(: , 2) == 0.5 & gcp(: , 3) == 0);%    {'dark green','forest green'
s3 = scatter(bg(ind3),moho(ind3),50,gcp(ind3,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind4 = find (gcp(: , 1) == 1 & gcp(: , 2) == 1 & gcp(: , 3) == 0);% %  {'yellow'};
s4 = scatter(bg(ind4),moho(ind4),50,gcp(ind4,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);



ind5 = find (gcp(: , 1) == 1 & gcp(: , 2) == 0.6 & gcp(: , 3) ==0);% orange;
s5 = scatter(bg(ind5),moho(ind5),50,gcp(ind5,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind6 = find (gcp(: , 1) == 1 & gcp(: , 2) == 0 & gcp(: , 3) == 0);% red;
s6 = scatter(bg(ind6),moho(ind6),50,gcp(ind6,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind7 = find (gcp(: , 1) == 1 & gcp(: , 2) == 0 & gcp(: , 3) == 1);% magenta;
s7 = scatter(bg(ind7),moho(ind7),50,gcp(ind7,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


[h1,p1,delta1]= polyplot(bg,moho,2,1,'k','linewidth',6,'error','m--','linewidth',2);
% after the input variables(g,M here) the first number is the sigma value
% should be changed in the legend below and second number is the order of
% polynominal.

% --------------plot average of points
plot(mean(bg(ind1)), mean(moho(ind1)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind1(1),1:3));
text(mean(bg(ind1)), mean(moho(ind1)),...
    num2str(length(moho(ind1))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(bg(ind2)), mean(moho(ind2)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind2(1),1:3));
text(mean(bg(ind2)), mean(moho(ind2)),...
    num2str(length(moho(ind2))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(bg(ind3)), mean(moho(ind3)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind3(1),1:3));
text(mean(bg(ind3)), mean(moho(ind3)),...
    num2str(length(moho(ind3))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(bg(ind4)), mean(moho(ind4)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind4(1),1:3));
text(mean(bg(ind4)), mean(moho(ind4)),...
    num2str(length(moho(ind4))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(bg(ind5)), mean(moho(ind5)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind5(1),1:3));
text(mean(bg(ind5)), mean(moho(ind5)),...
    num2str(length(moho(ind5))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(bg(ind6)), mean(moho(ind6)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind6(1),1:3));
text(mean(bg(ind6)), mean(moho(ind6)),...
    num2str(length(moho(ind6))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(bg(ind7)), mean(moho(ind7)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind7(1),1:3));
text(mean(bg(ind7)), mean(moho(ind7)),...
    num2str(length(moho(ind7))), 'FontSize', 15,'BackgroundColor','none');
%------------------------------------------------------------


%=================================
% This fitting estimat the slobes
x=bg;y=moho;
c = polyfit(x,y,1);
% Display evaluated equation y = m*x + b
% disp(['Equation is y = ' num2str(c(1)) '*x + ' num2str(c(2))])
% % Evaluate fit equation using polyval
% y_est = polyval(c,x);
% % Add trend line to plot
% hold on
% plot(x,y_est,'r--','LineWidth',2)
%=================================

  theString = sprintf( 'M = %.3f BG + %.0f  ',c(1), c(2));
  text(min(bg),min(moho)+4,theString, 'FontSize', 15,'BackgroundColor','none');
% % p3 = scatter(To,Mo)
% 
% [h2,p2,delta2] = polyplot(Mo,go,1,1,'r','linewidth',4,'error','m:','linewidth',1);
% theString = sprintf('M = %.3f T + %.3f', p2(1), p2(2));
%  text(min(Mo),min(go)-5,theString, 'FontSize', 14,'BackgroundColor',[0.1 0.9 0.1]);


%--------------------- FA legend part of figure-------------
l1 = legend([s1(1),s2(1),s3(1),s4(1),s5(1),s6(1),s7(1),...
    h1(1,1),h1(1,2)],...
    {'<=-100 (mGal)','-100 to -50 (mGal)','-50 to 0 (mGal)', ...
   '0 to 50 (mGal)','50 to 100 (mGal)','100 to 150 (mGal)','> 150 (mGal)',...
   '1^{th} order fit','\pm2\sigma',...
    },'Location','northeast');
l1.FontSize = 30;                     % make the text larger
l1.FontWeight = 'bold';               % make the text bold
%------------------------------------------------------------

xlabel('Bougur Anomaly(mGal)','FontSize',12,'FontWeight','bold','Color','k')
ylabel('Moho (km)','FontSize',12,'FontWeight','bold','Color','k')
ax = gca;
ax.Color = 'white';
ax.FontSize = 30;                     % make the text larger
ax.FontWeight = 'bold';               % make the text bold
 xlim([min(bg)-4 max(bg)-35 ])
%   xlim([-2400 3300])
end