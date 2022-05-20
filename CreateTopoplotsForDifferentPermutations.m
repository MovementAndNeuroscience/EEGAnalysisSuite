function CreateTopoplotsForDifferentPermutations(resultingTable, frontalElectrodes, motorBihemisphericElectrodes, leftMotorElectrodes, rightMotorElectrodes)

meanPowerPrEEGCluster = zeros(64,1); 
countingAdult = 1;
countingYoung = 1;
for i= 1:size(resultingTable.SubjectGroupNr,1)
    if resultingTable.SubjectGroupNr(i) == 1
       alpha_front_sym_adult(countingAdult) = resultingTable.mean_Alpha_Frontal_Symmetry(i);
       alpha_front_asum_adult(countingAdult) = resultingTable.mean_Alpha_Frontal_Asymmetry(i);
       alpha_front_unim_adult(countingAdult) = resultingTable.mean_Alpha_Frontal_Unimanual(i);
       
       alpha_biHem_sym_adult(countingAdult) = resultingTable.mean_Alpha_MotorBiHemispheric_Symmetry(i);
       alpha_biHem_asym_adult(countingAdult) = resultingTable.mean_Alpha_MotorBiHemispheric_Asymmetry(i);
       alpha_biHem_unim_adult(countingAdult) = resultingTable.mean_Alpha_MotorBiHemispheric_Unimanual(i);

       alpha_leftm_sym_adult(countingAdult) = resultingTable.mean_Alpha_LeftMotor_Symmetry(i);
       alpha_leftm_asym_adult(countingAdult) = resultingTable.mean_Alpha_LeftMotor_Asymmetry(i);
       alpha_leftm_unim_adult(countingAdult) = resultingTable.mean_Alpha_LeftMotor_Unimanual(i);

       alpha_rightm_sym_adult(countingAdult) = resultingTable.mean_Alpha_RightMotor_Symmetry(i);
       alpha_rightm_asym_adult(countingAdult) = resultingTable.mean_Alpha_RightMotor_Asymmetry(i);
       alpha_rightm_unim_adult(countingAdult) = resultingTable.mean_Alpha_RightMotor_Unimanual(i);

       LowBeta_front_sym_adult(countingAdult) = resultingTable.mean_LowBeta_Frontal_Symmetry(i);
       LowBeta_front_asum_adult(countingAdult) = resultingTable.mean_LowBeta_Frontal_Asymmetry(i);
       LowBeta_front_unim_adult(countingAdult) = resultingTable.mean_LowBeta_Frontal_Unimanual(i);
       
       LowBeta_biHem_sym_adult(countingAdult) = resultingTable.mean_LowBeta_MotorBiHemispheric_Symmetry(i);
       LowBeta_biHem_asym_adult(countingAdult) = resultingTable.mean_LowBeta_MotorBiHemispheric_Asymmetry(i);
       LowBeta_biHem_unim_adult(countingAdult) = resultingTable.mean_LowBeta_MotorBiHemispheric_Unimanual(i);

       LowBeta_leftm_sym_adult(countingAdult) = resultingTable.mean_LowBeta_LeftMotor_Symmetry(i);
       LowBeta_leftm_asym_adult(countingAdult) = resultingTable.mean_LowBeta_LeftMotor_Asymmetry(i);
       LowBeta_leftm_unim_adult(countingAdult) = resultingTable.mean_LowBeta_LeftMotor_Unimanual(i);

       LowBeta_rightm_sym_adult(countingAdult) = resultingTable.mean_LowBeta_RightMotor_Symmetry(i);
       LowBeta_rightm_asym_adult(countingAdult) = resultingTable.mean_LowBeta_RightMotor_Asymmetry(i);
       LowBeta_rightm_unim_adult(countingAdult) = resultingTable.mean_LowBeta_RightMotor_Unimanual(i);

       HighBeta_front_sym_adult(countingAdult) = resultingTable.mean_HighBeta_Frontal_Symmetry(i);
       HighBeta_front_asum_adult(countingAdult) = resultingTable.mean_HighBeta_Frontal_Asymmetry(i);
       HighBeta_front_unim_adult(countingAdult) = resultingTable.mean_HighBeta_Frontal_Unimanual(i);
       
       HighBeta_biHem_sym_adult(countingAdult) = resultingTable.mean_HighBeta_MotorBiHemispheric_Symmetry(i);
       HighBeta_biHem_asym_adult(countingAdult) = resultingTable.mean_HighBeta_MotorBiHemispheric_Asymmetry(i);
       HighBeta_biHem_unim_adult(countingAdult) = resultingTable.mean_HighBeta_MotorBiHemispheric_Unimanual(i);

       HighBeta_leftm_sym_adult(countingAdult) = resultingTable.mean_HighBeta_LeftMotor_Symmetry(i);
       HighBeta_leftm_asym_adult(countingAdult) = resultingTable.mean_HighBeta_LeftMotor_Asymmetry(i);
       HighBeta_leftm_unim_adult(countingAdult) = resultingTable.mean_HighBeta_LeftMotor_Unimanual(i);

       HighBeta_rightm_sym_adult(countingAdult) = resultingTable.mean_HighBeta_RightMotor_Symmetry(i);
       HighBeta_rightm_asym_adult(countingAdult) = resultingTable.mean_HighBeta_RightMotor_Asymmetry(i);
       HighBeta_rightm_unim_adult(countingAdult) = resultingTable.mean_HighBeta_RightMotor_Unimanual(i);

       Beta_front_sym_adult(countingAdult) = resultingTable.mean_Beta_Frontal_Symmetry(i);
       Beta_front_asum_adult(countingAdult) = resultingTable.mean_Beta_Frontal_Asymmetry(i);
       Beta_front_unim_adult(countingAdult) = resultingTable.mean_Beta_Frontal_Unimanual(i);
       
       Beta_biHem_sym_adult(countingAdult) = resultingTable.mean_Beta_MotorBiHemispheric_Symmetry(i);
       Beta_biHem_asym_adult(countingAdult) = resultingTable.mean_Beta_MotorBiHemispheric_Asymmetry(i);
       Beta_biHem_unim_adult(countingAdult) = resultingTable.mean_Beta_MotorBiHemispheric_Unimanual(i);

       Beta_leftm_sym_adult(countingAdult) = resultingTable.mean_Beta_LeftMotor_Symmetry(i);
       Beta_leftm_asym_adult(countingAdult) = resultingTable.mean_Beta_LeftMotor_Asymmetry(i);
       Beta_leftm_unim_adult(countingAdult) = resultingTable.mean_Beta_LeftMotor_Unimanual(i);

       Beta_rightm_sym_adult(countingAdult) = resultingTable.mean_Beta_RightMotor_Symmetry(i);
       Beta_rightm_asym_adult(countingAdult) = resultingTable.mean_Beta_RightMotor_Asymmetry(i);
       Beta_rightm_unim_adult(countingAdult) = resultingTable.mean_Beta_RightMotor_Unimanual(i);

        countingAdult = countingAdult +1; 
    end
    if resultingTable.SubjectGroupNr(i) == 2
       alpha_front_sym_Young(countingYoung) = resultingTable.mean_Alpha_Frontal_Symmetry(i);
       alpha_front_asum_Young(countingYoung) = resultingTable.mean_Alpha_Frontal_Asymmetry(i);
       alpha_front_unim_Young(countingYoung) = resultingTable.mean_Alpha_Frontal_Unimanual(i);
       
       alpha_biHem_sym_Young(countingYoung) = resultingTable.mean_Alpha_MotorBiHemispheric_Symmetry(i);
       alpha_biHem_asym_Young(countingYoung) = resultingTable.mean_Alpha_MotorBiHemispheric_Asymmetry(i);
       alpha_biHem_unim_Young(countingYoung) = resultingTable.mean_Alpha_MotorBiHemispheric_Unimanual(i);

       alpha_leftm_sym_Young(countingYoung) = resultingTable.mean_Alpha_LeftMotor_Symmetry(i);
       alpha_leftm_asym_Young(countingYoung) = resultingTable.mean_Alpha_LeftMotor_Asymmetry(i);
       alpha_leftm_unim_Young(countingYoung) = resultingTable.mean_Alpha_LeftMotor_Unimanual(i);

       alpha_rightm_sym_Young(countingYoung) = resultingTable.mean_Alpha_RightMotor_Symmetry(i);
       alpha_rightm_asym_Young(countingYoung) = resultingTable.mean_Alpha_RightMotor_Asymmetry(i);
       alpha_rightm_unim_Young(countingYoung) = resultingTable.mean_Alpha_RightMotor_Unimanual(i);

       LowBeta_front_sym_Young(countingYoung) = resultingTable.mean_LowBeta_Frontal_Symmetry(i);
       LowBeta_front_asum_Young(countingYoung) = resultingTable.mean_LowBeta_Frontal_Asymmetry(i);
       LowBeta_front_unim_Young(countingYoung) = resultingTable.mean_LowBeta_Frontal_Unimanual(i);
       
       LowBeta_biHem_sym_Young(countingYoung) = resultingTable.mean_LowBeta_MotorBiHemispheric_Symmetry(i);
       LowBeta_biHem_asym_Young(countingYoung) = resultingTable.mean_LowBeta_MotorBiHemispheric_Asymmetry(i);
       LowBeta_biHem_unim_Young(countingYoung) = resultingTable.mean_LowBeta_MotorBiHemispheric_Unimanual(i);

       LowBeta_leftm_sym_Young(countingYoung) = resultingTable.mean_LowBeta_LeftMotor_Symmetry(i);
       LowBeta_leftm_asym_Young(countingYoung) = resultingTable.mean_LowBeta_LeftMotor_Asymmetry(i);
       LowBeta_leftm_unim_Young(countingYoung) = resultingTable.mean_LowBeta_LeftMotor_Unimanual(i);

       LowBeta_rightm_sym_Young(countingYoung) = resultingTable.mean_LowBeta_RightMotor_Symmetry(i);
       LowBeta_rightm_asym_Young(countingYoung) = resultingTable.mean_LowBeta_RightMotor_Asymmetry(i);
       LowBeta_rightm_unim_Young(countingYoung) = resultingTable.mean_LowBeta_RightMotor_Unimanual(i);

       HighBeta_front_sym_Young(countingYoung) = resultingTable.mean_HighBeta_Frontal_Symmetry(i);
       HighBeta_front_asum_Young(countingYoung) = resultingTable.mean_HighBeta_Frontal_Asymmetry(i);
       HighBeta_front_unim_Young(countingYoung) = resultingTable.mean_HighBeta_Frontal_Unimanual(i);
       
       HighBeta_biHem_sym_Young(countingYoung) = resultingTable.mean_HighBeta_MotorBiHemispheric_Symmetry(i);
       HighBeta_biHem_asym_Young(countingYoung) = resultingTable.mean_HighBeta_MotorBiHemispheric_Asymmetry(i);
       HighBeta_biHem_unim_Young(countingYoung) = resultingTable.mean_HighBeta_MotorBiHemispheric_Unimanual(i);

       HighBeta_leftm_sym_Young(countingYoung) = resultingTable.mean_HighBeta_LeftMotor_Symmetry(i);
       HighBeta_leftm_asym_Young(countingYoung) = resultingTable.mean_HighBeta_LeftMotor_Asymmetry(i);
       HighBeta_leftm_unim_Young(countingYoung) = resultingTable.mean_HighBeta_LeftMotor_Unimanual(i);

       HighBeta_rightm_sym_Young(countingYoung) = resultingTable.mean_HighBeta_RightMotor_Symmetry(i);
       HighBeta_rightm_asym_Young(countingYoung) = resultingTable.mean_HighBeta_RightMotor_Asymmetry(i);
       HighBeta_rightm_unim_Young(countingYoung) = resultingTable.mean_HighBeta_RightMotor_Unimanual(i);

       Beta_front_sym_Young(countingYoung) = resultingTable.mean_Beta_Frontal_Symmetry(i);
       Beta_front_asum_Young(countingYoung) = resultingTable.mean_Beta_Frontal_Asymmetry(i);
       Beta_front_unim_Young(countingYoung) = resultingTable.mean_Beta_Frontal_Unimanual(i);
       
       Beta_biHem_sym_Young(countingYoung) = resultingTable.mean_Beta_MotorBiHemispheric_Symmetry(i);
       Beta_biHem_asym_Young(countingYoung) = resultingTable.mean_Beta_MotorBiHemispheric_Asymmetry(i);
       Beta_biHem_unim_Young(countingYoung) = resultingTable.mean_Beta_MotorBiHemispheric_Unimanual(i);

       Beta_leftm_sym_Young(countingYoung) = resultingTable.mean_Beta_LeftMotor_Symmetry(i);
       Beta_leftm_asym_Young(countingYoung) = resultingTable.mean_Beta_LeftMotor_Asymmetry(i);
       Beta_leftm_unim_Young(countingYoung) = resultingTable.mean_Beta_LeftMotor_Unimanual(i);

       Beta_rightm_sym_Young(countingYoung) = resultingTable.mean_Beta_RightMotor_Symmetry(i);
       Beta_rightm_asym_Young(countingYoung) = resultingTable.mean_Beta_RightMotor_Asymmetry(i);
       Beta_rightm_unim_Young(countingYoung) = resultingTable.mean_Beta_RightMotor_Unimanual(i);

        countingYoung = countingYoung + 1; 
    end
