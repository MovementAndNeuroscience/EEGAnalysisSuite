function GroupNumber = ProvideGroupNumber(GroupNumberArray, GroupNumberCriteria, FileName )

    firstletter = FileName(1,1);
    result = strncmpi(GroupNumberCriteria, firstletter,1);
    
    for i=1:size(result)
        isItTheCondition = result(i);
        
        if isItTheCondition == 1
            GroupNumber = GroupNumberArray(i);
        end

    end
end 