function ConfigureShowTopoplot(mean_PowerBand_Condition_adult, Limitation, figureTitle)
figure
       
topoplot(mean_PowerBand_Condition_adult,'eeg64locs.loc','maplimits' ,Limitation)
       
title(figureTitle)
colorbar
figureSaveName = append(figureTitle,'.fig');
saveas(gcf,figureSaveName)

end