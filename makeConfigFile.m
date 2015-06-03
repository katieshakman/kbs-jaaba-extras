% configure files containing lists of experiments and grouping
clear all;  
startNum = 2621; % startNum = first-1.
list = [1:(2662-2621)]'; % 1:(last-(first-1)), i.e. 1:(last-startNum)
% set a rule for which expts to put in non-control group
% My rule: 'experiment #-ruleOffset' modulo 'rule' = 0 --> familiar group
rule = 4; ruleOffset = 2;
% make the list of experiments
expt = cell(size(list)); % preallocate memory for cell array
for idx = 1:length(list)
    num = startNum + list(idx); 
    expt{idx,1} = num2str(num); 
end
saveDir = '/Volumes/KATIELAB1/Behavior_Videos_JAABA';
parentDir = ...
    '/Volumes/KATIELAB1/Behavior_Videos_JAABA/Rest_of_Old_Behavior_Videos/';
suffix = '_land';
newExptDir = ...
    strcat(parentDir, expt);
dateTime = datestr(now); 
saveName = strcat(saveDir,'/','configFile_',dateTime(1:end-6));
save(saveName); 
% write to text files: 
fileID = fopen(strcat(saveName,'.txt'),'w');
plotFileID = fopen(strcat(saveName,'_Plot.txt'),'w');
prepFileID = fopen(strcat(saveName,'_Prep.txt'),'w');
formatSpec = '%s \n'; 
[nrows,ncols] = size(expt);
% write each line from a row of 'expt'
for row = 1:nrows
    writeLine = ...
        strcat(parentDir,expt{row,:},suffix,'/');
    % old version: 
%      writeLine = ...
%         strcat(parentDir,expt{row,:},'/',expt{row,:},suffix);
    if mod((str2double(expt{row,1})-ruleOffset),rule) == 0
        writeLinePlot = strcat(writeLine,',familiar,0000ff');
    else
        writeLinePlot = strcat(writeLine,',control,000000');
    end
    writeLinePrep = ...
        writeLine;
    fprintf(fileID,formatSpec,writeLine);
    fprintf(plotFileID,formatSpec,writeLinePlot);
    fprintf(prepFileID,formatSpec,writeLinePrep);
end
fclose(fileID);
fclose(plotFileID);
fclose(prepFileID);