%creates maps of the stds, average and the tests and format everyone of
%them so they follow the same standard as the the maps created by the ERSP
%maps
function createTSEmaps (locations, avrConditionOne, avrConditionTwo, stdConditionOne, stdConditionTwo, stat)

y = 200; 
x = 793; 

for e = 1:size(EEG.chanlocs,2)
    electrodeInfo = locations(1,e);
    
    SetupTSEMapsProperties('Average Condition One  ',electrodeInfo, avrConditionOne, e, x, y);

    SetupTSEMapsProperties('Average Condition Two  ',electrodeInfo, avrConditionTwo, e, x, y);

    SetupTSEMapsProperties('Standard deviation Condition One  ',electrodeInfo, stdConditionOne, e, x, y);
    
    SetupTSEMapsProperties('Standard deviation Condition Two  ',electrodeInfo, stdConditionTwo, e, x, y);

    SetupTSEMapsProperties('Wilcoxon Ranked-sum test alpha=0.05  ',electrodeInfo, stat, e, x, y);
    
    statE = stat(e,:,:);
    for xPos = 1:x
        for yPos = 1:y 
          if statE(xPos,yPos) < 0.05
             statE(xPos,yPos) = 2.0;  
          end
        end
    end 
    title = 'Wilcoxon Ranked-sum test alpha=0.05 marked with value 2.0';
    title = strcat(title, ' - ');
    title = strcat(title,electrodeInfo.labels);
    figure 
    imagesc(statE)
    RightImageProperties(title , gca);
end 

function SetupTSEMapsProperties(description,electrodeInfo, erpsData, electrode, xdim, ydim)
title = description;
title = strcat(title, ' - ');
title = strcat(title,electrodeInfo.labels);

electrodeData = erpsData(electrode,:,:);
electrodeData = reshape(electrodeData, [xdim ydim]);
figure 
imagesc(electrodeData)
RightImageProperties(title, gca);
