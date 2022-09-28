% Clear memory and the command window
    clear;
    clc;

    % Go into that folder and look for all.set files
    files = dir ('*.set'); 
    
    %filtering bandpass 0.5 - 100Hz divided into a highpass and a
    %lowpass for the sake controlability. 
    lowestHz = 0.5;
    highestHz = 100; 

    % Select only triggers of interest
    % Write in seconds how long baseline is (minus seconds)
    % Write in seconds how long the stimuli is (or how long a measure you want to investigate)
    triggerNames = {'1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24' '25' '26' '27' '28' '29' '30' '31' '32' '33' '34' '35' '36' '37' '38' '39' '40'};
    baselinelength = -5; 
    stimuluslengths = 40;

    pathForInputFiles = 'D:\\ArtInHosp\\EEGLAB_Ready'; 
    pathForFilteredFiles =  'D:\\ArtInHosp\\EEGLAB_Ready\\processed'; 

    % Loop through all files
    for n = 1:length(files)

        fprintf('\n******\nProcessing data %s\n******\n\n');
        fprintf(files(n).name);
        
            %% Load Data
            % Load original dataset
            % please be in the location of the loaded dataset
            fprintf('\n\n\n**** %s: Loading dataset ****\n\n\n');
            fprintf(files(n).name);
            % please change the path to where you have your files 
            EEG = pop_loadset('filename', [files(n).name], 'filepath', pathForInputFiles);
            
            setname = EEG.setname; 
            fprintf('\n\n\n**** %s: Filtering Respondent ****\n\n\n');

            EEG = pop_eegfiltnew(EEG, lowestHz, 0);
            EEG = pop_eegfiltnew(EEG, 0, HighestHz);
            
            %notch filter - notching out electrical interference 
            EEG = pop_eegfiltnew(EEG, 48, 52, 424, 1,[],0);

            EEG = pop_rmdat( EEG, triggerNames,[baselinelength stimuluslengths] ,0);
            setname = strcat (setname,'_filtered'); 
            EEG.setname= setname;
            % please change the output folder to the right one      
            EEG = pop_saveset(EEG, 'filename', [EEG.setname '.set'], 'filepath', pathForFilteredFiles);
            fprintf('\n\n\n**** %s: DONE AND SAVED ****\n\n\n');
            fprintf(files(n).name);
    end
