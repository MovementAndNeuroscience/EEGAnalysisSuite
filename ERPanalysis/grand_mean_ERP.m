%% average ERP waveform over all subjects for standard and oddball

filename_save=inputdlg('Filename to save mean waveforms under');

f=msgbox('Choose *standard* datasets to average (press ctrl to select multiple files). They need to be in same folder!');
waitfor(f);
[f1,path1]=uigetfile('*.set','Multiselect','on');
%%
EEGs=zeros(64,180,length(f1));
for j=1:length(f1)
EEGdat_s = pop_loadset('filename',f1{j},'filepath',path1);
meanoverepochs=mean(EEGdat_s.data,3);
EEGs(:,:,j)=meanoverepochs;
end
%%
meanoversubjectsS=mean(EEGs,3); %now we have mean all chans all subjects
electrodes_of_interest=[32 31 20 57 30]; %surrounding pz
meanoverelectrodesS=meanoversubjectsS(electrodes_of_interest,:);
grand_mean_S=mean(meanoverelectrodesS,1);

%%
f=msgbox('Choose *oddball* datasets to average (press ctrl to select multiple files). They need to be in same folder!');
waitfor(f);
[f2,path2]=uigetfile('*.set','Multiselect','on');

EEGo=zeros(64,180,length(f2));
for j=1:length(f2)
EEGdato = pop_loadset('filename',f2{j},'filepath',path2);
meanoverepochs_o=mean(EEGdato.data,3);
EEGo(:,:,j)=meanoverepochs_o;
end

meanoversubjectsO=mean(EEGo,3); %now we have mean all chans all subjects
% electrodes_of_interest=[32 31 20 57 30]; %surrounding pz
meanoverelectrodesO=meanoversubjectsO(electrodes_of_interest,:);
grand_mean_O=mean(meanoverelectrodesO,1);
%%
figure; plot(EEGdat_s.times, grand_mean_S,'LineWidth',2); hold on
plot(EEGdato.times, grand_mean_O,'LineWidth',2)
xlabel('Time relative to stimulus (ms)')
ylabel('EEG (microV)')
title('Grand mean over participants')
box off
legend({'Standard','Oddball'}, 'Location','northwest')
xlim([-100 600])

%%
saveas(gcf, filename_save{:},'pdf')

