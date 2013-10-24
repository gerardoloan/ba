#!/bin/bash

# space tool - for astronots,
# children and philosophers

isGitDir()
{
    if [ ! -d "$1" ]; then
        echo 1;
    fi;
    cd $1;
    stat=$(git status);
    if [[ "$?">"0" ]]; then
        echo 1;
    fi
}
changeDbBackupFormat()
{

    format="sql";
    read -p 'sql || xml - 1 || 2 : ' changeFromSql;

    if [ "$changeFromSql" = "2" ]; then
        format="xml";
    fi
}

doGeneralCheck()
{
    doWelcome;
    warnBuild;
    validateConfig;
}

verbose()
{   
    local m;
    local verbosity;
    local sysVerbosity;
    
    m="$1";   
    v="$2";
    sV=${config[sysVerbosity]};  
       
    if [[ ! "$v"  =~ [[:digit:]] ]]; then
        #colorMessage 'easy digit mathcing here ' 6; 
        echo $m;
        
        return;
    fi

    if [[ ! "$sV"  =~ [[:digit:]] ]]; then
        #colorMessage 'cant let a none digit fall through here' 6; 
        sV=1;
    fi
    
    #base system verbosity level
    if [ "$v" = 1 ]; then
       colorMessage "$m";
       
       return;
    fi

    #message has +int verbosity not 1 
    #is less than system return null
    if [ "$v" -gt "$sV" ]; then
        #colorMessage 'only one bracket here if [ "$v" -gt "$sV" ] ?';
        
        return;
    fi

    colorMessage "$m" $v;

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
depError()
{
    echo "dependency error in $2 package";
    error "$1";
}

echoInitConfig()
{
    verbose 'valiadating config ...' 3;

    verbose 'this process warns and only sometimes exits :) ' 3;
    verbose 'read the output...' 3;
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

doWelcome()
{   
    welcome()
    {
        verbose 'welcome '$1 1;
    }
    warn()
    {
        if [ "$1" = "root" ]; then 
            verbose 'seems you are ROOT' 1;
    
            read -p 'EXIT 0 : 1 > ' bailOut;
            if [ "$bailOut" = "1" ]; then 
                verbose 'exiting ...';
                exit;
            fi
        fi
    }

    local user=$(whoami);
    
    welcome "$user";
    warn "$user";
}

warn()
{
    echo "$1" 1;
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
##############################################
# start the tasks

#startBGProc()
#{
#    sTO=${config[saveTimeOut]};
 #   while true do
 #       sleep $sTO;
   #    compareDirStatusRecordsEqual;
  # done
#}
checkProcesses()
{
    return;
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
    while [ "$loop"=true ] 
        do
            verbose "dropping into while loop $loop" 3;
            #echo 'explore and care';
            read -p 'space tool > ' commandd num
            echo 'command is '$commandd;
            if [ "$commandd" ]; then
                
                verbose 'makeSecure' 3;
                
                makeSecure; 

                verbose 'needless func prepareCommandVars' 4;
               
                doBack;           

                nextStart;

                intToStringCommandd;           

                verbose 'current index '$cHIndex 3;
                verbose "prepareForward $commandd";

                prepareForward $commandd;

                prepareCommandPath;                   

                launchAction;                     
            fi;
            #by default restart app so config is refreshed.
            export cHIndex=$cHIndex;
            verbose "falling out of while $loop" 3
        done
}

launchAction()
{
    restrictedDefaultAction()
    {
        if [ -f $fullCP ]; then
            verbose 'safely dispatched file in a restricted action' 3;
            . $fullCP ; 
            return;
        fi;
        verbose 'default action seemed not to be a valid file and was not dispatched' 3;
    }
    launchDefault()
    {   
        verbose "nobodies got it. $1. launching default $fullCP" 3;
        
        restrictedDefaultAction;
        
        processHoldForSubMenu;
 
        verbose 'hope someone claimed it '$1 3;
    }
    verbose 'seems you cant call claimItAndDoIt from here Success. commandd will not be found' 6;
    verbose 'yet the first line the first declared claimItAndDoIt will execute' 5;
    
    h=0;
    
    launchHelpers; 
    
    verbose "helpers returned $h";
    if [ ! "$h" -gt 0 ]; then
        launchDefault $h; 
    fi;            
}
launchHelpers()
{
    launchHelp()
    {
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
        claimItAndDoIt()
        {
            if [ "$commandd" = "help" ]; then  
               prepareBack 1;  
               echoDirList;
               verbose "help claimed $commandd" 3;  
               claimed=1;
            fi; 
            if [ "$commandd" = "h" ]; then  
                prepareBack 1;  
                echoDirList;
                verbose "h claimed $commandd" 3;
                claimed=1;
            fi; 
        }
        claimItAndDoIt;		
                     
    }
    launchMan()
    {
        actionMan()
        {            
            switchFullPath()
            {   
                
                buildYourCommandd()
                {                
                    commandd=$num;
                
                    verbose "inserting $commandd" 3;
                
                    intToStringCommandd;
                
                    verbose "prepareForward $commandd" 3;
                
                    prepareForward $commandd;
                
                    p="$commandPath/../man";

                    verbose "prepare command path with $p" 3;
                
                    prepareCommandPath "$p";

                    aMC=$fullCP.txt
                
                    verbose "action man command $aMC" 3;
                
                    prepareBack 1;  
                } 
                           
                buildYourCommandd;                            
            }
            switchFullPath;
            if [ -f "$aMC" ]; then
                echo "the cat is helping you some info from $aMC" 3; 
                cat $aMC;  
                
                return;
            fi; 
            
            verbose 'sorry havent got help, dig into the manual then write it please' 1; 
            verbose 'put the file in app/man/<same dir structure as commands>.txt'            
        }
        claimItAndDoIt()
        {
            if [[ ! "$num" &&  "$commandd" = "man" || "$commandd" = "m" ]]; then  
                prepareBack 1;
                verbose 'you need to enter the number of the service you want' 1;
                return;                
            fi;
            if [ "$commandd" = "man" ]; then
                verbose 'use = for strings' 6;  
                prepareBack 1;  
                actionMan;
                verbose 'man claimed and done it' 3;
                claimed=1;
            fi; 
            if [ "$commandd" = "m" ]; then  
                prepareBack 1;
                actionMan;
                verbose 'm claimed and done it' 3;
                claimed=1;
            fi;   
        }
        claimItAndDoIt;    
    }
    claimed=0;
    
    launchHelp;
    launchMan;
    h=$claimed;
    verbose "returning int from launch helpers $h" 3;
}



nextStart()
{
    commandIsQuit;
    unset holdForSubMenu;
    doGeneralCheck;
}
doBack()
{
    local cIsBack=0;
    if [ "$commandd" = "back" ]; then
        verbose '[$commandd" = "back]' 3;        
        cIsBack=1;              
    fi
    if [ "$commandd" = "b" ]; then
        verbose '[$commandd" = "b]' 3;
        cIsBack=1;             
    fi
    if [ "$cIsBack" -eq 1 ]; then
        verbose '[$commandd" = "b]' 3;
        cIsBack=1;
        prepareBackCommandd;
        prepareBack 2;               
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
    verbose 'what happens if you dont ((cHIndex--)) || in ((back--))' 6;
    prepareBack $back;
}
prepareForward()
{   
    verbose 'prepare forward index '$cHIndex 3;
    if [[ "$cHIndex" -lt "-1" ]]; then 
        verbose 'regulating $cHIndex from '$cHIndex 3;
        cHIndex=0;
        verbose "to $cHIndex"; 
    fi
    ((cHIndex++));
    #command history
    cH[$cHIndex]=$1;
    
    verbose 'new forward position '${cH["$cHIndex"]} 3;
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
    checkCommandIsQuit;
    if [[ "$q" = "1" ]]; then
    verbose 'outta here '$q 3;
        unset loop;
        echo 'goodbye...'
        exit 1;
    fi;
}
checkCommandIsQuit()
{
    q=0;
    if [ "$commandd" = "quit" ]; then
    verbose 'quit claimed' 3;
        q=1;
    fi
    if [ "$commandd" = "q" ]; then
    verbose 'q claimed' 3;
        q=1;
    fi
    return $q;
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
    verbose "normal commandPath is $commandPath" 3;
    verbose "replacement start path is $1" 3;
    verbose 'prepare command path last ' 3;
    setUseCommandPath()
    {    
        if [ "$1" ]; then
            echo $1;
            return;
        fi;
        echo $commandPath;
    }	
    showCH;
    startPath=$(setUseCommandPath "$1");
    fullCP="";
    for i in ${cH[@]}; do
        if [ $i ]; then 
            verbose 'building parts '$i 3;
            #path must start with / for concatonation
            fullCP=$fullCP/$i;
        fi
    done
    #fullCP is starting with / already
    fullCP=$startPath$fullCP;
    verbose 'prepared command path '$fullCP 3;
}


prepareBackCommandd()
{
    regulateBackCommand()
    {
        if [ "$1" -gt "0" ]; then         
            commandd=${cH[$1]};
            verbose "back has shifted command to $commandd" 3; 
            return
        fi;
        commandd=help; 
        verbose "back has regulated command  to $commandd" 3; 
    }
    count=${#cH[*]};
    lastIndex=$(($count -1));
    regulateBackCommand "$lastIndex";
} 

intToStringCommandd()
{
    if [[ $commandd =~ [[:digit:]] ]]; then
        declare -a pot
        count=0;
        prepareCommandPath;
        cd $fullCP;
        verbose 'int to string starting loop' 3;
        for file in ./*; do
            if [ -f "$file" ]; then 
                echo "$file in loop $count" 3;
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
    verbose 'i seem to be able to call an function thats declared inside another object here' 6;
    verbose 'if you notice the function has already been declared' 6;
    echoDirList;
    holdForPosSubMenu;
}
doAction()
{
    if [[ "$1"='save' ]]; then
        dir=$dir'save' 
        cd $dir;
        for entry in "${saveConfig[@]}";  do
            . $entry ;
        done;
    fi
}
makeSecure()
{
    makeSecretFile()
    {
        echo ${config[@]} >>  ${config[secretBackUp]};
        verbose 'why is it secret' 4;        
    }
    makeSecretFile;
    doOpenSecret()
    {
        doSecret()
        {
            tar czvf - "$1" |
            openssl des3 -salt -out "$2" -pass pass:"$3";
        }
        mvSecret()
        {
            cd "$1";
            git add .;
            git push secret;
        }
        g=${config[openSecret]}
        l=${config[openSecretLocation]};
        p=${config[openSecretPswd]};
        o=${config[openSecret]}
        r=${config[openSecretRemote]};

        isG=$( isDirGit $g );

        if [[ "$l" && "$o" && "$p" && ! "$isG" = "1" ]]; then
            verbose 'moving secrets to [[ "$l" && "$o" && "$p" ]]' 3; 
            doSecret "$l" "$o" "$p";
            mvSecret "$g";
            return;
        fi;
        
        verbose 'to open for secrets' 6;
    }
}


