filepath= 'C:\Users\tvh307\OneDrive - University of Copenhagen\Documents\MovementNeuroscience\ReScale\ReScaleEEGData'; % put your filepath
files = dir(fullfile(filepath, '*.set'));

EEGLabPath = 'C:\eeglab2022.0'; % change the filepath for your eeglab
electrodes = FindNumberOfElectrodes(files, filepath, EEGLabPath); 
maxNumberOfConditions = FindMaxNumberOfConditions(files, filepath, EEGLabPath); 
NumberOfFiles = size(files,1);

groupNumbers = [1 ;2]; 
groupSearchCriteria = ["D"; "y"];

% Defining different locations and condition of interest 
symmetricConditions = [2,3]; 
asymmetricConditions = [4,5];
unimanualConditions = [6,7];

frontalElectrodes = [5,4,38,39,40,10,11,47,46,45];
motorBihemisphericElectrodes = [13,12,48,49,50];
leftMotorElectrodes = [9,10,11,14,13,12,17,18,19];
rightMotorElectrodes = [46,45,44,49,50,51,56,55,54];

%% Create Empty Arrays for the different frequency x location x condition permutations 

mean_Alpha_Frontal_Symmetry = zeros(NumberOfFiles,1);
mean_LowBeta_Frontal_Symmetry = zeros(NumberOfFiles,1);
mean_HighBeta_Frontal_Symmetry = zeros(NumberOfFiles,1);
mean_Beta_Frontal_Symmetry = zeros(NumberOfFiles,1);

mean_Alpha_Frontal_Asymmetry = zeros(NumberOfFiles,1);
mean_LowBeta_Frontal_Asymmetry = zeros(NumberOfFiles,1);
mean_HighBeta_Frontal_Asymmetry = zeros(NumberOfFiles,1);
mean_Beta_Frontal_Asymmetry = zeros(NumberOfFiles,1);

mean_Alpha_Frontal_Unimanual = zeros(NumberOfFiles,1);
mean_LowBeta_Frontal_Unimanual = zeros(NumberOfFiles,1);
mean_HighBeta_Frontal_Unimanual = zeros(NumberOfFiles,1);
mean_Beta_Frontal_Unimanual = zeros(NumberOfFiles,1);

mean_Alpha_MotorBiHemispheric_Symmetry = zeros(NumberOfFiles,1);
mean_LowBeta_MotorBiHemispheric_Symmetry = zeros(NumberOfFiles,1);
mean_HighBeta_MotorBiHemispheric_Symmetry = zeros(NumberOfFiles,1);
mean_Beta_MotorBiHemispheric_Symmetry = zeros(NumberOfFiles,1);

mean_Alpha_MotorBiHemispheric_Asymmetry = zeros(NumberOfFiles,1);
mean_LowBeta_MotorBiHemispheric_Asymmetry = zeros(NumberOfFiles,1);
mean_HighBeta_MotorBiHemispheric_Asymmetry = zeros(NumberOfFiles,1);
mean_Beta_MotorBiHemispheric_Asymmetry = zeros(NumberOfFiles,1);

mean_Alpha_MotorBiHemispheric_Unimanual = zeros(NumberOfFiles,1);
mean_LowBeta_MotorBiHemispheric_Unimanual = zeros(NumberOfFiles,1);
mean_HighBeta_MotorBiHemispheric_Unimanual = zeros(NumberOfFiles,1);
mean_Beta_MotorBiHemispheric_Unimanual = zeros(NumberOfFiles,1);

mean_Alpha_LeftMotor_Symmetry = zeros(NumberOfFiles,1);
mean_LowBeta_LeftMotor_Symmetry = zeros(NumberOfFiles,1);
mean_HighBeta_LeftMotor_Symmetry = zeros(NumberOfFiles,1);
mean_Beta_LeftMotor_Symmetry = zeros(NumberOfFiles,1);

mean_Alpha_LeftMotor_Asymmetry = zeros(NumberOfFiles,1);
mean_LowBeta_LeftMotor_Asymmetry = zeros(NumberOfFiles,1);
mean_HighBeta_LeftMotor_Asymmetry = zeros(NumberOfFiles,1);
mean_Beta_LeftMotor_Asymmetry = zeros(NumberOfFiles,1);

mean_Alpha_LeftMotor_Unimanual = zeros(NumberOfFiles,1);
mean_LowBeta_LeftMotor_Unimanual = zeros(NumberOfFiles,1);
mean_HighBeta_LeftMotor_Unimanual = zeros(NumberOfFiles,1);
mean_Beta_LeftMotor_Unimanual = zeros(NumberOfFiles,1);

