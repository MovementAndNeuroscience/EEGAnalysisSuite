% This function provides you with the mean power based on a certain
% frequency, certain range of electrodes and specific conditions. 
% First it looks at the epoch and determines whether or not it is of
% interest. If so we calculate the mean power spectrum desnity for specific
% electrodes 
% Lastly we cluster the elctrodes (means of means), so we have a mean power
% spectral density for the cluster of electrodes, related to the condition
% we are interested in, in relation to the participant at hand. 


function [meanAlphaForConditionAndLocation, meanHighBetaForConditionAndLocation, meanLowBetaForConditionnAndLocation, meanBetaForConditionAndLocation] = MeanPowerBasedOnLocationAndCondition(epochs, electrodesOfInterest, conditionsOfInterest, EEG)

counterIndex = 1; 
fs=EEG.srate;
nfft=fs/2; % PSD has a resolution of 2Hz

    for i=1:size(epochs,2)
        epochCell=epochs(i);
        epoch = cell2mat(epochCell{1}(1)); 

        if any(conditionsOfInterest(:) == epoch)

        [pxx,f] = pwelch(squeeze(EEG.data(:,:,i))',hamming(nfft),0,nfft,fs); % PSD is estimated on all the channels
        
            for electrode= 1:size(electrodesOfInterest,2)
            alpha(counterIndex) = mean(pxx(5:7,electrodesOfInterest(1,electrode),1)); % estimation of alpha (8-12 Hz) for single subject 
            lowBeta(counterIndex) = mean(pxx(8:12,electrodesOfInterest(1,electrode),1)); % estimation of low beta (14-22 Hz) for single subject
            highBeta(counterIndex) = mean(pxx(13:17,electrodesOfInterest(1,electrode),1)); % estimation of high beta (24-32 Hz) for single subject
            beta(counterIndex) = mean(pxx(8:17,electrodesOfInterest(1,electrode),1));% estimation of total beta (14-32 Hz) for single subject
            
            counterIndex = counterIndex + 1;
            end
        end
    end

    meanAlphaForConditionAndLocation = mean(alpha);
    meanHighBetaForConditionAndLocation = mean(highBeta);
    meanLowBetaForConditionnAndLocation = mean(lowBeta);
    meanBetaForConditionAndLocation = mean(beta);

end 