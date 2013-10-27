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


# external
# validateConfig



################################################################################3


launcher()
{   
    # command History;
    cHIndex=0;
    loop=true;
    echo 'type quit to go back'
    while [ "$loop"=true ] 
        do
            verbose "dropping into while loop $loop" 3;
            goActionChildren "5" &
           
            read -p 'space tool > ' commandd num
            echo 'command is '$commandd;
            if [ "$commandd" ]; then
                
                verbose 'makeSecure' 3;

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
            . $fullCP; 
            
            return;
        fi;
        if [ -f $fullCP.sh ]; then
            verbose 'safely dispatched file(.sh) in a restricted action' 3;
            . $fullCP.sh; 
            
            return;
        fi;
        verbose 'default action seemed not to be a valid file and was not dispatched' 3;

        return;
    }
    launchDefault()
    {   
        verbose "nobodies got it. $1. launching default $fullCP" 3;
        
        restrictedDefaultAction;
        
        processHoldForSubMenu;
 
        verbose 'hope someone claimed it '$1 3;

        return;
    }
    verbose 'seems you cant call claimItAndDoIt from here Success. commandd will not be found' 4;
    verbose 'yet the first line the first declared claimItAndDoIt will execute' 5;
    
    h=0;
    
    launchHelpers; 
    
    verbose "helpers returned $h";
    if [ ! "$h" -gt 0 ]; then
        launchDefault $h; 
    fi; 

    return;           
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
    verbose 'what happens if you dont ((cHIndex--)) || in ((back--))' 4;
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
    done;
   
    return;
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

    return;
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

    return;
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
    verbose 'i seem to be able to call an function thats declared inside another object here' 4;
    verbose 'if you notice the function has already been declared' 4;
    echoDirList;
    holdForPosSubMenu;
}

####################################################################################
