

. $projectCommandsPath/functions/functions.sh
equality=$(compareDirStatusRecordsEqual);
echo $equality;
#exit
########################################################33

. /usr/bin/project-commands/config/config.sh

######################################################################

warnIfUserIsRoot;

#####################################################

#. /usr/share/nano/sh.nanorc

#verbose 'test';

########################
echoInitConfig;

#################################################

 . /usr/bin/project-commands/config-validation/db.sh;
 . /usr/bin/project-commands/config-validation/apigen-dir.sh;
 . /usr/bin/project-commands/config-validation/git-dir.sh;
 . /usr/bin/project-commands/config-validation/quick-report-file.sh;
 . /usr/bin/project-commands/config-validation/quick-view-dir.sh;
 . /usr/bin/project-commands/config-validation/test-dir.sh;

 
# 
####configValidation $projectCommandsPath $config;
#############################

#. $projectCommandsPath/app/create-variables.sh
. $projectCommandsPath/aliases
addAliases  $projectCommandsPath;
cd $projectCommandsPath/app/commands;


echo;
read -p 'b-a > ' commandd

if [ "$commandd" = "help" ]; then
    
    ls -f ./*
    echo 'try something : ';
else
    public $projectCommandsPath $commandd; 
fi
ba;

loop=true;
echo 'type quit to go back'
while [ "$loop" == "true" ] 
    do
        read -p 'b-a > ' commandd
        
        if [ "$commandd" = "quit" ]; then
              unset loop;
              echo 'goodbye...'
              exit;
        fi
        
        if [ "$commandd" = "help" ]; then
            ls -f ./*
            echo 'try something : ';
        else
           public $projectCommandsPath $commandd; 
        fi
        #by default restart app so config is refreshed.
       
        unset loop;
         
         #but could be configurable
         #@todo define config path for this
        
        if[ "$holdBa" ]; then
            loop=true;
        fi   
    done
ba;