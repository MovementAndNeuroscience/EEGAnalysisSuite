function CreateTopoplotsBasedOnTables(Table,Table2, Electrodes,FigureTitleDifference1, FigureTitleDifference2, FigLimDifference1, FigLimDifference2)

meanPowerPrEEGCluster = zeros(size(Electrodes,2),1); 
countingAdult = 1;
countingYoung = 1;

for i= 1:size(Table.SubjectGroupNr,1)
    if Table.SubjectGroupNr(i) == 1
       powerband_condition_adult(countingAdult,:) = Table.mean_PowerBand_Condition(i,:);
       powerband_2Condtion_adult(countingAdult,:) = Table2.mean_PowerBand_Condition(i,:);

        countingAdult = countingAdult +1; 
    end
    if Table.SubjectGroupNr(i) == 2
       powerband_condition_Young(countingYoung,:) = Table.mean_PowerBand_Condition(i,:);
       powerband_2Condition_Young(countingYoung,:) = Table2.mean_PowerBand_Condition(i,:);
        countingYoung = countingYoung + 1; 
    end
end

for electrode = 1:size(meanPowerPrEEGCluster,1)

mean_PowerBand_Condition_Adult(electrode,1) = mean(powerband_condition_adult(:,electrode));
mean_PowerBand_Condition_Young(electrode,1) = mean(powerband_condition_Young(:,electrode));
mean_PowerBand_2Condition_Adult(electrode,1) = mean(powerband_2Condtion_adult(:,electrode));
mean_PowerBand_2Condition_Young(electrode,1) = mean(powerband_2Condition_Young(:,electrode));

dif_con1_vs_con2_Young_Powerband(electrode,1) = mean_PowerBand_Condition_Young(electrode,1) - mean_PowerBand_2Condition_Young(electrode,1);
dif_con1_vs_con2_Adult_Powerband(electrode,1) = mean_PowerBand_Condition_Adult(electrode,1) - mean_PowerBand_2Condition_Adult(electrode,1);
end

ConfigureShowTopoplot(dif_con1_vs_con2_Young_Powerband, FigLimDifference1, FigureTitleDifference1);
ConfigureShowTopoplot(dif_con1_vs_con2_Adult_Powerband, FigLimDifference2, FigureTitleDifference2);

end