mean_Alpha_RightMotor_Symmetry = zeros(NumberOfFiles,1);
mean_LowBeta_RightMotor_Symmetry = zeros(NumberOfFiles,1);
mean_HighBeta_RightMotor_Symmetry = zeros(NumberOfFiles,1);
mean_Beta_RightMotor_Symmetry = zeros(NumberOfFiles,1);

mean_Alpha_RightMotor_Asymmetry = zeros(NumberOfFiles,1);
mean_LowBeta_RightMotor_Asymmetry = zeros(NumberOfFiles,1);
mean_HighBeta_RightMotor_Asymmetry = zeros(NumberOfFiles,1);
mean_Beta_RightMotor_Asymmetry = zeros(NumberOfFiles,1);

mean_Alpha_RightMotor_Unimanual = zeros(NumberOfFiles,1);
mean_LowBeta_RightMotor_Unimanual = zeros(NumberOfFiles,1);
mean_HighBeta_RightMotor_Unimanual = zeros(NumberOfFiles,1);
mean_Beta_RightMotor_Unimanual = zeros(NumberOfFiles,1);

NamesOnAllFiles(NumberOfFiles:1) = "fileName"; 
SubjectGroupArray = size(files);

%%
for fileIndex=1:NumberOfFiles
clear cond

NamesOnAllFiles(fileIndex) = files(fileIndex).name; 
SubjectGroupArray(fileIndex) = ProvideGroupNumber(groupNumbers, groupSearchCriteria,files(fileIndex).name);

addpath(genpath(EEGLabPath)); 
EEG = pop_loadset('filename',files(fileIndex).name,'filepath',filepath);
epochs={EEG.epoch.eventedftype};
rmpath(genpath(EEGLabPath)); % change the filepath for your eeglab

[mean_Alpha_Frontal_Symmetry(fileIndex), mean_HighBeta_Frontal_Symmetry(fileIndex), mean_LowBeta_Frontal_Symmetry(fileIndex), mean_Beta_Frontal_Symmetry(fileIndex)]... 
    = MeanPowerBasedOnLocationAndCondition(epochs, frontalElectrodes, symmetricConditions, EEG);
