# kbs-jaaba-extras
Tools that interface with or make use of the JAABA package from HHMI Janelia Farms. 

## General Notes
These are tools that I wrote as useful add-ons to JAABA, in order to improve my workflow when importing experiments 
from Ctrax to JAABA, and when processing batches of videos in JAABA.  

### Preparing the environment for use with JAABA
I found that taking a few measures to clean up and prepare my MATLAB workspace before running JAABA greatly 
reduced the likelihood of errors.  The most important things I found are: 

1. Helps to clear all variables and close all open figures before starting. 
2. Crucial that not only the JAABA-master folder and its contents be on the MATLAB search path, but also 
   any folders containing data or configuration/list files that you wish to use should also be on the path. 
3. If in a new folder containing experiments, may want to generate JAABA-friendly experiment folders for each of the 
   new experiments before starting to prepare the data for JAABA.  In that case, automate adding those new folders to the path.  

All of the above are accomplished by MyJAABAPrep.m

### Making a configuration file to prepare a batch of Ctrax experiments for JAABA. 
Out of the box, JAABA does not offer a way to batch-process experiments to prepare them for JAABA (a GUI for preparing tracked experiments individually is provided in JAABA).  Taking inspiration from a discussion on the JAABA Google Group's forum, I wrote a solution to take a batch of Ctrax data, pre-process it, and then convert each Ctrax-processed experiment to a JAABA-compatible experiment by calling the JAABA function 'ConvertCtrax2JAABA'.  

The code I wrote allows the user to first generate an experiment list and set certain parameters using makeConfigFile.m
The user can then run PrepCtrax4JAABA.m to convert all of the experiments in the list.  

### Questions?  Comments?
I welcome questions or feedback.  Please feel free to contact me about this repo.    
