%configure
clear all; 
expt = {}; 
for idx = 1:10
    num = 2621+idx; 
    expt{idx} = num2str(num); 
end
% expt = {
%     '2622';
%     '2623';
%     '2624';
%     '2625';
%     '2626';
%     '2627';
%     '2628';
%     }; % cell array of strings containing expt IDs
parentDir = ...
    '/Volumes/KATIELAB1/Behavior_Videos_JAABA/First_10_Behavior_Movies/';
newExptDir = ...
    strcat(parentDir, expt);
save('configFile'); 