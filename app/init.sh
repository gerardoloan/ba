

:()
{
    . $projectCommandsPath/functions/functions.sh;
    . $projectCommandsPath/functions/message.sh;
    . $projectCommandsPath/functions/cCManage.sh
    . $projectCommandsPath/functions/launchHelpers.sh;
    . $projectCommandsPath/functions/remote.sh;
}
: # why?

########################################################

echoInitConfig;

if [[ ! $configPath || ! -r $configPath  ]]; then
   configPath='/home/gerard/cl/space-tool/config/config.sh';
fi;
. $configPath;
commandPath=$projectCommandsPath/app/commands;
#####################################################################
childMessages;

######################################################################
# system warning
doGeneralCheck;
#####################################################
#compareDirStatusRecordsEqual
#equality=$( compareDirStatusRecordsEqual );

####################################################
processChildMessage $1;
if [ "$?" = "0" ]; then
    
    exit 0;
fi


#################################################

startForUser()
{
    cCManager start;
echo $$ >> /var/tmp/space-tool/pid/child;
cCManager; 

okFin=1;
while [[  "$okFin" -gt "0" ]]; do

   declare -a cH;
   ( launcher );

   okFin="$?";
   
   verbose 'done is '$okFin 3;

done;
}
startForUser;
