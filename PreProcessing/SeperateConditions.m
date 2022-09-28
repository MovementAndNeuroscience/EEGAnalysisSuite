% Clear memory and the command window
    clear;
    clc;    

%% Specify information for conditions
filepathForEpochedFiles = 'D:\\ArtInHosp\\EEGLAB_Ready\\processed\\NoBadCh\\ica\\Cleaned\\epoched';
filepathForConditionSeperatedFiles = 'D:\\ArtInHosp\\EEGLAB_Ready\\processed\\NoBadCh\\ica\\Cleaned\\epoched\\AbsFig'; 

conditionOne = '_Abstract';
conditionOneTriggers = [1 10 11:19 2 20 3 4:9];

conditionTwo = '_Figurative';
condtionTwoTriggers = [21:40];

    % Go into that folder and look for all.set files
    files = dir ('*.set'); 
    
    % Loop through all files
    for n = 1:length(files)

        fprintf('\n******\nProcessing data %s\n******\n\n');
        fprintf(files(n).name);
        
            %% Load Data
            % Load original dataset
            %
            fprintf('\n\n\n**** %s: Splitting dataset ****\n\n\n');
            fprintf(files(n).name);
            EEG = pop_loadset('filename', [files(n).name], 'filepath', filepathForEpochedFiles);
            
            %% Split Epoched Data
            ExtractAndSaveConditionTriggers(EEG, conditionOneTriggers, conditionOne, filepathForConditionSeperatedFiles);

            EEG = ALLEEG(n);
            ExtractAndSaveConditionTriggers(EEG, condtionTwoTriggers, conditionTwo, filepathForConditionSeperatedFiles);
            
            fprintf('\n\n\n**** %s: DONE AND SAVED ****\n\n\n');
           
            fprintf(files(n).name);
    end

function ExtractAndSaveConditionTriggers(EEG, triggers, conditionName, filepathForConditionSeperatedFiles)
EEG = pop_selectevent( EEG, 'type',triggers ,'deleteevents','off','deleteepochs','on','invertepochs','off');
setname = strcat(EEG.setname, conditionName); 
EEG.setname = setname;                  
EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', filepathForConditionSeperatedFiles);
end