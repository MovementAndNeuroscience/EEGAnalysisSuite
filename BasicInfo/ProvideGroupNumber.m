function GroupNumber = ProvideGroupNumber(GroupNumberArray, GroupNumberCriteria, FileName )

    firstletter = FileName(1,1);
    for j= 1:size(GroupNumberCriteria,1)
        if firstletter == GroupNumberCriteria(j) && j == 1
            GroupNumber = GroupNumberArray(j);
        end
        if firstletter == GroupNumberCriteria(j) && j == 2
            GroupNumber = GroupNumberArray(j);
        end
    end
%% For later than 2022B Matlab
%    result = strncmpi(GroupNumberCriteria, firstletter,1);
%    
%    for i=1:size(result)
%        isItTheCondition = result(i);
%        
%        if isItTheCondition == 1
%            GroupNumber = GroupNumberArray(i);
%        end
%
%    end
end 