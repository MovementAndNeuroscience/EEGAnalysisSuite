% EEGLAB 
% Before running this script please open all datasets you would like to
% analyse in EEGLAB
% Additionally ensure that you got the table IAFWithFiles loaded into
% matlab we will use it to get access to individual frequency bands. 
% ------------------------------------------------
    pathForConditionsToAnalyze = ['C:\Users\tvh307\OneDrive - University of Copenhagen\Documents\MovementNeuroscience\ReScale\Nov2023_EEGAnalysisAndDoc\100HzAnalysis\SymIncr\Old'];
    conditionName = 'SymIncr'; 

    SymIncrStart = EEG.xmin*1000;
    SymIncrThetaStart = 3000;
    SymIncrThetaSlut = 3500;
    lowestFrequence = 1; 
    highestFrequence = 48; 
    electrodes = size(EEG.chanlocs,2); % the number of electrodes 
    stiimulusLengthsinMilliSec = EEG.xmax*1000;
    stimulusStartInMilliSec = EEG.xmin*1000;
    winSize = 225;
    thetalow = 4;
    thetahigh = 7;
    alphalow = 8;
    alphahigh = 12;
    betaLow = 13; 
    betaHigh = 32; 
    gammaLow = 33; 
    gammaHigh = 48; 

    % Go into that fOlder and look for all.set files
    files = dir ('*.set');  
    subjects = length(files);
    noComp = 1; 
    locations = EEG.chanlocs;
    % Loop through all files
    for n = 1:subjects

        EEG = pop_loadset('filename',[files(n).name],'filepath',pathForConditionsToAnalyze);
        EEG = eeg_checkset( EEG );
        
        shortname = EEG.setname(1,1:10);
%         for i= 1:height(IAFWithFiles)
%             foundname = IAFWithFiles(i,"FileName");
%             foundname = foundname.FileName(1:10); 
%             if foundname == shortname
%                 thetalow = IAFWithFiles.LowTheta(i);
%                 thetahigh = IAFWithFiles.HighTheta(i);
%                 alphalow = IAFWithFiles.LowAplha(i);
%                 alphahigh = IAFWithFiles.HighAlpha(i);
%                 betaLow = IAFWithFiles.LowBeta(i);
%                 betaHigh = IAFWithFiles.HighBeta(i);
%                 gammaLow = IAFWithFiles.LowGamma(i);
%                 gammaHigh = IAFWithFiles.HighGamma(i); 
%             end
%         end


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
            
