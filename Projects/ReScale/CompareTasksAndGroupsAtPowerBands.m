% The purpose of this script is to calculate FrequencyPower X Condition per person 
% and collect it in different Excel file for descriptive statistics. 
% Furthermore different Topoplots are created showcasing the different
% Frequencypower X Condition X Subject groups permutation and visual differences between the
% different conditions 

% We Seperate the script into four different sections. 
% SETUP, CALCULATE, ARRANGE AND PRESENT.

% SETUP
% This section will prepare different arrays, variables and contrains to be
% used throughout the script 

% CALCULATE
% This part of the script will use the different elements from the setup to
% calculate different statistics 

% ARRANGE AND PRESENT
% This part will present the calculations into different exportable tables
% and figures 

%% SETUP
% First we direct matlab to where all the data files are. 
% then we figure out the number og electrodes. 
% which of the test participant's dataset has most trials 
% and we will get the total number of files 

% next you define the participant groups by number. 
% then you write the first letter found in each of those defined groups. 
% in this case our Adult datasets starts with a "D" and our Young
% dataset starts with a "y"
filepath= 'C:\Users\tvh307\OneDrive - University of Copenhagen\Documents\MovementNeuroscience\ReScale\ReScaleEEGData'; % put your filepath
files = dir(fullfile(filepath, '*.set'));

EEGLabPath = 'C:\eeglab2022.0'; % change the filepath for your eeglab
electrodes = FindNumberOfElectrodes(files, filepath, EEGLabPath); 
maxNumberOfConditions = FindMaxNumberOfConditions(files, filepath, EEGLabPath); 
NumberOfFiles = size(files,1);

groupNumbers = [1 ;2]; 
groupSearchCriteria = ["D"; "y"];

% Defining different condition of interest 
% we are interested in three different condition categories 

symmetricConditions = [2,3]; 
asymmetricConditions = [4,5];
unimanualConditions = [6,7];
allConditions = [2,3,4,5,6,7];

AllElectrodes = [1:64];


% Create Empty Arrays for the different frequency x condition permutations 

mean_Alpha_Symmetry = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_LowBeta_Symmetry = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_HighBeta_Symmetry = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_Beta_Symmetry = zeros(NumberOfFiles,size(AllElectrodes,2));

mean_Alpha_Asymmetry = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_LowBeta_Asymmetry = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_HighBeta_Asymmetry = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_Beta_Asymmetry = zeros(NumberOfFiles,size(AllElectrodes,2));

mean_Alpha_Unimanual = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_LowBeta_Unimanual = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_HighBeta_Unimanual = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_Beta_Unimanual = zeros(NumberOfFiles,size(AllElectrodes,2));

mean_Alpha_All = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_LowBeta_All = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_HighBeta_All = zeros(NumberOfFiles,size(AllElectrodes,2));
mean_Beta_All = zeros(NumberOfFiles,size(AllElectrodes,2));

% and we want two arrays to keep track of name of files (subjects) and
% subjectgroups.

NamesOnAllFiles(NumberOfFiles:1) = "fileName"; 
SubjectGroupArray = size(files);

%% CALCULATE 
% All these functions is per subject based. 
% first we figure out which group the subject belongs to. 
% Then we calculate the mean power for each electrode 
% based on specific frequencies and conditions 
% the function is called MeanPowerPerElctrodeBasedOnCondition

for fileIndex=1:NumberOfFiles

NamesOnAllFiles(fileIndex) = files(fileIndex).name; 
SubjectGroupArray(fileIndex) = ProvideGroupNumber(groupNumbers, groupSearchCriteria,files(fileIndex).name);

addpath(genpath(EEGLabPath)); 
EEG = pop_loadset('filename',files(fileIndex).name,'filepath',filepath);
epochs={EEG.epoch.eventedftype};
rmpath(genpath(EEGLabPath)); 

[mean_Alpha_Symmetry(fileIndex,:), mean_HighBeta_Symmetry(fileIndex,:), mean_LowBeta_Symmetry(fileIndex,:), mean_Beta_Symmetry(fileIndex,:)]... 
    = MeanPowerPerElctrodeBasedOnCondition(epochs, AllElectrodes, symmetricConditions, EEG);
[mean_Alpha_Asymmetry(fileIndex,:), mean_HighBeta_Asymmetry(fileIndex,:), mean_LowBeta_Asymmetry(fileIndex,:), mean_Beta_Asymmetry(fileIndex,:)]... 
    = MeanPowerPerElctrodeBasedOnCondition(epochs, AllElectrodes, asymmetricConditions, EEG);
[mean_Alpha_Unimanual(fileIndex,:), mean_HighBeta_Unimanual(fileIndex,:), mean_LowBeta_Unimanual(fileIndex,:), mean_Beta_Unimanual(fileIndex,:)]...
    = MeanPowerPerElctrodeBasedOnCondition(epochs, AllElectrodes, unimanualConditions, EEG);
[mean_Alpha_All(fileIndex,:), mean_HighBeta_All(fileIndex,:), mean_LowBeta_All(fileIndex,:), mean_Beta_All(fileIndex,:)]...
    = MeanPowerPerElctrodeBasedOnCondition(epochs, AllElectrodes, allConditions, EEG);

end

