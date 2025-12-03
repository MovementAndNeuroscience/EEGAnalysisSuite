function createTSEmapsOneCondition (EEG,locations, avrConditionOne, stdConditionOne, xDim, yDim, conditionOneName, avrlimit, stdlimit)

y = yDim; 
x = xDim; 
averagegraphname = strcat('Average ',  conditionOneName);
stdgraphName = strcat('Standard deviation ', conditionOneName);

for e = 1:size(EEG.chanlocs,2)
    electrodeInfo = locations(1,e);
    
    SetupTSEMapsProperties(averagegraphname,electrodeInfo, avrConditionOne, e, x, y, avrlimit, "avr");

    SetupTSEMapsProperties(stdgraphName,electrodeInfo, stdConditionOne, e, x, y, stdlimit, "std");
end 

function SetupTSEMapsProperties(description,electrodeInfo, erpsData, electrode, xdim, ydim, limit, type)
title = description;
title = strcat(title, ' - ');
title = strcat(title,electrodeInfo.labels);

electrodeData = erpsData(electrode,:,:);
electrodeData = reshape(electrodeData, [xdim, ydim]);
figure 
imagesc(electrodeData)
RightImagePropertiesRescale(title, gca, limit, type);

