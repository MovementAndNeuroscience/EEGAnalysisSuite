%This script is a function used to normalize baseline subtracted ERSP data 
function [normalizedData] = Normalize (baseline, data3D)
    for subject = 1:length(data3D(:,1,1))
        for electrode=1:length(data3D(1,:,1))
            for time=1:length(data3D(1,1,:))
                normalizedData(subject, electrode,time) = (data3D(subject, electrode, time)- baseline) / baseline;
            end
        end
    end
end