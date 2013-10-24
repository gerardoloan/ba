
. $projectCommandsPath/functions/functions.sh;


########################################################

echoInitConfig;
configPath='/home/gerard/cl/project-commands/config/config.sh';
. $configPath;


#############################



######################################################################
# system warning
warnIfUserIsRoot;
warnBuild;
validateConfig;
#####################################################
#compareDirStatusRecordsEqual
#equality=$( compareDirStatusRecordsEqual );

###
########################


#################################################

commandPath=$projectCommandsPath/app/commands;

. $projectCommandsPath/aliases;
okFin=1;
while [[  "$okFin" -gt "0" ]]; do
  iWant=0; 
   declare -a cH;
   (launcher);

   okFin="$?";
   verbose 'i want'$iWant;
   verbose 'done is '$okFin 3;

done;


