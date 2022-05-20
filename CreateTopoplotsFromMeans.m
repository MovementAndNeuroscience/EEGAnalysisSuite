function CreateTopoplotsFromMeans(FirstElectrodeCLuster, emptyPowerArray, firstMeanPowers, secondElectrodeCluster, secondMeanPower, FigureTitle)
       
for i=1:size(FirstElectrodeCLuster,2)
        emptyPowerArray(FirstElectrodeCLuster(1,i)) = firstMeanPowers; 
end
       
for i=1:size(secondElectrodeCluster,2)
        emptyPowerArray(secondElectrodeCluster(1,i)) = secondMeanPower; 
end
       
figure
       
topoplot(emptyPowerArray,'eeg64locs.loc','maplimits' ,[-1,1])
       
title(FigureTitle)
colorbar

end