end

       mean_alpha_front_sym_adult = mean(alpha_front_sym_adult);
       mean_alpha_front_asym_adult = mean(alpha_front_asum_adult);
       mean_alpha_front_unim_adult = mean(alpha_front_unim_adult);
       
       mean_alpha_biHem_sym_adult= mean(alpha_biHem_sym_adult);
       mean_alpha_biHem_asym_adult = mean(alpha_biHem_asym_adult);
       mean_alpha_biHem_unim_adult= mean(alpha_biHem_unim_adult);

       mean_alpha_leftm_sym_adult = mean(alpha_leftm_sym_adult);
       mean_alpha_leftm_asym_adult = mean(alpha_leftm_asym_adult);
       mean_alpha_leftm_unim_adult = mean(alpha_leftm_unim_adult);

       mean_alpha_rightm_sym_adult = mean(alpha_rightm_sym_adult);
       mean_alpha_rightm_asym_adult = mean(alpha_rightm_asym_adult);
       mean_alpha_rightm_unim_adult = mean(alpha_rightm_unim_adult);

       mean_LowBeta_front_sym_adult = mean(LowBeta_front_sym_adult);
       mean_LowBeta_front_asym_adult = mean(LowBeta_front_asum_adult);
       mean_LowBeta_front_unim_adult = mean(LowBeta_front_unim_adult);
       
       mean_LowBeta_biHem_sym_adult = mean(LowBeta_biHem_sym_adult);
       mean_LowBeta_biHem_asym_adult = mean(LowBeta_biHem_asym_adult);
       mean_LowBeta_biHem_unim_adult = mean(LowBeta_biHem_unim_adult);

       mean_LowBeta_leftm_sym_adult = mean(LowBeta_leftm_sym_adult);
       mean_LowBeta_leftm_asym_adult = mean(LowBeta_leftm_asym_adult);
       mean_LowBeta_leftm_unim_adult = mean(LowBeta_leftm_unim_adult);

       mean_LowBeta_rightm_sym_adult = mean(LowBeta_rightm_sym_adult);
       mean_LowBeta_rightm_asym_adult = mean(LowBeta_rightm_asym_adult);
       mean_LowBeta_rightm_unim_adult = mean(LowBeta_rightm_unim_adult);

       mean_HighBeta_front_sym_adult = mean(HighBeta_front_sym_adult);
       mean_HighBeta_front_asym_adult = mean(HighBeta_front_asum_adult);
       mean_HighBeta_front_unim_adult = mean(HighBeta_front_unim_adult);
       
       mean_HighBeta_biHem_sym_adult = mean(HighBeta_biHem_sym_adult);
       mean_HighBeta_biHem_asym_adult = mean(HighBeta_biHem_asym_adult);
       mean_HighBeta_biHem_unim_adult = mean(HighBeta_biHem_unim_adult);

       mean_HighBeta_leftm_sym_adult = mean(HighBeta_leftm_sym_adult);
       mean_HighBeta_leftm_asym_adult = mean(HighBeta_leftm_asym_adult);
       mean_HighBeta_leftm_unim_adult =mean(HighBeta_leftm_unim_adult);

       mean_HighBeta_rightm_sym_adult = mean(HighBeta_rightm_sym_adult);
       mean_HighBeta_rightm_asym_adult = mean(HighBeta_rightm_asym_adult);
       mean_HighBeta_rightm_unim_adult = mean(HighBeta_rightm_unim_adult);

       mean_Beta_front_sym_adult = mean(Beta_front_sym_adult);
       mean_Beta_front_asym_adult = mean(Beta_front_asum_adult);
       mean_Beta_front_unim_adult = mean(Beta_front_unim_adult);
       
       mean_Beta_biHem_sym_adult = mean(Beta_biHem_sym_adult);
       mean_Beta_biHem_asym_adult = mean(Beta_biHem_asym_adult);
       mean_Beta_biHem_unim_adult = mean(Beta_biHem_unim_adult);

       mean_Beta_leftm_sym_adult = mean(Beta_leftm_sym_adult);
       mean_Beta_leftm_asym_adult = mean(Beta_leftm_asym_adult);
       mean_Beta_leftm_unim_adult = mean(Beta_leftm_unim_adult);

       mean_Beta_rightm_sym_adult = mean(Beta_rightm_sym_adult);
       mean_Beta_rightm_asym_adult = mean(Beta_rightm_asym_adult);
       mean_Beta_rightm_unim_adult = mean(Beta_rightm_unim_adult);

       mean_alpha_front_sym_Young = mean(alpha_front_sym_Young);
       mean_alpha_front_asym_Young = mean(alpha_front_asum_Young);
       mean_alpha_front_unim_Young = mean(alpha_front_unim_Young); 
       
       mean_alpha_biHem_sym_Young = mean(alpha_biHem_sym_Young);
       mean_alpha_biHem_asym_Young = mean(alpha_biHem_asym_Young);
       mean_alpha_biHem_unim_Young = mean(alpha_biHem_unim_Young);

       mean_alpha_leftm_sym_Young = mean(alpha_leftm_sym_Young);
       mean_alpha_leftm_asym_Young = mean(alpha_leftm_asym_Young);
       mean_alpha_leftm_unim_Young = mean(alpha_leftm_unim_Young);

       mean_alpha_rightm_sym_Young = mean(alpha_rightm_sym_Young);
       mean_alpha_rightm_asym_Young = mean(alpha_rightm_asym_Young);
       mean_alpha_rightm_unim_Young = mean(alpha_rightm_unim_Young);

       mean_LowBeta_front_sym_Young = mean(LowBeta_front_sym_Young);
       mean_LowBeta_front_asym_Young = mean(LowBeta_front_asum_Young);
       mean_LowBeta_front_unim_Young = mean(LowBeta_front_unim_Young);
       
       mean_LowBeta_biHem_sym_Young = mean(LowBeta_biHem_sym_Young);
       mean_LowBeta_biHem_asym_Young = mean(LowBeta_biHem_asym_Young);
       mean_LowBeta_biHem_unim_Young = mean(LowBeta_biHem_unim_Young);

       mean_LowBeta_leftm_sym_Young = mean(LowBeta_leftm_sym_Young);
       mean_LowBeta_leftm_asym_Young = mean(LowBeta_leftm_asym_Young);
       mean_LowBeta_leftm_unim_Young = mean(LowBeta_leftm_unim_Young);

       mean_LowBeta_rightm_sym_Young = mean(LowBeta_rightm_sym_Young);
       mean_LowBeta_rightm_asym_Young = mean(LowBeta_rightm_asym_Young);
       mean_LowBeta_rightm_unim_Young = mean(LowBeta_rightm_unim_Young);

       mean_HighBeta_front_sym_Young = mean(HighBeta_front_sym_Young);
       mean_HighBeta_front_asym_Young = mean(HighBeta_front_asum_Young);
       mean_HighBeta_front_unim_Young = mean(HighBeta_front_unim_Young);
       
      mean_HighBeta_biHem_sym_Young = mean(HighBeta_biHem_sym_Young);
       mean_HighBeta_biHem_asym_Young = mean(HighBeta_biHem_asym_Young);
      mean_HighBeta_biHem_unim_Young = mean(HighBeta_biHem_unim_Young);

       mean_HighBeta_leftm_sym_Young = mean(HighBeta_leftm_sym_Young);
       mean_HighBeta_leftm_asym_Young = mean(HighBeta_leftm_asym_Young);
       mean_HighBeta_leftm_unim_Young = mean(HighBeta_leftm_unim_Young);

       mean_HighBeta_rightm_sym_Young = mean(HighBeta_rightm_sym_Young);
       mean_HighBeta_rightm_asym_Young = mean(HighBeta_rightm_asym_Young);
       mean_HighBeta_rightm_unim_Young = mean(HighBeta_rightm_unim_Young);

       mean_Beta_front_sym_Young = mean(Beta_front_sym_Young);
       mean_Beta_front_asym_Young = mean(Beta_front_asum_Young);
       mean_Beta_front_unim_Young = mean(Beta_front_unim_Young);
       
       mean_Beta_biHem_sym_Young = mean(Beta_biHem_sym_Young);
       mean_Beta_biHem_asym_Young = mean(Beta_biHem_asym_Young);
       mean_Beta_biHem_unim_Young = mean(Beta_biHem_unim_Young);

       mean_Beta_leftm_sym_Young = mean(Beta_leftm_sym_Young);
       mean_Beta_leftm_asym_Young = mean(Beta_leftm_asym_Young);
       mean_Beta_leftm_unim_Young = mean(Beta_leftm_unim_Young);

       mean_Beta_rightm_sym_Young = mean(Beta_rightm_sym_Young);
       mean_Beta_rightm_asym_Young = mean(Beta_rightm_asym_Young);
       mean_Beta_rightm_unim_Young = mean(Beta_rightm_unim_Young);

       % Create Topological plots for the mean of the different
       % permutations 
       % Alpha X Symmetry 

       figureTitle = 'Alpha Power adults Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_alpha_front_sym_adult, motorBihemisphericElectrodes, mean_alpha_biHem_sym_adult, figureTitle);

       figureTitle = 'Alpha Power adults Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_alpha_leftm_sym_adult, rightMotorElectrodes, mean_alpha_rightm_sym_adult, figureTitle);

        figureTitle = 'Alpha Power Young Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_alpha_leftm_sym_Young, rightMotorElectrodes, mean_alpha_rightm_sym_Young, figureTitle);

       figureTitle = 'Alpha Power Young Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_alpha_front_sym_Young, motorBihemisphericElectrodes, mean_alpha_biHem_sym_Young, figureTitle);

       % LowBeta X Symmetry 

       figureTitle = 'LowBeta Power adults Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_LowBeta_front_sym_adult, motorBihemisphericElectrodes, mean_LowBeta_biHem_sym_adult, figureTitle);

       figureTitle = 'LowBeta Power adults Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_LowBeta_leftm_sym_adult, rightMotorElectrodes, mean_LowBeta_rightm_sym_adult, figureTitle);

        figureTitle = 'LowBeta Power Young Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_LowBeta_leftm_sym_Young, rightMotorElectrodes, mean_LowBeta_rightm_sym_Young, figureTitle);

       figureTitle = 'LowBeta Power Young Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_LowBeta_front_sym_Young, motorBihemisphericElectrodes, mean_LowBeta_biHem_sym_Young, figureTitle);

       % HighBeta X Symmetry 

       figureTitle = 'HighBeta Power adults Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_HighBeta_front_sym_adult, motorBihemisphericElectrodes, mean_HighBeta_biHem_sym_adult, figureTitle);

       figureTitle = 'HighBeta Power adults Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_HighBeta_leftm_sym_adult, rightMotorElectrodes, mean_HighBeta_rightm_sym_adult, figureTitle);

        figureTitle = 'HighBeta Power Young Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_HighBeta_leftm_sym_Young, rightMotorElectrodes, mean_HighBeta_rightm_sym_Young, figureTitle);

       figureTitle = 'HighBeta Power Young Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_HighBeta_front_sym_Young, motorBihemisphericElectrodes, mean_HighBeta_biHem_sym_Young, figureTitle);

        % Beta X Symmetry 

       figureTitle = 'Beta Power adults Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_Beta_front_sym_adult, motorBihemisphericElectrodes, mean_Beta_biHem_sym_adult, figureTitle);

       figureTitle = 'Beta Power adults Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_Beta_leftm_sym_adult, rightMotorElectrodes, mean_Beta_rightm_sym_adult, figureTitle);

        figureTitle = 'Beta Power Young Symmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_Beta_leftm_sym_Young, rightMotorElectrodes, mean_Beta_rightm_sym_Young, figureTitle);

       figureTitle = 'Beta Power Young Symmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_Beta_front_sym_Young, motorBihemisphericElectrodes, mean_Beta_biHem_sym_Young, figureTitle);

       % Alpha X Asymmetry 

       figureTitle = 'Alpha Power adults Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_alpha_front_asym_adult, motorBihemisphericElectrodes, mean_alpha_biHem_asym_adult, figureTitle);

       figureTitle = 'Alpha Power adults Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_alpha_leftm_asym_adult, rightMotorElectrodes, mean_alpha_rightm_asym_adult, figureTitle);

        figureTitle = 'Alpha Power Young Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_alpha_leftm_asym_Young, rightMotorElectrodes, mean_alpha_rightm_asym_Young, figureTitle);

       figureTitle = 'Alpha Power Young Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_alpha_front_asym_Young, motorBihemisphericElectrodes, mean_alpha_biHem_asym_Young, figureTitle);

       % LowBeta X Asymmetry 

       figureTitle = 'LowBeta Power adults Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_LowBeta_front_asym_adult, motorBihemisphericElectrodes, mean_LowBeta_biHem_asym_adult, figureTitle);

       figureTitle = 'LowBeta Power adults Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_LowBeta_leftm_asym_adult, rightMotorElectrodes, mean_LowBeta_rightm_asym_adult, figureTitle);

        figureTitle = 'LowBeta Power Young Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_LowBeta_leftm_asym_Young, rightMotorElectrodes, mean_LowBeta_rightm_asym_Young, figureTitle);

       figureTitle = 'LowBeta Power Young Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_LowBeta_front_asym_Young, motorBihemisphericElectrodes, mean_LowBeta_biHem_asym_Young, figureTitle);

       % HighBeta X Asymmetry 

       figureTitle = 'HighBeta Power adults Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_HighBeta_front_asym_adult, motorBihemisphericElectrodes, mean_HighBeta_biHem_asym_adult, figureTitle);

       figureTitle = 'HighBeta Power adults Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_HighBeta_leftm_asym_adult, rightMotorElectrodes, mean_HighBeta_rightm_asym_adult, figureTitle);

        figureTitle = 'HighBeta Power Young Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_HighBeta_leftm_asym_Young, rightMotorElectrodes, mean_HighBeta_rightm_asym_Young, figureTitle);

       figureTitle = 'HighBeta Power Young Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_HighBeta_front_asym_Young, motorBihemisphericElectrodes, mean_HighBeta_biHem_asym_Young, figureTitle);

        % Beta X Asymmetry 

       figureTitle = 'Beta Power adults Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_Beta_front_asym_adult, motorBihemisphericElectrodes, mean_Beta_biHem_asym_adult, figureTitle);

       figureTitle = 'Beta Power adults Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_Beta_leftm_asym_adult, rightMotorElectrodes, mean_Beta_rightm_asym_adult, figureTitle);

        figureTitle = 'Beta Power Young Asymmetry leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_Beta_leftm_asym_Young, rightMotorElectrodes, mean_Beta_rightm_asym_Young, figureTitle);

       figureTitle = 'Beta Power Young Asymmetry Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_Beta_front_asym_Young, motorBihemisphericElectrodes, mean_Beta_biHem_asym_Young, figureTitle);

       % Alpha X Unimanual

       figureTitle = 'Alpha Power adults Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_alpha_front_unim_adult, motorBihemisphericElectrodes, mean_alpha_biHem_unim_adult, figureTitle);

       figureTitle = 'Alpha Power adults Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_alpha_leftm_unim_adult, rightMotorElectrodes, mean_alpha_rightm_unim_adult, figureTitle);

        figureTitle = 'Alpha Power Young Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_alpha_leftm_unim_Young, rightMotorElectrodes, mean_alpha_rightm_unim_Young, figureTitle);

       figureTitle = 'Alpha Power Young Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_alpha_front_unim_Young, motorBihemisphericElectrodes, mean_alpha_biHem_unim_Young, figureTitle);

       % LowBeta X Unimanual 

       figureTitle = 'LowBeta Power adults Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_LowBeta_front_unim_adult, motorBihemisphericElectrodes, mean_LowBeta_biHem_unim_adult, figureTitle);

       figureTitle = 'LowBeta Power adults Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_LowBeta_leftm_unim_adult, rightMotorElectrodes, mean_LowBeta_rightm_unim_adult, figureTitle);

        figureTitle = 'LowBeta Power Young Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_LowBeta_leftm_unim_Young, rightMotorElectrodes, mean_LowBeta_rightm_unim_Young, figureTitle);

       figureTitle = 'LowBeta Power Young Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_LowBeta_front_unim_Young, motorBihemisphericElectrodes, mean_LowBeta_biHem_unim_Young, figureTitle);

       % HighBeta X Unimanual 

       figureTitle = 'HighBeta Power adults Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_HighBeta_front_unim_adult, motorBihemisphericElectrodes, mean_HighBeta_biHem_unim_adult, figureTitle);

       figureTitle = 'HighBeta Power adults Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_HighBeta_leftm_unim_adult, rightMotorElectrodes, mean_HighBeta_rightm_unim_adult, figureTitle);

        figureTitle = 'HighBeta Power Young Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_HighBeta_leftm_unim_Young, rightMotorElectrodes, mean_HighBeta_rightm_unim_Young, figureTitle);

       figureTitle = 'HighBeta Power Young Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_HighBeta_front_unim_Young, motorBihemisphericElectrodes, mean_HighBeta_biHem_unim_Young, figureTitle);

        % Beta X Unimanual 

       figureTitle = 'Beta Power adults Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_Beta_front_unim_adult, motorBihemisphericElectrodes, mean_Beta_biHem_unim_adult, figureTitle);

       figureTitle = 'Beta Power adults Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_Beta_leftm_unim_adult, rightMotorElectrodes, mean_Beta_rightm_unim_adult, figureTitle);

        figureTitle = 'Beta Power Young Unimanual leftmotor VS rightmotor';
       CreateTopoplotsFromMeans(leftMotorElectrodes, meanPowerPrEEGCluster, mean_Beta_leftm_unim_Young, rightMotorElectrodes, mean_Beta_rightm_unim_Young, figureTitle);

       figureTitle = 'Beta Power Young Unimanual Frontal VS BihemisphericMotor';
       CreateTopoplotsFromMeans(frontalElectrodes, meanPowerPrEEGCluster, mean_Beta_front_unim_Young, motorBihemisphericElectrodes, mean_Beta_biHem_unim_Young, figureTitle);

end