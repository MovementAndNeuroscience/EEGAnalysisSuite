%% SCRIPT FOR ERP ANALYSIS P3 AND MMN: OUTPUTS AMPLITUDES FOR STANDARD AND ODDBALL AND LATENCIES
%TO RUN THIS SCRIPT EEGLAB NEEDS TO BE ON PATH
% THEN PRESS GREEN RUN BUTTON IN EDITOR OR WRITE ERP_amplitudes in the
% command window and press enter

%NOTE MMN should be at different electrodes


% addpath('C:\\eeglab2019_1')
eeglab
close
%%
filename_save=inputdlg('Filename to save under');
f=msgbox('Choose standard dataset');
waitfor(f);
[f1,path1]=uigetfile('*.set');

EEG_s = pop_loadset('filename',f1,'filepath',path1);
%%
f=msgbox('Choose oddball dataset');
waitfor(f);
[f2,path2]=uigetfile('*.set');

EEG_o = pop_loadset('filename',f2,'filepath',path2);
%%
%both interested in topographical and peak. Choose and plot channels of
%interest to determine peak latency
electrodes_of_interest=[32 31 20 57 30]; %surrounding pz
s_data=EEG_s.data(electrodes_of_interest,:,:);
s_data_mean=mean(s_data,3); %mean over epochs
o_data=EEG_o.data(electrodes_of_interest,:,:);
o_data_mean=mean(o_data,3);
s_mean=mean(s_data_mean,1);
o_mean=mean(o_data_mean,1);
time_axis=EEG_o.times;
%%
%find peak for windows
time1=round(time_axis);
start_p3=find(time1==301);
end_p3=length(time1);
amp_p3_oddball=max(o_mean(start_p3:end_p3));
index_p3_oddball=find(o_mean==amp_p3_oddball);
latency_p3_oddball=time_axis(index_p3_oddball); %ms

amp_p3_standard=s_mean(index_p3_oddball);

% for MMN
mmn_start=find(time1==102);
mmn_stop=find(time1==250);
mmn_oddball=min(o_mean(mmn_start:mmn_stop));
index_mmn=find(o_mean==mmn_oddball);
latency_mmn=time_axis(index_mmn);
mmn_standard=s_mean(index_mmn);
%%
figure; plot(time_axis,mean(s_data_mean,1),'LineWidth',2);
hold on; plot(time_axis,mean(o_data_mean,1),'LineWidth',2)
vline([latency_mmn latency_p3_oddball],'k--')
legend({'standard','oddball'}, 'Location','northwest')
xlim([-100 600])
xlabel('Time'); ylabel('MicroV')
box off
saveas(gcf, filename_save{:},'pdf')

%%
%order of output is (1)P3 oddball amplitude (2)p3 standard amplitude (3)p3
%latency (4)mismatch negativity oddball amplitude (5)mmn standard amplitude (6)mmn latency
results=[amp_p3_oddball amp_p3_standard latency_p3_oddball...
    mmn_oddball mmn_standard latency_mmn];
disp(results)
%% check that we chose the right electrodes
figure;
subplot(2,1,1)
pop_topoplot(EEG_o, 1, latency_p3_oddball,'oddball trials ',[1 1] ,0,'electrodes','on');
subplot(2,1,2)
pop_topoplot(EEG_s, 1, latency_p3_oddball,'standard trials',[1 1] ,0,'electrodes','on');
saveas(gcf, [filename_save{:}, '_topoplots'],'pdf')
%% for mean of whole oddball period of interest (less 'biased')
dat_odd=mean(EEG_o.data(:, start_p3:end_p3,:),3);
dat_stand=mean(EEG_s.data(:, start_p3:end_p3,:),3);
%%
figure; 
subplot(2,1,1)
topoplot(mean(dat_odd,2), EEG_s.chanlocs);colorbar
title('Oddball mean amplitude 300-600 ms')
subplot(2,1,2)
topoplot(mean(dat_stand,2), EEG_s.chanlocs); colorbar
title('Standard mean amplitude 300-600 ms')
saveas(gcf, [filename_save{:}, '_whole_interval_topoplots'],'pdf')

