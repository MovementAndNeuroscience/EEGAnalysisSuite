% This function provides you with the mean power based on a certain
% frequency, certain range of electrodes and specific conditions. 
% First it looks at the epoch and determines whether or not it is of
% interest. If so we calculate the mean power spectrum desnity for specific
% electrodes 
% Lastly we cluster the elctrodes (means of means), so we have a mean power
% spectral density for the cluster of electrodes, related to the condition
% we are interested in, in relation to the participant at hand. 


function [meanAlphaForCondition, meanHighBetaForCondition, meanLowBetaForCondition, meanBetaForCondition] = MeanPowerPerElctrodeBasedOnCondition(epochs, electrodesOfInterest, conditionsOfInterest, EEG)

meanAlphaForCondition = zeros(1,size(electrodesOfInterest,2));
meanHighBetaForCondition = zeros(1,size(electrodesOfInterest,2));
meanLowBetaForCondition = zeros(1,size(electrodesOfInterest,2));
meanBetaForCondition = zeros(1,size(electrodesOfInterest,2));

electrodeCounterIndex = 1; 
acceptedEpochs = 1; 
fs=EEG.srate;
nfft=fs/2; % PSD has a resolution of 2Hz

    for i=1:size(epochs,2)
        epochCell=epochs(i);
        epoch = cell2mat(epochCell{1}(1)); 

        if any(conditionsOfInterest(:) == epoch)

        [pxx,f] = pwelch(squeeze(EEG.data(:,:,i))',hamming(nfft),0,nfft,fs); % PSD is estimated on all the channels
        
            for electrode= 1:size(electrodesOfInterest,2)
            AlphaForCondition(acceptedEpochs,electrodeCounterIndex) = mean(pxx(5:7,electrodesOfInterest(1,electrode),1)); % estimation of alpha (8-12 Hz) for single subject 
            HighBetaForCondition(acceptedEpochs, electrodeCounterIndex) = mean(pxx(8:12,electrodesOfInterest(1,electrode),1)); % estimation of low beta (14-22 Hz) for single subject
            LowBetaForCondition(acceptedEpochs,electrodeCounterIndex) = mean(pxx(13:17,electrodesOfInterest(1,electrode),1)); % estimation of high beta (24-32 Hz) for single subject
            BetaForCondition(acceptedEpochs,electrodeCounterIndex) = mean(pxx(8:17,electrodesOfInterest(1,electrode),1));% estimation of total beta (14-32 Hz) for single subject
            
            electrodeCounterIndex = electrodeCounterIndex + 1;
            end
            acceptedEpochs = acceptedEpochs +1; 
            electrodeCounterIndex = 1; 
        end
    end

    for i=1:size(meanAlphaForCondition,2)
        
        meanAlphaForCondition(1,i) = mean(AlphaForCondition(:,i)); 
        meanHighBetaForCondition(1,i) = mean(HighBetaForCondition(:,i)); 
        meanLowBetaForCondition(1,i) = mean(LowBetaForCondition(:,i)); 
        meanBetaForCondition(1,i) = mean(BetaForCondition(:,i)); 
    
    end

end 