[mean_Alpha_Frontal_Asymmetry(fileIndex), mean_HighBeta_Frontal_Asymmetry(fileIndex), mean_LowBeta_Frontal_Asymmetry(fileIndex), mean_Beta_Frontal_Asymmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, frontalElectrodes, asymmetricConditions, EEG);
[mean_Alpha_Frontal_Unimanual(fileIndex), mean_HighBeta_Frontal_Unimanual(fileIndex), mean_LowBeta_Frontal_Unimanual(fileIndex), mean_Beta_Frontal_Unimanual(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, frontalElectrodes, unimanualConditions, EEG);

[mean_Alpha_MotorBiHemispheric_Symmetry(fileIndex), mean_HighBeta_MotorBiHemispheric_Symmetry(fileIndex), mean_LowBeta_MotorBiHemispheric_Symmetry(fileIndex), mean_Beta_MotorBiHemispheric_Symmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, motorBihemisphericElectrodes, symmetricConditions, EEG);
[mean_Alpha_MotorBiHemispheric_Asymmetry(fileIndex), mean_HighBeta_MotorBiHemispheric_Asymmetry(fileIndex), mean_LowBeta_MotorBiHemispheric_Asymmetry(fileIndex), mean_Beta_MotorBiHemispheric_Asymmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, motorBihemisphericElectrodes, asymmetricConditions, EEG);
[mean_Alpha_MotorBiHemispheric_Unimanual(fileIndex), mean_HighBeta_MotorBiHemispheric_Unimanual(fileIndex), mean_LowBeta_MotorBiHemispheric_Unimanual(fileIndex), mean_Beta_MotorBiHemispheric_Unimanual(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, motorBihemisphericElectrodes, unimanualConditions, EEG);

[mean_Alpha_LeftMotor_Symmetry(fileIndex), mean_HighBeta_LeftMotor_Symmetry(fileIndex), mean_LowBeta_LeftMotor_Symmetry(fileIndex), mean_Beta_LeftMotor_Symmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, leftMotorElectrodes, symmetricConditions, EEG);
[mean_Alpha_LeftMotor_Asymmetry(fileIndex), mean_HighBeta_LeftMotor_Asymmetry(fileIndex), mean_LowBeta_LeftMotor_Asymmetry(fileIndex), mean_Beta_LeftMotor_Asymmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, leftMotorElectrodes, asymmetricConditions, EEG);
[mean_Alpha_LeftMotor_Unimanual(fileIndex), mean_HighBeta_LeftMotor_Unimanual(fileIndex), mean_LowBeta_LeftMotor_Unimanual(fileIndex), mean_Beta_LeftMotor_Unimanual(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, leftMotorElectrodes, unimanualConditions, EEG);

[mean_Alpha_RightMotor_Symmetry(fileIndex), mean_HighBeta_RightMotor_Symmetry(fileIndex), mean_LowBeta_RightMotor_Symmetry(fileIndex), mean_Beta_RightMotor_Symmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, rightMotorElectrodes, symmetricConditions, EEG);
[mean_Alpha_RightMotor_Asymmetry(fileIndex), mean_HighBeta_RightMotor_Asymmetry(fileIndex), mean_LowBeta_RightMotor_Asymmetry(fileIndex), mean_Beta_RightMotor_Asymmetry(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, rightMotorElectrodes, asymmetricConditions, EEG);
[mean_Alpha_RightMotor_Unimanual(fileIndex), mean_HighBeta_RightMotor_Unimanual(fileIndex), mean_LowBeta_RightMotor_Unimanual(fileIndex), mean_Beta_RightMotor_Unimanual(fileIndex)]...
    = MeanPowerBasedOnLocationAndCondition(epochs, rightMotorElectrodes, unimanualConditions, EEG);

end

%%
resultingTable = table(NamesOnAllFiles', SubjectGroupArray', mean_Alpha_Frontal_Symmetry, mean_HighBeta_Frontal_Symmetry, mean_LowBeta_Frontal_Symmetry...
    , mean_Beta_Frontal_Symmetry, mean_Alpha_Frontal_Asymmetry...
    , mean_HighBeta_Frontal_Asymmetry, mean_LowBeta_Frontal_Asymmetry, mean_Beta_Frontal_Asymmetry,mean_Alpha_Frontal_Unimanual,mean_HighBeta_Frontal_Unimanual...
    , mean_LowBeta_Frontal_Unimanual, mean_Beta_Frontal_Unimanual,mean_Alpha_MotorBiHemispheric_Symmetry, mean_HighBeta_MotorBiHemispheric_Symmetry...
    , mean_LowBeta_MotorBiHemispheric_Symmetry, mean_Beta_MotorBiHemispheric_Symmetry, mean_Alpha_MotorBiHemispheric_Asymmetry, mean_HighBeta_MotorBiHemispheric_Asymmetry...
    , mean_LowBeta_MotorBiHemispheric_Asymmetry, mean_Beta_MotorBiHemispheric_Asymmetry, mean_Alpha_MotorBiHemispheric_Unimanual, mean_HighBeta_MotorBiHemispheric_Unimanual...
    , mean_LowBeta_MotorBiHemispheric_Unimanual, mean_Beta_MotorBiHemispheric_Unimanual, mean_Alpha_LeftMotor_Symmetry, mean_HighBeta_LeftMotor_Symmetry, mean_LowBeta_LeftMotor_Symmetry...
    , mean_Beta_LeftMotor_Symmetry, mean_Alpha_LeftMotor_Asymmetry, mean_HighBeta_LeftMotor_Asymmetry,  mean_LowBeta_LeftMotor_Asymmetry, mean_Beta_LeftMotor_Asymmetry...
    , mean_Alpha_LeftMotor_Unimanual, mean_HighBeta_LeftMotor_Unimanual, mean_LowBeta_LeftMotor_Unimanual, mean_Beta_LeftMotor_Unimanual...
    , mean_Alpha_RightMotor_Symmetry, mean_HighBeta_RightMotor_Symmetry, mean_LowBeta_RightMotor_Symmetry, mean_Beta_RightMotor_Symmetry, mean_Alpha_RightMotor_Asymmetry...
    , mean_HighBeta_RightMotor_Asymmetry, mean_LowBeta_RightMotor_Asymmetry, mean_Beta_RightMotor_Asymmetry, mean_Alpha_RightMotor_Unimanual, mean_HighBeta_RightMotor_Unimanual...
    , mean_LowBeta_RightMotor_Unimanual, mean_Beta_RightMotor_Unimanual); 

resultingTable = renamevars(resultingTable,["Var1","Var2"],["NameOfFiles","SubjectGroupNr"]);


filename = 'FrequenciesOverLocationsAndConditions.xlsx';
writetable(resultingTable,filename,'Sheet',1,'Range','A1')