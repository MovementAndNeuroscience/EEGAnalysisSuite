% montage2eeglab
% INPUT: montage - gtec Montage used for measuring the positions
% positionMatrix - measured postions in format (channels x 3 for x,y,z)
% filename - filename to store the converted positions

function NewMon2EEGlab(montage,filename)
    % load information from montage-set
    % check montage to be of montage type
   
    channels = montage.electrodenumber;
    numChannels = size(channels, 2);
    nameChannels = montage.electrodename;
    xPosition = montage.xposition;
    yPosition = montage.yposition;
    zPosition = montage.zposition;
    
    % sort channels, channelnames (ascending channels)
    [channels, index] = sort(channels);
    nameChannels = nameChannels(index);
    xPosition = xPosition(index);
    yPosition = yPosition(index);
    zPosition = zPosition(index);

    file = fopen(filename,'w');
    for i=1:numChannels
        fprintf('%d %.4f %.4f %.4f %s\n',i,xPosition(i),yPosition(i),zPosition(i),nameChannels{i});
        fprintf(file,'%d %.4f %.4f %.4f %s\n',i,xPosition(i),yPosition(i),zPosition(i),nameChannels{i});
    end
    fclose(file);
end