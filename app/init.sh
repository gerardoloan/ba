
. $projectCommandsPath/functions/functions.sh;
. $projectCommandsPath/functions/remote.sh

########################################################

echoInitConfig;
if [[ ! $configPath || ! -r $configPath  ]]; then
   configPath='/home/gerard/cl/project-commands/config/config.sh';
fi;
. $configPath;


######################################################################
# system warning
doGeneralCheck;
#####################################################
#compareDirStatusRecordsEqual
#equality=$( compareDirStatusRecordsEqual );

#################################################

commandPath=$projectCommandsPath/app/commands;


okFin=1;
while [[  "$okFin" -gt "0" ]]; do
  
   declare -a cH;
  ( launcher );

   okFin="$?";
   verbose 'test is '$test;
   verbose 'done is '$okFin 3;

done;


