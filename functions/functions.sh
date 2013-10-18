#!/bin/bash

verbose()
{

    local message;
    local verbosity;
    local sysVerbosity;
    message="$1";
    verbosity="$2";
    sysVerbosity="$3";
  
    if [  $verbosity ]; then
       echo $message;
      
       return;
    fi
    
    if [[ "$verbosity" < "$sysVerbosity" ]]; then
        echo $message;
        
        return;
    fi

   if [[ "$verbosity" == "$sysVerbosity" ]]; then
        echo $message;
        
        return;
    fi  
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
    read -p 'sql || xml - 1 | 2 : ' changeFromSql

    if [ "$changeFromSql" = "2" ]; then

        format="xml";
    fi
}