%% PrepCtrax4JAABA.m 
% Written by Katie Shakman on 4/21/2015
% Programmatically call ConvertCtrax2JAABA for list of files that are 
% each in their own experiment directory (containing video, trx, ann). 
% Inspired by code from Kristin Branson and Kushak K at:
% https://groups.google.com/forum/#!topic/jaaba/Ik9O9R6UD30

% Prepare the workspace and path:
% clean up windows and variables. 
clear all; close all; 

% add JAABA package, and data directory, to MATLAB path.  
addpath(genpath(...
    '/Users/katherineshakman/Documents/MATLAB/JAABA-master'))
addpath(genpath('/Volumes/KATIELAB1/Behavior_Videos_JAABA'))
addpath('/Volumes')

% specify preparation configuration file: 
prepConfigFile = 'configFile.mat'; 
% load the configuration file:
load(prepConfigFile);

for exptIdx = 1:length(expt)
    % get name of experiment, name and make experiment directory
    newExpName = expt{exptIdx}; % value loaded from cell array in prepConfigFile
    newDirName = strcat(newExptDir{exptIdx},'/'); % value loaded and suffix added
    success = mkdir(newDirName);
    % let user know whether directory is ready for use.
    if success
        formatSpec = 'Directory %s is ready. \n';
        fprintf(formatSpec,newDirName)
    else
        error('Could not make directory %s.', newDirName);
    end
    
    % get the experiment files to pass to converter: 
    cd(newExptDir{exptIdx});
    mov_list = dir('*.sbfmf'); 
    moviefile = mov_list(1).name; 
    clear('mov_list'); 
    trx_list = dir('*.mat'); 
    trxfile = trx_list(1).name; 
    clear('trx_list');
    ann_list = dir('*.ann'); 
    annfile = ann_list(1).name; 
    clear('ann_list'); 
    
    % make landing directory: 
    landDir = strcat(newDirName,expt{exptIdx},'_land'); 
    mkdir(landDir);
    
    % set additional parameters (eventually move to config file): 
    load(trxfile); 
    frameInt = [trx.firstframe, trx.endframe];
    
    % Note: using K Shakman and D Hattori defaults for arenacenterx,
    % arenacentery, arenaradius, and fps.  Need to specify our value
    % for pxpermm (1.9?).
    
    % changed movie.ufmf to movie.sbfmf
    % test version of call to Converter (works as of 4/21/2015 7pm): 
    [success,msg] = ...
        ConvertCtrax2JAABA('inmoviefile',moviefile,'intrxfile',trxfile,'annfile',annfile,...
        'expdir',landDir,'moviefilestr','movie.sbfmf','trxfilestr','trx.mat',...
        'perframedirstr','perframe',...
        'arenatype','None','arenacenterx',0,'arenacentery',0,...
        'arenaradius',10,'arenawidth',10,'arenaheight',10,'roi2',[],...
        'pxpermm',19,'fps',20,...
        'overridefps',true,'overridearena',true,...
        'dosoftlink',false,...
        'fliplr',false,...
        'flipud',false,...
        'dotransposeimage',false,...
        'inperframedir','',...
        'frameinterval',frameInt);
   
    % Report when finished with an expt conversion, and give expt name. 
        formatSpec = 'Process or conversion completed for experiment %s. \n';
        fprintf(formatSpec, expt{exptIdx})
end
