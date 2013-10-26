

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
#childMessages;

######################################################################
# system warning
doGeneralCheck;
#####################################################
#compareDirStatusRecordsEqual
#equality=$( compareDirStatusRecordsEqual );

####################################################

if [ "$1" = "start" ]; then
    
    processChildMessage;
    verbose "just childish stuff" 3;
    exit 1;
fi;

#################################################

startForUser()
{
# $1 timeout
    # $2 dir
actionChildrenCB "10" "$projectCommandsPath" &

okFin=1;
while [[  "$okFin" -gt "0" ]]; do

   declare -a cH;
   ( launcher );

   okFin="$?";
   
   verbose 'done is '$okFin 3;

done;
}
startForUser;
