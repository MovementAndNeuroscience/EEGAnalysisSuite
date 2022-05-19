% The purpose of this script is to calculate FrequencyPower X ElectrodeCluster X Condition per person 
% and collect it in an Excel file for further descriptive analysis. 

% First we direct matlab to where all the data files are. 
% the nwe figure out the number og electrodes. 
% which of the test participant's dataset has most trials 
% and we will get the total number of files 

% next you define the participant groups by number. 
% then you write the first letter found in each of those defined groups. 
% in this case our grownups datasets starts with a "D" and our younglings
% dataset starts with a "y"

%% SETUP 
filepath= 'C:\Users\tvh307\OneDrive - University of Copenhagen\Documents\MovementNeuroscience\ReScale\ReScaleEEGData'; % put your filepath
files = dir(fullfile(filepath, '*.set'));

EEGLabPath = 'C:\eeglab2022.0'; % change the filepath for your eeglab
electrodes = FindNumberOfElectrodes(files, filepath, EEGLabPath); 
maxNumberOfConditions = FindMaxNumberOfConditions(files, filepath, EEGLabPath); 
NumberOfFiles = size(files,1);

groupNumbers = [1 ;2]; 
groupSearchCriteria = ["D"; "y"];

% Defining different locations and condition of interest 
% we are interested in three different condition categories 
% and four different clusters of electrodes.

symmetricConditions = [2,3]; 
asymmetricConditions = [4,5];
unimanualConditions = [6,7];

frontalElectrodes = [5,4,38,39,40,10,11,47,46,45];
motorBihemisphericElectrodes = [13,12,48,49,50];
leftMotorElectrodes = [9,10,11,14,13,12,17,18,19];
rightMotorElectrodes = [46,45,44,49,50,51,56,55,54];

% Create Empty Arrays for the different frequency x location x condition permutations 

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

%and we want two arrays to keep track of subjects and groups of subjects. 

NamesOnAllFiles(NumberOfFiles:1) = "fileName"; 
SubjectGroupArray = size(files);

%% CALCULATE 
% All these functions is per subject based. 
% first we figure out which group the subject belongs to. 
% Then we calculate the mean power of specific frequencies based on
% conditions and electrode clusters. 
% the function is called MeanPowerBasedOnLocationAndCondition

for fileIndex=1:NumberOfFiles

NamesOnAllFiles(fileIndex) = files(fileIndex).name; 
SubjectGroupArray(fileIndex) = ProvideGroupNumber(groupNumbers, groupSearchCriteria,files(fileIndex).name);

addpath(genpath(EEGLabPath)); 
EEG = pop_loadset('filename',files(fileIndex).name,'filepath',filepath);
epochs={EEG.epoch.eventedftype};
rmpath(genpath(EEGLabPath)); 

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

%% ARRANGE AND PRESENT 
% After we have calculated the mean frequency pwoer for all subjects the
% different arrays / vectors have to be arranged in a table in order to be
% exported to a readable Excel file. 
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

filename = 'MeanFrequencyPowerOverLocationsAndConditions.xlsx';
writetable(resultingTable,filename,'Sheet',1,'Range','A1')