%% ARRANGE AND PRESENT 
% After we have calculated the mean frequency pwoer for all subjects the
% different arrays / vectors have to be arranged in a tables in order to be
% exported to a readable Excel file. 

AlphaSymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray, mean_Alpha_Symmetry, 'AlphaSymmetryAllSubjects.xlsx');

HighBetaSymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_HighBeta_Symmetry, 'HighBetaSymmetryAllSubjects.xlsx');

LowBetaSymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_LowBeta_Symmetry, 'LowBetaSymmetryAllSubjects.xlsx');

BetaSymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_Beta_Symmetry, 'BetaSymmetryAllSubjects.xlsx');

%% ASYMMETRY TABLES CREATION
AlphaAsymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray, mean_Alpha_Asymmetry, 'AlphaAsymmetryAllSubjects.xlsx');

HighBetaAsymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_HighBeta_Asymmetry, 'HighBetaAsymmetryAllSubjects.xlsx');

LowBetaAsymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_LowBeta_Asymmetry, 'LowBetaAsymmetryAllSubjects.xlsx');

BetaAsymmetryTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_Beta_Asymmetry, 'BetaAsymmetryAllSubjects.xlsx');

%% UNIMANUAL TABLE CREATION 

AlphaUnimanualTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray, mean_Alpha_Unimanual, 'AlphaUnimanualAllSubjects.xlsx');

HighBetaUnimanualTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_HighBeta_Unimanual, 'HighBetaUnimanualAllSubjects.xlsx');

LowBetaUnimanualTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_LowBeta_Unimanual, 'LowBetaUnimanualAllSubjects.xlsx');

BetaUnimanualTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_Beta_Unimanual, 'BetaUnimanualAllSubjects.xlsx');

%% ALL TASKS TABLE CREATION 

AlphaAllTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray, mean_Alpha_All, 'AlphaAllAllSubjects.xlsx');

HighBetaAllTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_HighBeta_All, 'HighBetaAllAllSubjects.xlsx');

LowBetaAllTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_LowBeta_All, 'LowBetaAllAllSubjects.xlsx');

BetaAllTable = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray,  mean_Beta_All, 'BetaAllAllSubjects.xlsx');

%% FIGURE CREATION 
% with all the different tables established they are used to create
% different topoplots showing frequency distributions based on frequency,
% conditiion and subject groups. 

addpath(genpath(EEGLabPath)); 

FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(AlphaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(HighBetaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(LowBetaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(BetaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION ASYMMETRY

addpath(genpath(EEGLabPath)); 
FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(AlphaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(HighBetaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(LowBetaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(BetaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION UNIMANUAL

FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(AlphaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(HighBetaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(LowBetaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(BetaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION ALL TASKS 

FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(AlphaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(HighBetaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(LowBetaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-0.4,0.4];
figurelimitG2 = [-0.4,0.4];
figurelimitdif = [-0.4,0.4];
CreateTopoplotsBasedOnTable(BetaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION SYMMETRIC VS ASYMMETRIC
% unlike the figures above the following plots show differences between
% different consitions, thus we need to create topoplots based on
% two difference tables. 

FigureTitleDifference1 = 'Difference in Alpha (8-12 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Young';
FigureTitleDifference2 = 'Difference in Alpha (8-12 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Adult';
figurelimitdif1 = [-0.1,0.1];
figurelimitdif2 = [-0.1,0.1];
CreateTopoplotsBasedOnTables(AlphaSymmetryTable, AlphaAsymmetryTable,AllElectrodes,FigureTitleDifference1, FigureTitleDifference2, figurelimitdif1, figurelimitdif2)

FigureTitleDifference1 = 'Difference in High Beta (24-32 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Young';
FigureTitleDifference2 = 'Difference in High Beta (24-32 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Adult';
figurelimitdif1 = [-0.05,0.05];
figurelimitdif2 = [-0.05,0.05];
CreateTopoplotsBasedOnTables(HighBetaSymmetryTable, HighBetaAsymmetryTable,AllElectrodes,FigureTitleDifference1, FigureTitleDifference2, figurelimitdif1, figurelimitdif2)

FigureTitleDifference1 = 'Difference in Low Beta (14-22 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Young';
FigureTitleDifference2 = 'Difference in Low Beta (14-22 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Adult';
figurelimitdif1 = [-0.05,0.05];
figurelimitdif2 = [-0.05,0.05];
CreateTopoplotsBasedOnTables(LowBetaSymmetryTable, LowBetaAsymmetryTable,AllElectrodes,FigureTitleDifference1, FigureTitleDifference2, figurelimitdif1, figurelimitdif2)

FigureTitleDifference1 = 'Difference in Beta (14-32 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Young';
FigureTitleDifference2 = 'Difference in Beta (14-32 Hz) Power between Symmetric (+) and Assymetric (-) Performed By Adult';
figurelimitdif1 = [-0.05,0.05];
figurelimitdif2 = [-0.05,0.05];
CreateTopoplotsBasedOnTables(BetaSymmetryTable, BetaAsymmetryTable,AllElectrodes,FigureTitleDifference1, FigureTitleDifference2, figurelimitdif1, figurelimitdif2)

rmpath(genpath(EEGLabPath)); 