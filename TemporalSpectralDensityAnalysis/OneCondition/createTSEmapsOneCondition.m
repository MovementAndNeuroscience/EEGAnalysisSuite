function createTSEmapsOneCondition (locations, avrConditionOne, stdConditionOne)

y = 200; 
x = 793; 

for e = 1:size(EEG.chanlocs,2)
    electrodeInfo = locations(1,e);
    
    SetupTSEMapsProperties('Average Condition One  ',electrodeInfo, avrConditionOne, e, x, y);

    SetupTSEMapsProperties('Standard deviation Condition One  ',electrodeInfo, stdConditionOne, e, x, y);
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

