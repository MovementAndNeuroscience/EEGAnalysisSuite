function maxConditions = FindMaxNumberOfConditions(files, filepath, EEGLabPath)
maxConditions = 0; 
    for fileIndex=1:size(files,1)
   
    addpath(genpath(EEGLabPath)); % change the filepath for your eeglab
    EEG = pop_loadset('filename',files(fileIndex).name,'filepath',filepath);
        if EEG.trials > maxConditions
            maxConditions = EEG.trials; 
        end
    end
end 