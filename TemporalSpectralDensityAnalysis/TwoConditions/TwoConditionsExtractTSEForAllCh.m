% EEGLAB 
% Before running this script please open all datasets you would like to
% analyse in EEGLAB
% ------------------------------------------------
    pathForConditionsToAnalyze = 'D:\\ArtInHosp\\EEGLAB_Ready\\processed\\NoBadCh\\ica\\Cleaned\\epoched\\AbsFig\\';
    conditionTwoName = 'Fig'; 
    conditionOneName = 'Abs'; 

    baselineLengthsMinusMilliSec = -5000;
    lowestFrequence = 0.5; 
    highestFrequence = 50; 

    % Go into that folder and look for all.set files
    files = dir ('*.set'); 
    noComp = 1; 
    locations = EEG.chanlocs;
    % Loop through all files
    for n = 1:length(files)

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_loadset('filename',[files(n).name],'filepath',pathForConditionsToAnalyze);
EEG = eeg_checkset( EEG );

for e = 1:size(EEG.chanlocs,2)  %the number of electrodes  
    electrodeInfo = locations(1,e);

    %collecting all the ERPS data from each subject and each electrode in ersp
    %in the difErsp the difference maps are stored, be aware that the difErsp
    %are cells and that it is the third matrix in the cell that is the
    %comparrisson. 

    figure; 
    nameOfFile = electrodeInfo.labels; 
    m = n+1;
    if mod(m,2) == 0
        newTitle = strcat(nameOfFile,conditionTwoName);
    else
        newTitle = strcat(nameOfFile,conditionOneName);
    end

    [erspStat(n,e,:,:),itc,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 0.5],  'baseline',[baselineLengthsMinusMilliSec - 0], 'alpha',0.05, 'freqs', [lowestFrequence highestFrequence], 'title', newTitle);
    
    sub = num2str(noComp);
    
    nameOfFile = 'Sub';
    nameOfFile = strcat(nameOfFile,sub);
    nameOfFile = strcat(nameOfFile,'Electrode');
    nameOfFile = strcat(nameOfFile,electrodeInfo.labels);
   
    if mod(m,2) == 0
        nameOfFile = strcat(nameOfFile,conditionTwoName);
    else
        nameOfFile = strcat(nameOfFile,conditionOneName);
    end
    nameOfFile = strcat(nameOfFile,'Alpha=0.05');
    nameOfFile = strcat(nameOfFile,'.fig');
    
    saveas(gcf,nameOfFile)
     close 
    
    %without bootstrap comparisson. 
    
    [ersp(n,e,:,:),itc,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 0.5],  'baseline',[baselineLengthsMinusMilliSec - 0], 'freqs', [lowestFrequence highestFrequence], 'title', newTitle);
            pop_newtimef( EEG, e, 2, [-5000 39996], [3 0.5] , 'topovec', 2, 'elocs', EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', electrodeInfo.labels, 'baseline',[baselineLengthsMinusMilliSec - 0], 'freqs', [lowestFrequence highestFrequence], 'plotphase', 'off', 'padratio', 1);

    sub = num2str(noComp);
    
    nameOfFile = 'Sub';
    nameOfFile = strcat(nameOfFile,sub);
    nameOfFile = strcat(nameOfFile,'Electrode');
    nameOfFile = strcat(nameOfFile,electrodeInfo.labels);
  
    if mod(m,2) == 0
        nameOfFile = strcat(nameOfFile,conditionTwoName);
    else
        nameOfFile = strcat(nameOfFile,conditionOneName);
    end
    nameOfFile = strcat(nameOfFile,'NoAlpha');
    nameOfFile = strcat(nameOfFile,'.fig');
    
    saveas(gcf,nameOfFile)
    close all
    
    % we would only like to compare the outputs if the current dataset is
    % ConditionOne, so the order of compasson is the same. 
    if(n+1 <= length(files))
        if mod(m,2) == 0
        figure; 
        [difErsp{noComp,e},itc2,powbase2,times2,freqs2,erspboot2,itcboot2] = newtimef( {ALLEEG(n).data(1,:,:) ALLEEG(n+1).data(1,:,:)}, EEG.pnts, [EEG.xmin EEG.xmax]*1000, EEG.srate, [3 0.5],  'baseline',[baselineLengthsMinusMilliSec - 0], 'alpha',0.05, 'freqs', [lowestFrequence highestFrequence]);
        
        sub = num2str(noComp);
    
    nameOfFile = 'Comp';
    nameOfFile = strcat(nameOfFile,sub);
    nameOfFile = strcat(nameOfFile,'Electrode');
    nameOfFile = strcat(nameOfFile,electrodeInfo.labels);
    nameOfFile = strcat(nameOfFile,'ComparedConditionOneWithConditionTwo');
    nameOfFile = strcat(nameOfFile,'.fig');
    saveas(gcf,nameOfFile)
        close all
        end
    end

end

if(mod(m,2) == 0)
    noComp = noComp + 1; 
end
    end
    %%
    % The following analysis will give the following. 
    % a matrix with averages for ConditionTwo, ConditionOne and comparissons one
    % for each electrodes. 
    % Matrices for the variance found at the different pixel areas, for all
    % three types of maps and for all electrodes. 
    %Wilcoxon ranged sum test will be performed to compare Abs TSE maps
    %with Fig TSE maps to elucidate significant differences between them. 
    
    %ersp(session abs (odd) or fig (even),electrode,x(793),y(200))
    %difErsp{subject,electrode}{1,3}(x(793),y(200))
    % 
    sessions = length(files);
    comparissons = sessions/2; 
    electrodes = 20; % the number of electrodes 
    xPos = 793;
    yPos = 200; 
    
    conditionOneERSP = 1;
    conditionOneERSPStat = 1;
    conditionTwoERSP = 1;
    conditionTwoERSPStat = 1;
    
    averageERSPconditionTwo = 1;
    averageERSPconditionOne = 1;
    averageERSPconditionTwoStat = 1; 
    averageERSPconditionOneStat = 1; 
    
    stdERSPconditionTwo = 1; 
    stdERSPconditionOne = 1; 
    stdERSPconditionTwoStat = 1; 
    stdERSPconditionOneStat = 1; 
    
    for s = 1:sessions
        
        for e = 1:electrodes
            for x = 1:xPos
                for y = 1:yPos
                    if mod(s,2) == 1
                            s2 = s*0.5+0.5;
                    conditionOneERSP(s2,e,x,y) = ersp(s,e,x,y);
                    conditionOneERSPStat(s2,e,x,y) = erspStat(s,e,x,y);
                    else
                    conditionTwoERSP(s/2,e,x,y) = ersp(s,e,x,y);
                    conditionTwoERSPStat(s/2,e,x,y) = erspStat(s,e,x,y);
                    end
                end
            end
        end
        
    end
    
    %getting the info out of the cells in the difErsp
    for c = 1:comparissons
        for e = 1:electrodes
            for x = 1:xPos
                for y = yPos
                    
                    noCelldiffERSP(c,e,x,y) = difErsp{c,e}{1,3}(x,y);
                    
                end
            end
        end
    end
    
    for e = 1:electrodes; 
        for x = 1:xPos;
            for y = 1:yPos
        averageERSPconditionTwo(e,x,y) = mean(conditionTwoERSP(:,e,x,y));
        averageERSPconditionTwoStat(e,x,y) = mean(conditionTwoERSPStat(:,e,x,y)); 
        averageERSPconditionOne(e,x,y) = mean(conditionOneERSP(:,e,x,y));
        averageERSPconditionOneStat(e,x,y) = mean(conditionOneERSPStat(:,e,x,y)); 
        
        stdERSPconditionTwo(e,x,y) = std(conditionTwoERSP(:,e,x,y));
        stdERSPconditionTwoStat(e,x,y) = std(conditionTwoERSPStat(:,e,x,y)); 
        stdERSPconditionOne(e,x,y) = std(conditionOneERSP(:,e,x,y));
        stdERSPconditionOneStat(e,x,y) = std(conditionOneERSPStat(:,e,x,y)); 
        
        wilcoxontestERSP(e,x,y) = signrank(conditionTwoERSP(:,e,x,y),conditionOneERSP(:,e,x,y));
        wilcoxontestERSPStat(e,x,y) = signrank(conditionTwoERSPStat(:,e,x,y),conditionOneERSPStat(:,e,x,y));
        
        averageCompERSP(e,x,y) = mean(noCelldiffERSP(:,e,x,y));
        stdCompERSP(e,x,y) = std(noCelldiffERSP(:,e,x,y));
            end
        end
    end

    createTSEmaps (locations, averageERSPconditionOne, averageERSPconditionTwo, stdERSPconditionOne, stdERSPconditionTwo, wilcoxontestERSP)
    
    