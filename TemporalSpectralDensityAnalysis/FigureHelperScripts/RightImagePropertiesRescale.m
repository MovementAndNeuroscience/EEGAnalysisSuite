%add correct properties for imagesc created for ERSP RESCALE
%experiment. 

function RightImagePropertiesRescale(Title, gca, limit, type)

if(type == "avr")
    c = redblue(40);
    ax = gca; 
    
        ax.XTick = [0.1;11.11; 22 ;33.33; 46.29 ;59.25; 72.21; 85.17; 98.13 ;111.09; 124.05 ;137.01 ;149.97 ;162.93; 175.89; 188.88];
        ax.XTickLabel = {'-250','0','250','500','750','1000','1250','1500','1750','2000','2250','2500','2750','3000','3250','3500'};
        ax.XLabel.String = 'ms';
        ax.YTick = [0.3; 3.7; 7.4,; 11.11; 14.8; 18.5; 22.2; 25.9; 29.6; 33.3; 37; 40.7; 44.4; 48.1; 51.8; 55.5; 59.2; 62.9; 66.6; 70.3; 74; 77.7; 81.4];
        ax.YTickLabel = {'4','6','8','10','12','14','16','18','20','22','24','26','28','30','32','34','36','38','40','42','44','46','48'};
        ax.YLabel.String = 'Hz';
        ax.YDir = 'normal';
        title(Title); 
        colormap(c)
        colorbar; 
        clim(limit);
        
    lx = [11.11 11.11];
    ly = [0 82];
    hold on 
    line(lx,ly,'Color','magenta','LineStyle','--','linewidth',2.0)
    Title = strcat(Title, '.fig'); 
    saveas(gcf,Title)

    close all
end 
if(type == "std")
    ax = gca; 
    
        ax.XTick = [0.1;11.11; 22 ;33.33; 46.29 ;59.25; 72.21; 85.17; 98.13 ;111.09; 124.05 ;137.01 ;149.97 ;162.93; 175.89; 188.88];
        ax.XTickLabel = {'-250','0','250','500','750','1000','1250','1500','1750','2000','2250','2500','2750','3000','3250','3500'};
        ax.XLabel.String = 'ms';
        ax.YTick = [0.3; 3.7; 7.4,; 11.11; 14.8; 18.5; 22.2; 25.9; 29.6; 33.3; 37; 40.7; 44.4; 48.1; 51.8; 55.5; 59.2; 62.9; 66.6; 70.3; 74; 77.7; 81.4];
        ax.YTickLabel = {'4','6','8','10','12','14','16','18','20','22','24','26','28','30','32','34','36','38','40','42','44','46','48'};
        ax.YLabel.String = 'Hz';
        ax.YDir = 'normal';
        title(Title); 
        colormap("jet")
        colorbar; 
        clim(limit);
        
    lx = [11.11 11.11];
    ly = [0 82];
    hold on 
    line(lx,ly,'Color','magenta','LineStyle','--','linewidth',2.0)
    Title = strcat(Title, '.fig'); 
    saveas(gcf,Title)

    close all
end 

