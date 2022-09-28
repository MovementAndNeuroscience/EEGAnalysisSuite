% EEGLAB history file generated on the 31-Mar-2018
% ------------------------------------------------
%loading g.tec files, extracting triggers, adding location and extracting
%unwanted channels. 

files = dir('*.mat');

    fprintf('preparing gtec files by adding the locations : ');
    for n = 1:length(files)
        fprintf(files(n).name);
        %loading G.tec files - specify trigger channel 
EEG = pop_read_gtec(ALLEEG,files(n).name);
setname = strcat('EL_',EEG.setname); 
EEG.setname=setname;
EEG = eeg_checkset( EEG );
% cutting away all channels not EEG related 
EEG = pop_select( EEG,'channel',2:21 );
EEG = eeg_checkset( EEG );
% adding channel name from .xyz file.
EEG = pop_read_gtecposition(EEG,'ArtInHsopMontageEEGlab.xyz' );
setnameLoc = strcat(setname,'_loc');
filename = strcat(setnameLoc,'.set');
%saving the new file with trigger and location infomation.
EEG = pop_saveset( EEG, 'filename',filename,'filepath','E:\\AAU\\FALL 2017\\BARCELONA\\TS\\raw\\');
EEG.setname=setnameLoc;
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
    end
