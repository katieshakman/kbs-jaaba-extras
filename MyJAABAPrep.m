%% My JAABA Prep

% Remember to go to Parallel>Manage Cluster Profiles before 
% attempting to run JAABA 

clear all; close all;

addpath(genpath(...
    '/Users/katherineshakman/Documents/MATLAB/JAABA-master'))
addpath(genpath('/Users/katherineshakman/code/kbs-jaaba-extras'))
addpath(genpath('/Volumes/KATIELAB1/Behavior_Videos_JAABA'))


%% Make directory for each video and copy in files
% % % Get list of videos in current folder
startDir = pwd;
vidsList = dir('266*sbfmf');
if min(size(vidsList)) > 0
    for vid = 1:length(vidsList)
        % Make folder for each video
        exptID = vidsList(vid,1).name(1:4);
        checkDir = strcat(startDir,'/', exptID);
        newDir = checkDir;
        if ~(exist(checkDir, 'dir') == 7) % if no such folder exists
            mkdir(newDir);
            display('directory made');
        else
            display('directory exists already');
        end
        % If there is a "fixed" ann file for the expt, want to use it.
        fixedAnn = strcat('fixed_',exptID,'*.ann');
        if exist(fixedAnn,'file')
            newAnnName = fixedAnn;
        else
            newAnnName = strcat(exptID , '.ann');
            clear fixedAnn;
        end
        % Copy .sbmfm, .ann and .mat files into video folder
        newAnnPath = strcat(newDir, '/' , newAnnName);
        if exist('fixedAnn') == 0
            AnnFiles = dir(strcat(exptID,'*.sbfmf.ann'));
            origAnn = AnnFiles(1,1).name; % if multiple, take first
        end
        if exist(newAnnPath) == 0
            display('.ann does not yet exist in folder');% TODO: REMOVE
            copyfile(origAnn, newAnnPath);
            display('.ann file copied');
        end
        %newMatName = strcat(exptID , '.mat');
        %newMatPath = strcat(newDir, '/' , newMatName);
        MatFiles = dir(strcat('*', exptID,'*.mat'));
        % catch empty files:
        if min(size(MatFiles)) == 0
            display('Problem with files for expt: '); display(exptID);
        else
            origMat = MatFiles(1,1).name; % if multiple, take first
            % If there is a "fixed" mat file for the expt, want to use it.
            fixedMat = strcat('fixed_',exptID,'*.mat');
            if exist(fixedMat)
                newMatName = fixedMat;
            else
                newMatName = origMat; % keep orig .mat filename
            end
            newMatPath = strcat(newDir,'/', newMatName);
            clear fixedMat;
            %
            if exist(newMatPath) == 0
                display('.mat does not yet exist in folder');% TODO: REMOVE
                copyfile(origMat, newMatPath);
                display('.mat file copied');
            end
            newVidName = strcat(exptID, '.sbfmf');
            newVidPath = strcat(newDir, '/' , newVidName);
            VidFiles = dir(strcat('*', exptID,'*.sbfmf'));
            origVid = VidFiles(1,1).name; % if multiple, take first
            if exist(newVidPath) == 0
                %display('video does not yet exist in folder');% TODO: REMOVE
                copyfile(origVid, newVidPath);
            else
                %display('video already exists in that location');
            end
        end
    end
else
    clear('vidsList')
end

addpath(genpath(startDir)); % make sure all new folders are on path
display('Process finished.');
% matlabpool close force local