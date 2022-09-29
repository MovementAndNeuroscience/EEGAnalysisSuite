% EEGLAB 
% Before running this script please open all datasets you would like to
% analyse in EEGLAB
% ------------------------------------------------
    pathForConditionsToAnalyze = 'D:\\AAU\\Experiments\\Trial\\';
    conditionName = 'A-M+'; 

    baselineLengthsMinusMilliSec = -5000;
    lowestFrequence = 0.5; 
    highestFrequence = 50; 
    electrodes = size(EEG.chanlocs,2); % the number of electrodes 
    stiimulusLengthsinMilliSec = EEG.xmax*1000;
    stimulusStartInMilliSec = EEG.xmin*1000;

    % Go into that folder and look for all.set files
    files = dir ('*.set');  
    subjects = length(files);
    noComp = 1; 
    locations = EEG.chanlocs;
    % Loop through all files
    for n = 1:subjects

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename',[files(n).name],'filepath',pathForConditionsToAnalyze);
EEG = eeg_checkset( EEG );

for e = 1:electrodes  %the number of electrodes  
    electrodeInfo = locations(1,e);
    %No. of electrodes
%collecting all the ERPS data from each subject and each electrode in ersp
%in the difErsp the difference maps are stored, be aware that the difErsp
%are cells and that it is the third matrix in the cell that is the
%comparrisson. 
    figure; 
    newTitle = electrodeInfo.labels; 
    newTitle = strcat(newTitle,conditionName);

    [ERSPstat(n,e,:,:),itc,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec stiimulusLengthsinMilliSec], EEG.srate, [3 0.5],  'baseline',[baselineLengthsMinusMilliSec 0], 'alpha',0.05, 'freqs', [lowestFrequence highestFrequence], 'title', newTitle);
    
    sub = num2str(noComp);
    
    nameOfFile = 'Sub';
    nameOfFile = strcat(nameOfFile,sub);
    nameOfFile = strcat(nameOfFile,'Electrode');
    nameOfFile = strcat(nameOfFile,electrodeInfo.labels);
    nameOfFile = strcat(nameOfFile,conditionName);
    nameOfFile = strcat(nameOfFile,'Alpha=0.05');
    nameOfFile = strcat(nameOfFile,'.fig');
    saveas(gcf,nameOfFile)
     close 
    
    %without bootstrap comparisson. 
    
    [ERSP(n,e,:,:),itc,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec stiimulusLengthsinMilliSec], EEG.srate, [3 0.5],  'baseline',[baselineLengthsMinusMilliSec 0], 'freqs', [lowestFrequence highestFrequence], 'title', newTitle);
            pop_newtimef( EEG, 1, e, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], [3 0.5] , 'topovec', 2, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', electrodeInfo.labels, 'baseline',[baselineLengthsMinusMilliSec 0], 'freqs', [lowestFrequence highestFrequence], 'plotphase', 'off', 'padratio', 1);
    sub = num2str(noComp);
    
    nameOfFile = 'Sub';
    nameOfFile = strcat(nameOfFile,sub);
    nameOfFile = strcat(nameOfFile,'Electrode');
    nameOfFile = strcat(nameOfFile,electrodeInfo.labels);
    nameOfFile = strcat(nameOfFile,conditionName');
    nameOfFile = strcat(nameOfFile,'NoAlpha');
    nameOfFile = strcat(nameOfFile,'.fig');
    
    saveas(gcf,nameOfFile)
    close all

end
    noComp = noComp + 1; 

    end
    %%
    % The following analysis will give the following. 
    % a matrix with averages for Figurative, abstracts and comparissons one
    % for each electrodes. 
    % Matrices for the variance found at the different pixel areas, for all
    % three types of maps and for all electrodes. 
    %Wilcoxon ranged sum test will be performed to compare Abs TSE maps
    %with Fig TSE maps to elucidate significant differences between them. 
    
    %ersp(session abs (odd) or fig (even),electrode,x(793),y(200))
    %difErsp{subject,electrode}{1,3}(x(793),y(200))
    % 
    xDim = 793;
    yDim = 200; 
    
    averageERSP = 1;
    averageERSPStat = 1; 
    stdERSP = 1; 
    stdERSPStat = 1; 
    
    for e = 1:electrodes 
        for x = 1:xDim
            for y = 1:yDim
        averageERSP(e,x,y) = mean(ERSP(:,e,x,y));
        averageERSPStat(e,x,y) = mean(ERSPstat(:,e,x,y)); 
        stdERSP(e,x,y) = std(ERSP(:,e,x,y));
        stdERSPStat(e,x,y) = std(ERSPstat(:,e,x,y)); 
            end
        end
    end

    createTSEmapsOneCondition(EEG,locations, averageERSP, stdERSP,xDim,yDim)
    
    