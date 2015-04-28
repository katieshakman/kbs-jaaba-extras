%configure
clear all; 
expt = {}; 
list = [1];
for idx = 1:length(list)
    num = 2705+list(idx); 
    expt{idx} = num2str(num); 
end
% expt = {
%     '2622';
%     '2623';
%     '2624';
%     }; % cell array of strings containing expt IDs
% Insert parent directory, ending with a /. 
parentDir = ...
    '/Volumes/KATIELAB1/Behavior_Videos_JAABA/Rest of Old Behavior Videos/';
newExptDir = ...
    strcat(parentDir, expt);
save('configFile'); 