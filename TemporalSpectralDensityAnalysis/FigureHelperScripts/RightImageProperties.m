%add correct properties for imagesc created for ERSP Art in hospital
%experiment. 

function RightImageProperties(Title, gca)

ax = gca; 

    ax.XTick = [0.0;8.6; 21.71 ;34.82; 47.85 ;60.88; 73.91; 86.94; 99.97 ;113; 126.03 ;139.06 ;152.09 ;165.12; 178.15; 191.25];
    ax.XTickLabel = {'-5','0','2.5','5','7.5','10','12.5','15','17.5','20','22.5','25','27.5','30','32.5','35'};
    ax.XLabel.String = 'Seconds';
    ax.YTick = [0;79;158;237;317;396;475;555;634;713;793];
    ax.YTickLabel = {'0','5','10','15','20','25','30','35','40','45','50'};
    ax.YLabel.String = 'Hz';
    ax.YDir = 'normal';
    title(Title); 
    colormap(jet)
    colorbar; 
    
lx = [8.6 8.6];
ly = [0 793.5];
hold on 
line(lx,ly,'Color','magenta','LineStyle','--','linewidth',2.0)
Title = strcat(Title, '.fig'); 
saveas(gcf,Title)