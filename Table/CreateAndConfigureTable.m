function Table = CreateAndConfigureTable(NamesOnAllFiles, SubjectGroupArray, conditionmatrix, nameOfFile)
Table = table(NamesOnAllFiles', SubjectGroupArray', conditionmatrix); 
Table = renamevars(Table,["Var1","Var2"],["NameOfFiles","SubjectGroupNr"]);
Table = renamevars(Table,["conditionmatrix"],["mean_PowerBand_Condition"]);
writetable(Table,nameOfFile,'Sheet',1,'Range','A1')
end