%             [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[2 0.8],  'SymIncr',[SymIncrThetaStart SymIncrThetaSlut], 'alpha',0.05, 'title', newTitle, 'winsize', winSize, 'freqs',[thetalow thetahigh]);
%              for i=1:length(tempERSPStat(1,:))
%                 ERSPstat_SymIncr_Theta_Old(n,e,i) = mean(tempERSPStat(:,i));
%                 itcstat_SymIncr_Theta_Old(n,e,i) = mean(tempITCstat(:,i));
%              end
% 
%              [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[2 0.8],  'SymIncr',[SymIncrStart 0], 'alpha',0.05, 'title', newTitle, 'winsize', winSize, 'freqs',[alphalow alphahigh]);
%              for i=1:length(tempERSPStat(1,:))
%                 ERSPstat_SymIncr_Alpha_Old(n,e,i) = mean(tempERSPStat(:,i));
%                 itcstat_SymIncr_Alpha_Old(n,e,i) = mean(tempITCstat(:,i));
%              end
% 
%              [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[3 0.8],  'SymIncr',[SymIncrStart 0], 'alpha',0.05, 'title', newTitle, 'winsize', winSize, 'freqs',[betaLow betaHigh]);
%              for i=1:length(tempERSPStat(1,:))
%                 ERSPstat_SymIncr_Beta_Old(n,e,i) = mean(tempERSPStat(:,i));
%                 itcstat_SymIncr_Beta_Old(n,e,i) = mean(tempITCstat(:,i));
%              end
% 
%              [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[3 0.8],  'SymIncr',[SymIncrStart 0], 'alpha',0.05, 'title', newTitle, 'winsize', winSize, 'freqs',[gammaLow gammaHigh]);
%              for i=1:length(tempERSPStat(1,:))
%                 ERSPstat_SymIncr_Gamma_Old(n,e,i) = mean(tempERSPStat(:,i));
%                 itcstat_SymIncr_Gamma_Old(n,e,i) = mean(tempITCstat(:,i));
%              end
            
            %without bootstrap comparisson. 

            [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[2 0.8],  'baseline',[SymIncrThetaStart SymIncrThetaSlut], 'title', newTitle, 'winsize', winSize, 'freqs',[thetalow thetahigh]);
             parfor i=1:length(tempERSPStat(1,:))
                ERSP_SymIncr_Theta_Old(n,e,i) = mean(tempERSPStat(:,i));
                %itc_SymIncr_Theta_Old(n,e,i) = mean(tempITCstat(:,i));
             end

             [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[2 0.8],  'baseline',[SymIncrStart 0], 'title', newTitle, 'winsize', winSize, 'freqs',[alphalow alphahigh]);
             parfor i=1:length(tempERSPStat(1,:))
                ERSP_SymIncr_Alpha_Old(n,e,i) = mean(tempERSPStat(:,i));
                %itc_SymIncr_Alpha_Old(n,e,i) = mean(tempITCstat(:,i));
             end

             [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[3 0.8],  'baseline',[SymIncrStart 0], 'title', newTitle, 'winsize', winSize, 'freqs',[betaLow betaHigh]);
             parfor i=1:length(tempERSPStat(1,:))
                ERSP_SymIncr_Beta_Old(n,e,i) = mean(tempERSPStat(:,i));
                %itc_SymIncr_Beta_Old(n,e,i) = mean(tempITCstat(:,i));
             end

             [tempERSPStat, tempITCstat,powbase,times,freqs,erspboot,itcboot] = newtimef( EEG.data(e,:,:), EEG.pnts, [stimulusStartInMilliSec  stiimulusLengthsinMilliSec], EEG.srate, 'cycles',[3 0.8],  'baseline',[SymIncrStart 0], 'title', newTitle, 'winsize', winSize, 'freqs',[gammaLow gammaHigh]);
             parfor i=1:length(tempERSPStat(1,:))
                ERSP_SymIncr_Gamma_Old(n,e,i) = mean(tempERSPStat(:,i));
                %itc_SymIncr_Gamma_Old(n,e,i) = mean(tempITCstat(:,i));
             end
                 
            sub = num2str(noComp);
             
            NameOfSecondFile = 'Sub';
            NameOfSecondFile = strcat(NameOfSecondFile,shortname);
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

    yDim = 200; 
    electrodes = 64;
    averageERSP = 1;
    averageERSPStat = 1; 
    stdERSP = 1; 
    stdERSPStat = 1; 
    
    parfor e = 1:electrodes 
            for y = 1:yDim
                avrERSP_Theta_Baseline_Young(e,y) = mean(ERSP_Baseline_Theta_Young(:,e,y));
                stdERSP_Theta_Baseline_Young(e,y) = std(ERSP_Baseline_Theta_Young(:,e,y));

                avrERSP_Alpha_Baseline_Young(e,y) = mean(ERSP_Baseline_Alpha_Young(:,e,y));
                stdERSP_Alpha_Baseline_Young(e,y) = std(ERSP_Baseline_Alpha_Young(:,e,y));

                avrERSP_Beta_Baseline_Young(e,y) = mean(ERSP_Baseline_Beta_Young(:,e,y));
                stdERSP_Beta_Baseline_Young(e,y) = std(ERSP_Baseline_Beta_Young(:,e,y));

                avrERSP_Gamma_Baseline_Young(e,y) = mean(ERSP_Baseline_Gamma_Young(:,e,y));
                stdERSP_Gamma_Baseline_Young(e,y) = std(ERSP_Baseline_Gamma_Young(:,e,y));
            end
    end
        parfor e = 1:electrodes 
                avr_Theta_Baseline_Young(e) = mean(avrERSP_Theta_Baseline_Young(e,:));
                std_Theta_Baseline_Young(e) = std(stdERSP_Theta_Baseline_Young(e,:));

                avr_Alpha_Baseline_Young(e) = mean(avrERSP_Alpha_Baseline_Young(e,:));
                std_Alpha_Baseline_Young(e) = std(stdERSP_Alpha_Baseline_Young(e,:));

                avr_Beta_Baseline_Young(e) = mean(avrERSP_Beta_Baseline_Young(e,:));
                std_Beta_Baseline_Young(e) = std(stdERSP_Beta_Baseline_Young(e,:));

                avr_Gamma_Baseline_Young(e) = mean(avrERSP_Gamma_Baseline_Young(e,:));
                std_Gamma_Baseline_Young(e) = std(stdERSP_Gamma_Baseline_Young(e,:));
        end
%%
    %createTSEmapsOneCondition(EEG,locations, averageERSP, stdERSP,xDim,yDim)
    
    