#!/bin/bash
doGeneralCheck()
{
    warnIfUserIsRoot;
    warnBuild;
    validateConfig;
}
verbose()
{
   
    local message;
    local verbosity;
    local sysVerbosity;
    
    message="$1";   
    verbosity="$2";
    sysVerbosity=$config[sysVerbosity];  
   
    #passed with one param only 

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
    if [[ "$verbosity" > "$sysVerbosity" ]]; then
       
        return;
    fi

    colorMessage "$message";

    return;
}
colorMessage()
{
    #message $1
    local nocolors=${config[nocolors]};

    if [  "$nocolors" = "1" ]; then 
        echo $1;
        
        return;
    fi
   
    echo -en '\E[37;44m'"\033[1m"$1"\n\033[0m";
    
    return
}
doColorMessage()
{
    return;
}
printConfigValidation()
{
    local message;
    local verbosity;
  
    message="$1";
    verbosity="$2";
    
    if [ $newProcess ]; then
        verbose $message $verbosity;
    fi

}

error()
{   
    echo $1;
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
echo $publicCommandsPath/$commandd; 
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



initSection()
{

    local section;
    section="$1";
    ls $projectCommandsPath/app/commands/$section;
   
}

handleSection()
{   

    local section;
    section="$1";
    local action;
    action="$2";
    helpAction="$3";
    if [ "$action"="help" ]; then
        handleSectionHelp $section $action $helpAction;
    fi
    exit;
    . $projectCommandsPath/app/commands/$section/$action;
}
handleSectionHelp()
{
    local section;
    section="$1";
    local action;
    action="$2";
    . $projectCommandsPath/app/help/$section/$action;
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

compareDirStatusRecordsEqual()
{
    path=${config[trackDir]};
    
    newCheckSum=$(  ls -lRF $path ); 
    nCS=$( echo -n "$newCheckSum" | md5sum );
   
    verbose 'old '$priCS 3;
    verbose 'nw '$nCS 3;
    if [ "$priCS" = "$nCS" ]; then
        echo workMore;
        
        return;
    fi;
    #@todo make this a feature
    priCS=$nCS;
    export priCS=$priCS    
    echo $priCS;
    actionHandlers 'save';
    return 0;
}

actionHandlers()
{
    
    for file in $projectCommandsPath/app/actions/$1/*; do 
        if [ -e "$file" ] ; then
            # Make sure it isn't an empty match.
          . "$file";
        fi
    done
}
validateConfig()
{    
    for file in $projectCommandsPath/app/config-validation/*; do 
        if [ -e "$file" ] ; then
            # Make sure it isn't an empty match.
        verbose "validator file $file" 3;
          . "$file";
        fi;
    done;
}

warnBuild()
{   
    count=0;
    mode=${config[nonStrictMode]};
    if [[ $mode && "$mode"="1" ]]; then
        
        return;
    fi;
    #count files in dangerous dir
    for file in $projectCommandsPath/app/dangerous/*; do
        if [ -e "$file" ]; then
            ((count++));
        fi;
    done;
    #Limit is one. Strict mode throws error
    if [[ "$count" > "1" ]]; then
        error 'to many files in '$projectCommandsPath'/app/dangerous';
    fi;

}
exitOnError()
{
    #error status must not be greater than 0;
    if [[ "$1">"0" ]]; then
        #message
        echo $2;
        exit;
    fi
}
#internal 
# lastCommanddIndex
# loop
# commandd

#internal functions
# commandIsQuit
# prepareBackCommandd
# intToStringCommandd
# prepareForward
# echoDirList
# 


#external
# validateConfig

launcher()
{   
    export iWant=1;
    # command History;
    cHIndex=0;
    loop=true;
    echo 'type quit to go back'
    while [ "$loop" == "true" ] 
        do
            read -p 'b-a > ' commandd
            echo 'command is '$commandd;
            
            doBack;
            
            nextStart;

            intToStringCommandd;           

            verbose 'current index '$cHIndex 3;

            prepareForward $commandd;

            prepareCommandPath;          
            
            if [ "$commandd" = "help" ]; then  
                prepareBack 1;  
                echoDirList;
          #  echo 'try something : ';
            else
                
                 . $fullCP ; 
                processHoldForSubMenu;
            fi         
            
            #by default restart app so config is refreshed.
            export cHIndex=$cHIndex;
        
        done
}
nextStart()
{
    commandIsQuit;
    unset holdForSubMenu;
    doGeneralCheck;
}
doBack()
{
    if [ "$commandd" = "back" ]; then
       verbose 'Bck Section' 3;

        prepareBackCommandd;
        prepareBack 1;                
    fi

}
# have to hold once when command is submenu
# otherwise move back to last commandd position
processHoldForSubMenu()
{
    if [ ! $holdForSubMenu ]; then 
        verbose 'holding for sub menu' 3;
        prepareBack 1;
        
        return;
    fi   
    
}
echoDirList()
{
    prepareCommandPath; 
    cd $fullCP;
    verbose 'echoing directory list '$fullCP;
    count=0;
    for file in ./*; do
        if [ -f "$file" ]; then 
        echo $file' '$count;
        ((count++));   
        fi;
    done;
    
}
prepareBack()
{
    local back="$1";
    if [[ "$back" -lt "1" ]]; then
        verbose 'back finished '$back 3; 
        return;
    fi
    verbose 'starting back '$cHIndex' '$back 3;
   
   
    if [[ "$cHIndex" -gt '-1' ]]; then
         verbose 'unset cH['$cHIndex']; '${cH[$cHIndex]} 3;
         unset cH[$cHIndex];
    fi
    
    ((back--));
    ((cHIndex--))
    prepareBack $back;
}
prepareForward()
{   
     verbose 'prepare forward index '$cHIndex 3;
    if [[ "$cHIndex" -lt "-1" ]]; then 
        verbose 'regulating $cHIndex from '$cHIndex 3;
        ((cHIndex++));
        verbose 'to '$cHIndex; 
    fi
    ((cHIndex++));
    cH[$cHIndex]=$1;
    
    verbose ${cH["$cHIndex"]} 3;
}   
fixCommandHistory()
{
    #remove one node to be replaced by new command
    prepareBack 1;
    verbose 'fixCommandHistory '"$1" 3;
    prepareForward "$1";
    prepareCommandPath;
}
commandIsQuit()
{
    if [ "$commandd" = "quit" ]; then
        unset loop;
        echo 'goodbye...'
        exit 1;
    fi
}
showCH()
{
    verbose 'commandd history' 3;
    for i in ${cH[@]}; do
    showCHCount=0;
    if [ $i ]; then 
        verbose "history $showCHCount $i" 3;
        ((showCHCount++))
    fi
    done
}
prepareCommandPath()
{
    verbose 'prepare command path last ';	
    showCH;

    fullCP="";
    for i in ${cH[@]}; do
        if [ $i ]; then 
            verbose 'building parts '$i;
            #path must start with / for concatonation
            fullCP=$fullCP/$i;
        fi
    done
    #fullCP is starting with / already
    fullCP=$commandPath$fullCP;
    verbose 'prepare command path '$fullCP;
}
prepareBackCommandd()
{
    count=${#cH[*]};
    lastIndex=$(($count -2));
    if [[ "$lastIndex" -gt "0" ]]; then 
        commandd=${cH[$lastIndex]};
    else 
        commandd=help;
    fi;
    verbose 'prepare back commandd '$commandd 3;
} 
intToStringCommandd()
{
    if [[ $commandd =~ [[:digit:]] ]]; then
        declare -a pot
        count=0;
        prepareCommandPath;
        cd $fullCP;
        for file in ./*; do
            if [ -f "$file" ]; then 
                echo $file' in loop '$count;
                pot[$count]=$file;
                ((count++));   
            fi;
    done;  
   
    commandd=${pot[$commandd]};
    verbose 'int converted too '$commandd 3;
    
    fi;
}
# set variable so sub menu command is not removed
holdForPosSubMenu()
{
    verbose 'init submenu hold' 3;
    holdForSubMenu=1;
}
initSubSection()
{
    verbose 'initSubSection '$1 3;
    fixCommandHistory $1;
    echoDirList;
    holdForPosSubMenu;
}
doAction()
{
    if [["$1"='save']]; then
        dir=$dir'save' 
        cd $dir;
        for entry in "${saveConfig[@]}";  do
           ( . $entry );
        done;
    fi
}

