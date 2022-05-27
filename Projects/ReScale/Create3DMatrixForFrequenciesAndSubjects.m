%%

filepath= 'C:\Users\tvh307\OneDrive - University of Copenhagen\Documents\MovementNeuroscience\ReScale\ReScaleEEGData'; % put your filepath
files = dir(fullfile(filepath, '*.set'));

EEGLabPath = 'C:\eeglab2022.0'; % change the filepath for your eeglab
electrodes = FindNumberOfElectrodes(files, filepath, EEGLabPath); 
maxNumberOfConditions = FindMaxNumberOfConditions(files, filepath, EEGLabPath); 
NumberOfFiles = size(files,1);

groupNumbers = [1 ;2]; 
groupSearchCriteria = ["D"; "y"];
SubjectGroupArray = size(files,1);

%% Create Empty 3D Matrixes and 2D Conditions Matrixes
psd_AllAlpha = zeros(NumberOfFiles,maxNumberOfConditions,electrodes);
psd_AllLowBeta = zeros(NumberOfFiles,maxNumberOfConditions,electrodes);
psd_AllHighBeta = zeros(NumberOfFiles,maxNumberOfConditions,electrodes);
psd_AllBeta = zeros(NumberOfFiles,maxNumberOfConditions,electrodes);

conditionsAll(1:NumberOfFiles, 1:maxNumberOfConditions) = 999;
NamesOnAllFiles(1:NumberOfFiles) = "fileName"; 
%%
for fileIndex=1:NumberOfFiles
clear cond

NamesOnAllFiles(fileIndex) = files(fileIndex).name; 
SubjectGroupArray(fileIndex) = ProvideGroupNumber(groupNumbers, groupSearchCriteria,files(fileIndex).name);

addpath(genpath(EEGLabPath)); 
EEG = pop_loadset('filename',files(fileIndex).name,'filepath',filepath);

fs=EEG.srate;
nfft=fs/2; % PSD has a resolution of 2Hz
temp={EEG.epoch.eventedftype};
rmpath(genpath(EEGLabPath)); % change the filepath for your eeglab


for i=1:size(temp,2)
    temp1=temp(i);
    cond(i)=cell2mat(temp1{1}(1)); % contains the information about the condition
    [pxx,f] = pwelch(squeeze(EEG.data(:,:,i))',hamming(nfft),0,nfft,fs); % PSD is estimated on all the channels
    psd_a(i,:)=mean(pxx(5:7,:),1); % estimation of alpha (8-12 Hz) for single subject
    psd_bl(i,:)=mean(pxx(8:12,:),1); % estimation of low beta (14-22 Hz) for single subject
    psd_bh(i,:)=mean(pxx(13:17,:),1); % estimation of high beta (24-32 Hz) for single subject
    psd_b(i,:)=mean(pxx(8:17,:),1); % estimation of total beta (14-32 Hz) for single subject
end

for condition = 1:size(cond,2)

        % All the subjects Powerspectral density data will be included in
        % the 3D matrixes. There will be alot of zeoroes as there is a
        % chance for bad trials. However, those are easily sorted out, as
        % they are corresponding to condition 999, which will be a fake
        % trial. 
        
        psd_AllAlpha(fileIndex,condition,:)=psd_a(condition,:);
        psd_AllLowBeta(fileIndex,condition,:)=psd_bl(condition,:);
        psd_AllHighBeta(fileIndex,condition,:)=psd_bh(condition,:);
        psd_AllBeta(fileIndex,condition,:)=psd_b(condition,:);
        conditionsAll(fileIndex,condition)=cond(1,condition); 
        
        % martix with the conditions per subject. condition number 999 is a 
        % fake trial as is used to exclude zeroes from the
        % powerspectraldensity analysis. 

end

end




