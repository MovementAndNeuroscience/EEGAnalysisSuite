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
allConditions = [2,3,4,5,6,7];

AllElectrodes = [1:64];


% Create Empty Arrays for the different frequency x location x condition permutations 

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
% different arrays / vectors have to be arranged in a table in order to be
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
addpath(genpath(EEGLabPath)); 

FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-1,1];
CreateTopoplotsBasedOnTable(AlphaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(HighBetaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(LowBetaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing Symmetric tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing Symmetric tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing Symmetric tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(BetaSymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION ASYMMETRY

addpath(genpath(EEGLabPath)); 
FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-1,1];
CreateTopoplotsBasedOnTable(AlphaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(HighBetaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(LowBetaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing Asymmetric tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing Asymmetric tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing Asymmetric tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(BetaAsymmetryTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION UNIMANUAL

FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-1,1];
CreateTopoplotsBasedOnTable(AlphaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(HighBetaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(LowBetaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing Unimanual tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing Unimanual tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing Unimanaual tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(BetaUnimanualTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION ALL TASKS 

FigureTitleGroup1 = 'Alpha (8-12 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'Alpha (8-12 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in Alpha (8-12 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-1.5,1.5];
figurelimitG2 = [-1.5,1.5];
figurelimitdif = [-1,1];
CreateTopoplotsBasedOnTable(AlphaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'High Beta (24-32 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'High Beta (24-32 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in High Beta (24-32 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(HighBetaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Low Beta (14-22 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'Low Beta (14-22 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in Low Beta (14-22 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(LowBetaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

FigureTitleGroup1 = 'Beta (14-32 Hz) Power For Adult Performing All tasks';
FigureTitleGroup2 = 'Beta (14-32 Hz) Power For Young Performing All tasks';
FigureTitleDifference = 'Difference in Beta (14-32 Hz) Power between adults (+) and Youngs (-) Performing All tasks';
figurelimitG1 = [-1,1];
figurelimitG2 = [-1,1];
figurelimitdif = [-0.5,0.5];
CreateTopoplotsBasedOnTable(BetaAllTable, AllElectrodes,FigureTitleGroup1, FigureTitleGroup2, FigureTitleDifference, figurelimitG1, figurelimitG2, figurelimitdif );

%% FIGURE CREATION SYMMETRIC VS ASYMMETRIC

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