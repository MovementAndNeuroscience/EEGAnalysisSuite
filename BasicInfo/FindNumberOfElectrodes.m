function electrodes = FindNumberOfElectrodes(files, filepath, EEGLabPath)

    addpath(genpath(EEGLabPath)); % change the filepath for your eeglab
    EEG = pop_loadset('filename',files(1).name,'filepath',filepath);
    electrodes = size(EEG.chanlocs,2); 

end 