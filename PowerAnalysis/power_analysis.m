%Script for power analysis
%EEGlab and neurospec package needs to be on path
%To run just click green run button in editor or write power_analysis and
%press enter in command window

% addpath('C:\\eeglab2019_1')
addpath(genpath('\\a00519.science.domain\pfk270\Documents\neurospec20'))

eeglab
close
%%
filename_save=inputdlg('Filename to save under');

f=msgbox('Choose eeg dataset');
waitfor(f);
[f1,path1]=uigetfile('*.set');

EEG = pop_loadset('filename',f1,'filepath',path1);
%%
% f=msgbox('Choose emg dataset');
% waitfor(f);
% [f2,path2]=uigetfile('*.set');
% 
% EMG = pop_loadset('filename',f2,'filepath',path2);
%%
%frontal
e_m1=[13 12]; %around left m1
e_frontal=[5 4]; %left frontal

% emg=EMG.data(1,:);
eeg_m1=EEG.data(e_m1,:);
eeg_frontal=EEG.data(e_frontal,:);
%%
opt_str='t2 n'; %detrend and normalize
[f t cl sc]=sp2a2_m1(0, eeg_m1(1,:)', eeg_m1(2,:)',256, 8,opt_str); %spectrum for two m1 electrodes
[f2 t2 cl2 sc2]=sp2a2_m1(0, eeg_frontal(1,:)', eeg_frontal(2,:)',256, 8,opt_str); %spectrum for two frontal electrodes

%%
sc1=sc(2:end,1:2); %autospectra for the two channels around m1
sc22=sc2(2:end,1:2); %autospectra for two channels around contralateral frontal
freqs=f(:,1);

betafreqI=find(freqs>=15 & freqs<=35); %indices beta band
alphafreqI=find(freqs>=5 & freqs<=15); %indices alpha band

scmean_motor=mean(sc1,2); %column wise mean=mean spectrum for two channels of interest
scmean_frontal=mean(sc22,2);%column wise mean

betapower_motor=log(sum(scmean_motor(betafreqI))); %log area for beta band motor and frontal electrodes
betapower_frontal=log(sum(scmean_frontal(betafreqI)));

alphapower_motor=log(sum(scmean_motor(alphafreqI))); 
alphapower_frontal=log(sum(scmean_frontal(alphafreqI)));

% % [power, freq1] = spectopo(EEG.data, 256, 256);
% betafreq1=find(freq1>=15 & freq1<=35);
% sumbeta=sum(power(:,betafreq1),2);
% figure; topoplot(sumbeta, EEG.chanlocs);

%need to make nice plot and make it save
%also check out how they did local avg in DS study
figure; plot(freqs,scmean_frontal,'LineWidth',2); hold on;
plot(freqs,scmean_motor,'LineWidth',2)
xlim([0 45])
xlabel('Frequency (Hz)')
ylabel('Power (microV^2/Hz)')
legend({'frontal electrodes','motor electrodes'})
box off
saveas(gcf, [filename_save{:},'_power_spectra'],'pdf')

%%
%results printed in following order:
%(1) log avg beta power over m1 electrodes (2) log avg beta power over
%frontal electrodes (3) log avg alpha power over m1 electrodes (4) log avg
%alpha power over frontal electrodes
results=[betapower_motor betapower_frontal alphapower_motor alphapower_frontal];
disp(results)

% %% coherence
%cannot delete data segments!
% opt_str_emg='t2 n r1'; %detrend and normalize and rectify emg
% electrodes=[e_frontal e_m1];
% 
% 
% for kk=1:length(electrodes)
%     electrodek=electrodes(kk);
%     eegchan=EEG.data(electrodek,:);
%     [f3 t3 cl3 sc3]=sp2a2_m1(0, eegchan', emg',256, 8,opt_str_emg);
%     mm=figure; plot(f3(:,1),f3(:,4))
%     xlim([0 45])
%     waitfor(mm)
%     
% end
