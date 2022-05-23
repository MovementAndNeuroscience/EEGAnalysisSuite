function CreateTopoplotsBasedOnTable(Table, Electrodes,FigureTitleGroup1,FigureTitleGroup2,FigureTitleDifference,FigLimGroup1,FigLimGroup2,FigLimDifference)

meanPowerPrEEGCluster = zeros(size(Electrodes,2),1); 
countingAdult = 1;
countingYoung = 1;

for i= 1:size(Table.SubjectGroupNr,1)
    if Table.SubjectGroupNr(i) == 1
       poweband_condition_adult(countingAdult,:) = Table.mean_PowerBand_Condition(i,:);

        countingAdult = countingAdult +1; 
    end
    if Table.SubjectGroupNr(i) == 2
       poweband_condition_Young(countingYoung,:) = Table.mean_PowerBand_Condition(i,:);
        countingYoung = countingYoung + 1; 
    end
end

for electrode = 1:size(meanPowerPrEEGCluster,1)

mean_PowerBand_Condition_adult(electrode,1) = mean(poweband_condition_adult(:,electrode));
mean_PowerBand_Condition_Young(electrode,1) = mean(poweband_condition_Young(:,electrode));

dif_adult_vs_young_Powerband_Condition(electrode,1) = mean_PowerBand_Condition_adult(electrode,1) - mean_PowerBand_Condition_Young(electrode,1); 
end

ConfigureShowTopoplot(mean_PowerBand_Condition_adult, FigLimGroup1, FigureTitleGroup1);

ConfigureShowTopoplot(mean_PowerBand_Condition_Young, FigLimGroup2, FigureTitleGroup2);

ConfigureShowTopoplot(dif_adult_vs_young_Powerband_Condition, FigLimDifference, FigureTitleDifference);

end