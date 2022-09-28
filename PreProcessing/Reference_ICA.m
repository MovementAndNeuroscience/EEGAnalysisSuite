% Clear memory and the command window
    clear;
    clc;

    % Go into that folder and look for all.set files
    files = dir ('*.set'); 

    % remember to change the directory to fit your experiment.
    pathForNoBadChannels = 'D:\\ArtInHosp\\EEGLAB_Ready\\processed\\NoBadCh'; 
    pathForICAAnalyzed = 'D:\ArtInHosp\EEGLAB_Ready\processed\NoBadCh\\ica'; 
    
    % Loop through all files
    for n = 1:length(files)

        fprintf('\n******\nProcessing data %s\n******\n\n');
        fprintf(files(n).name);
        
            %% Load Data
            % Load original dataset

            EEG = pop_loadset('filename', [files(n).name], 'filepath', pathForNoBadChannels);
           
            %% re-reference
            EEG = pop_reref( EEG, []);
            
            %% run ica
            EEG = pop_runica(EEG, 'extended',1,'stop',1e-07,'interupt','on');
            %plase rememeber to change directory. 
            EEG.setname = strcat(EEG.setname, '_ICA');   
            
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', pathForICAAnalyzed);
            fprintf('\n\n\n**** %s: DONE AND SAVED ****\n\n\n');
            fprintf(files(n).name);
    end
