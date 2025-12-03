function [stdError] = stdErrorKnownStd(stdArray,population)
%STDERRORKNOWNSTD Summary of this function goes here
%   Detailed explanation goes here
     for point = 1:length(stdArray(1,:))
            stdError(point) = abs(mean(stdArray(:,point))/sqrt(population)); 
     end
end

