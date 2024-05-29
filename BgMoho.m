function  BgMoho(To,Tc,Mo,Mc,go,gc)

T = [To;Tc]; M = [Mo ;Mc]; g=[go ;gc];

hold on
grid on
box on


 s = scatter(g,M,25,'filled','MarkerEdgeColor',[0.09 0.09 0.09],'LineWidth',1);

% =============Topo linear color for Moho===========================
for i= 1:length(M)
   
     if (T(i)<=-1.5)
    gcp(i, 1:3) =[0    0    0.8 ]; % dark blue
 % plots errorbar for each topo intervales
%  BgMoho_errbarplot(g,M,T,(T(i)<=-1.5),gcp(i, 1:3))
     end
    
     if (T(i)>-1.5 & T(i)<=-0.5 )
    gcp(i, 1:3) = [0.5  0.5  1];%    'light blue';
%      BgMoho_errbarplot(g,M,T,(T(i)>-1.5 & T(i)<=-0.5),gcp(i, 1:3))
     end
     
      if (T(i)>-0.5 & T(i)<=0.5 )
    gcp(i, 1:3) = [0    0.5  0];%    {'dark green','forest green'};
%      BgMoho_errbarplot(g,M,T,(T(i)>-0.5 & T(i)<=0.5 ),gcp(i, 1:3))
      end
     
      
       if (T(i)>0.5 & T(i)<=1.5 )
    gcp(i, 1:3)= [1    1    0];%    yellow
%      BgMoho_errbarplot(g,M,T,(T(i)>0.5 & T(i)<=1.5 ),gcp(i, 1:3))
       end
     
        if (T(i)>1.5 & T(i)<=2.5 )
    gcp(i, 1:3) =[1    0.6    0];%    'orange';
%      BgMoho_errbarplot(g,M,T,(T(i)>1.5 & T(i)<=2.5 ),gcp(i, 1:3))
        end
     
        
            if (T(i)>=2.5)
    gcp(i, 1:3) = [1    0    0];%    'red';
%      BgMoho_errbarplot(g,M,T,(T(i)>=2.5),gcp(i, 1:3))
            end
     

end
% =============Topo linear color for BGavity===========================








 %---------------linear coller with legend ---------------------------
ind1 = find (gcp(: , 1) == 0 & gcp(: , 2) == 0 & gcp(: , 3) == 0.8);% dark blue
s1 = scatter(g(ind1),M(ind1),50,gcp(ind1,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);



ind2 = find (gcp(: , 1) == 0.5 & gcp(: , 2) == 0.5 & gcp(: , 3) == 1);% 'light blue';
s2 = scatter(g(ind2),M(ind2),50,gcp(ind2,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind3 = find (gcp(: , 1) == 0.0 & gcp(: , 2) == 0.5 & gcp(: , 3) == 0);%    {'dark green','forest green'
s3 = scatter(g(ind3),M(ind3),50,gcp(ind3,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind4 = find (gcp(: , 1) == 1 & gcp(: , 2) == 1 & gcp(: , 3) == 0);% %  {'yellow'};
s4 = scatter(g(ind4),M(ind4),50,gcp(ind4,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);



ind5 = find (gcp(: , 1) == 1 & gcp(: , 2) == 0.6 & gcp(: , 3) ==0);% orange;
s5 = scatter(g(ind5),M(ind5),50,gcp(ind5,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


ind6 = find (gcp(: , 1) == 1 & gcp(: , 2) == 0 & gcp(: , 3) == 0);% red;
s6 = scatter(g(ind6),M(ind6),50,gcp(ind6,1:3),'filled','MarkerEdgeColor','none','LineWidth',0.5);


[h1,p1,delta1]= polyplot(g,M,2,1,'k','linewidth',6,'error','m--','linewidth',2);
% after the input variables(g,M here) the first number is the sigma value
% should be changed in the legend below and second number is the order of
% polynominal.

% --------------plot average of points
plot(mean(g(ind1)), mean(M(ind1)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind1(1),1:3));
text(mean(g(ind1)), mean(M(ind1)),...
    num2str(length(M(ind1))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(g(ind2)), mean(M(ind2)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind2(1),1:3));
text(mean(g(ind2)), mean(M(ind2)),...
    num2str(length(M(ind2))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(g(ind3)), mean(M(ind3)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind3(1),1:3));
text(mean(g(ind3)), mean(M(ind3)),...
    num2str(length(M(ind3))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(g(ind4)), mean(M(ind4)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind4(1),1:3));
text(mean(g(ind4)), mean(M(ind4)),...
    num2str(length(M(ind4))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(g(ind5)), mean(M(ind5)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind5(1),1:3));
text(mean(g(ind5)), mean(M(ind5)),...
    num2str(length(M(ind5))), 'FontSize', 15,'BackgroundColor','none');

plot(mean(g(ind6))-6, mean(M(ind6)),...
       'p','MarkerSize',30,...
    'MarkerEdgeColor','k','MarkerFaceColor',gcp(ind6(1),1:3));
text(mean(g(ind6)), mean(M(ind6)),...
    num2str(length(M(ind6))), 'FontSize', 15,'BackgroundColor','none');
%------------------------------------------------------------


%=================================
% This fitting estimat the slobes
x=g;y=M;
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
  text(min(g),min(M)+4,theString, 'FontSize', 15,'BackgroundColor','none');
% % p3 = scatter(To,Mo)
% 
% [h2,p2,delta2] = polyplot(Mo,go,1,1,'r','linewidth',4,'error','m:','linewidth',1);
% theString = sprintf('M = %.3f T + %.3f', p2(1), p2(2));
%  text(min(Mo),min(go)-5,theString, 'FontSize', 14,'BackgroundColor',[0.1 0.9 0.1]);

% %--------------------- Topo legend part of figure-------------
% l1 = legend([s1(1),s2(1),s3(1),s4(1),s5(1),s6(1),...
%     h1(1,1),h1(1,2)],...
%     {'<=-1.5 km','-1.5 to -0.5 km','-0.5 to 0.5 km', ...
%    '0.5 to 1.5 km','1.5 to 2.5 km','> 2.5 km',...
%    '1^{th} order fit','\pm2\sigma',...
%     },'Location','northeast');
% l1.FontSize = 30;                     % make the text larger
% l1.FontWeight = 'bold';               % make the text bold
% %------------------------------------------------------------
%--------------------- FA legend part of figure-------------
l1 = legend([s1(1),s2(1),s3(1),s4(1),s5(1),s6(1),...
    h1(1,1),h1(1,2)],...
    {'<=-1.5 km','-1.5 to -0.5 km','-0.5 to 0.5 km', ...
   '0.5 to 1.5 km','1.5 to 2.5 km','> 2.5 km',...
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
 xlim([min([go ;gc])-4 max([go ;gc])-35 ])
%   xlim([-2400 3300])
end