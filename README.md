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

### Notes on workflow
* Put all the tracked videos you want to use into a folder that also contains the ann and mat files for each expt.  There should be a unique experiment ID for each movie as the first 4 characters of each movie file.  (If not, you will
need to modify the code.)
* When you have a list of all the videos you want to use, set up makeConfigFile to generate that list and write a file 
containing it.  
* Run PrepCtrax4JAABA after making the config file. 
* Still need to populate the Perframe folders for each expt.  To do this, run StartJAABA and select Training Mode and any project (.jab) that you are using.  Select "Change Experiment List" or just add a list of experiments when prompted.Make a text list containing all the experiment folders you want to add, and then select that as the text file from which to add experiments (should be the full path to each experiment, one experiment per line, no other text).
Add these experiments to the experiments list using "Add list".  When it asks to generate missing files, accept.  When it asks to regenerate existing files, say Leave Alone (haven't looked into whether it causes problems for my dataset to rengerate existing -- may override my specified arena params). The sofware will then generate the missing files for each exp.  This may take a few min.  Click done when finished.  You may then quit JAABA and discard unsaved changes.  
* Now you can run JAABAPlot. Before or after starting JAABAPlot, you need to prepare a file to add a batch of experiments.  This new text file takes the same basic form as the experiment list text file above, except that a group and a color must be added to the end of each line.  For example, the first line might be: 
/Volumes/KATIELAB1/Behavior_Videos_JAABA/Rest of Old Behavior Videos/2706/2706_land,control,FF0000
Once you have made this new text file for plotting, you can go into the top Experiments panel of JAABAPlot, and select Batch on the right.  You will then be able to select the text file, and JAABAPlot should load the appropriate experiments as specified in the file. Select the group you would like (specified in the batch file you just loaded - note that your file may add experiments to more than one group).  Add the classifiers you want in the next panel.  Click Check to see if you need to run the classifier on any files that may not yet have been scored for that classifier.
If needed, click Classify.  
* That's it.  Now just choose what you want to plot!  Note: You can also export scores as a .csv file. 

### Questions?  Comments?
I welcome questions or feedback.  Please feel free to contact me about this repo.    
