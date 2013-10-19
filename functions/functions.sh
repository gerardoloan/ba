#!/bin/bash

verbose()
{
   
    local message;
    local verbosity;
    local sysVerbosity;
    
    message="$1";   
    verbosity="$2";
    sysVerbosity=$config[sysVerbosity];  
  
    #passed with one param only echo
    if [  "$verbosity" = "" ]; then 
        echo $message;
        
        return;
    fi
    #base system verbosity level
    if [  "$verbosity" = 1 ]; then
       colorMessage "$message";
       
       return;
    fi
    #message has +int verbosity not 1 
    #is less than system return null
    if [[ "$verbosity" < "$sysVerbosity" ]]; then
       
        return;
    fi

    colorMessage $message;

    return;
}
colorMessage()
{

    local message;
    message="$1";
    local r=${config[nocolors]};

    if [  "$r" = "1" ]; then 
        echo $message;
        
        return;
    fi
   
    echo -en '\E[37;44m'"\033[1m"$message"\n\033[0m";
    
    return
}
printConfigValidation()
{
    local message;
    local verbosity;
    local sysVerbosity;
    message="$1";
    verbosity="$2";
    sysVerbosity="$3";

    if [ $newProcess ]; then
        verbose $message $verbosity $sysVerbosity;
    fi

}

error()
{
    local message;
    message="$1"
    echo $message;
    exit;
}
public()
{
    local projectCommandsPath;
    projectCommandsPath="$1";
    
    local  commandd;
    commandd="$2";

    matched=0;
    protected $projectCommandsPath $commandd
    if [ "$commandd" == "quit" ]; then
              exit;
    fi
    publicCommandsPath=$projectCommandsPath/app/commands;

    . $publicCommandsPath/$commandd;

}
protected()
{
    local projectCommandsPath;
    projectCommandsPath="$1";
    
    local  commandd;
    commandd="$2";
    
    matched=0;
    case "$command" in
        "ba") echo 'in protected()'; exit
    esac
}
echoInitConfig()
{
    printConfigValidation 'valiadating config ...'1 $verbosity;

    printConfigValidation 'this process warns and only sometimes exits :) ';
    printConfigValidation 'read the output...';
}
configValidation()
{
    local projectCommandsPath;
    projectCommandsPath="$1";
    config="$2";

    for file in $projectCommandsPath/config-validation/* ; do # Use ./* ... NEVER bare *
        if [ -e "$file" ] ; then  # Check whether file exists.
            
             . $file;
        fi
        
        if [ $errorMessage ] ; then  # Check whether error exists.
             
            error $errorMessage;
        fi
        
    done

}
unsetConfig()
{
echo config;
    unset config;
    
}
showConfig()
{
 return;
}

initSection()
{

    local section;
    section="$1";
    ls $projectCommandsPath/app/commands/$section;
   ## for file in $projectCommandsPath/app/commands/$section/* ; do # Use ./* ... NEVER bare *
   ##     if [ -e "$file" ] ; then  # Check whether file exists.
            
   ##          echo $file;
   ##     fi
        
   ## done
}
handleSection()
{
    
    local section;
    section="$1";
    local action;
    action="$2";
    . $projectCommandsPath/app/commands/$section/$action;
}
changeDbBackupFormat()
{

    format="sql";
    read -p 'sql || xml - 1 | 2 : ' changeFromSql;

    if [ "$changeFromSql" = "2" ]; then

        format="xml";
    fi
}
warnIfUserIsRoot()
{
    if [ "$USER" = "root" ]; then 
         warn 'seems you are ROOT';
    
         read -p 'EXIT 0 : 1 > ' bailOut;
         if [ "$bailOut" = "1" ]; then 
              warn 'exiting ...';
              exit;
         fi
    fi
}
warn()
{
    local message;
    message="$1";
    verbose $message 1;
}
createDirStatusRecord()
{
    cd ${config[trackDir]};
    mv .dirstatusrecord.txt .olddirstatusrecord.txt;
    ls -lRF >> .dirstatusrecord.txt;
}
compareDirStatusRecordsEqual()
{
    prepareDirectory;
    oldCheckSum=$( cksum .olddirstatusrecord.txt );
    newCheckSum=$( cksum .dirstatusrecord.txt );
    
    if [ "$oldCheckSum"="$newCheckSum" ]; then
        
        return 1;
    fi;

    return 0;
}
prepareDirectory()
{
    touch .olddirstatusrecord.txt;
    touch .dirstatusrecord.txt;
}