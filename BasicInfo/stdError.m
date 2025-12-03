function [stdError] = stdError(data, datapoints)
    for point = 1:datapoints
        stdError(point) = std(data(:,point))/sqrt(size(data,1)); 
    end
end