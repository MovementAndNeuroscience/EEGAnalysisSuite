% EEGLAB 
% Before running this script please open all datasets you would like to
% analyse in EEGLAB
% ------------------------------------------------
    pathForConditionsToAnalyze = ['C:\Users\tvh307\OneDrive - University of Copenhagen\Documents\MovementNeuroscience\ReScale\Nov2023_EEGAnalysisAndDoc\ForAnalysis\Baseline\Old'];
    conditionName = 'Baseline'; 

    baselineStart = EEG.xmin*1000;
    lowestFrequence = 1; 
    highestFrequence = 48; 
    electrodes = size(EEG.chanlocs,2); % the number of electrodes 
    stiimulusLengthsinMilliSec = EEG.xmax*1000;
    stimulusStartInMilliSec = EEG.xmin*1000;
    winSize = 225;

    % Go into that folder and look for all.set files
    files = dir ('*.set');  
    subjects = length(files);
    noComp = 1; 
    locations = EEG.chanlocs;
    % Loop through all files
    for n = 1:subjects


EEG = pop_loadset('filename',[files(n).name],'filepath',pathForConditionsToAnalyze);
EEG = eeg_checkset( EEG );

for e = 1:electrodes  %the number of electrodes  
    electrodeInfo = locations(1,e);
    %No. of electrodes
%collecting all the ERPS data from each subject and each electrode in ersp
%in the difErsp the difference maps are stored, be aware that the difErsp
%are cells and that it is the third matrix in the cell that is the
%comparrisson. 0
    figure; 
    newTitle = electrodeInfo.labels; 
    newTitle = strcat(newTitle,conditionName);
    [ERSPstat_Baseline_Old(n,e,:,:),itcstat_Baseline_Old(n,e,:,:),powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[3 0.8],  'baseline',[baselineStart 0], 'alpha',0.05, 'title', newTitle, 'winsize', winSize);
    
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
    
    [ERSP_Baseline_Old(n,e,:,:),itc_Baseline_Old(n,e,:,:),powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec stiimulusLengthsinMilliSec], EEG.srate, [3 0.5],  'baseline',[baselineStart 0], 'title', newTitle, 'winsize', winSize);
            pop_newtimef( EEG, 1, e, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], [3 0.5] , 'topovec', 2, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', electrodeInfo.labels, 'baseline',[baselineStart 0], 'plotphase', 'off', 'padratio', 1, 'winsize', winSize);
    sub = num2str(noComp);
     
    NameOfSecondFile = 'Sub';
    NameOfSecondFile = strcat(NameOfSecondFile,sub);
    NameOfSecondFile = strcat(NameOfSecondFile,'Electrode');
    NameOfSecondFile = strcat(NameOfSecondFile,electrodeInfo.labels);
    NameOfSecondFile = strcat(NameOfSecondFile,conditionName);
    NameOfSecondFile = strcat(NameOfSecondFile,'NoAlpha');
    NameOfSecondFile = strcat(NameOfSecondFile,'.fig');
    
    saveas(gcf,NameOfSecondFile)
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
    xDim = 82;
    yDim = 200; 
    
    averageERSP = 1;
    averageERSPStat = 1; 
    stdERSP = 1; 
    stdERSPStat = 1; 
    
    for e = 1:electrodes 
        for x = 1:xDim
            for y = 1:yDim
        averageERSP_Baseline_Old(e,x,y) = mean(ERSP_Baseline_Old(:,e,x,y));
        averageERSPStat_Baseline_Old(e,x,y) = mean(ERSPstat_Baseline_Old(:,e,x,y)); 
        stdERSP_Baseline_Old(e,x,y) = std(ERSP_Baseline_Old(:,e,x,y));
        stdERSPStat_Baseline_Old(e,x,y) = std(ERSPstat_Baseline_Old(:,e,x,y));
        averageITC_Baseline_Old(e,x,y) = mean(itc_Baseline_Old(:,e,x,y));
        averageITCStat_Baseline_Old(e,x,y) = mean(itcstat_Baseline_Old(:,e,x,y)); 
        stdITC_Baseline_Old(e,x,y) = std(itc_Baseline_Old(:,e,x,y));
        stdITCStat_Baseline_Old(e,x,y) = std(itcstat_Baseline_Old(:,e,x,y)); 
            end
        end
    end
%%
    createTSEmapsOneCondition(EEG,locations, averageERSP, stdERSP,xDim,yDim)
    
    