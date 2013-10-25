############################################################################################3
cCManager()
{
    local d='/var/tmp/space-tool/pid';
    cCDispatcher()
    {
        if [ "$1" = "start" ]; then 
            startChildProcCare;
            
            return;
        fi;

        doChildCare;

        return;        
    }
    tidyPriviousChildren()
    {
        if [ ! "$1" ]; then 
            $( mkdir -p '/var/tmp/space-tool/pid' );
            recursiveExFileCB "$d" "tidyPriviousChildren";
            echo "tidying old processes in $d";     
            
            return;
        fi;
        cOK=$( checkChild "$1");

        if [ "$cOK" -eq 1 ]; then
            verbose 'tidy found need to restart children' 3;
            startChildProcCare;
            return;
        fi; 
 
        return;
    }
    startChildProcCare()
    {
        startDefault()
        {
            $( rm -R $d );
            $( mkdir -p $d );
        }
        startDefault;
        
        return;
    }
    checkChild()
        {        
            cFC=$( cat "$1/child" );
            if [ -d /proc/$cFC ]; then            
                echo 0;
            
                return;
            fi;
        
            echo 1;
   
            return;
        } 
    doChildCare()
    {
        
        if [ ! "$1" ]; then 
            recursiveExFileCB "$d" "doChildCare";
            echo "recursionstarted at $d";     
            
            return;
        fi;
        echo "level";
        cOK=0;

        cOK=$( checkChild "$1");

        if [ "$cOK" -eq 1 ]; then
            echo 'this child has a pid file but no proc folder was found';
            
            return;
        fi; 
        
        echo "child running" 3;

        return;
    }
    
    if [ ! -d $d ]; then 
        echo 'something very wrong';
        echo 'trying to restore processes';
        startActionChildren;
        doChildCare;  
     
        return;
    fi;
    #runs if called with start
    cCDispatcher $1;        
      
    return;
}
startActionChildren()
{
    doChildMessages()
    {
        if [ "$1" ]; then
            echo $$ >> /var/tmp/space-tool/pid/child;
        fi;

        return;
    }

    if [ ! "$1" ]; then 
         t=${config[jobFreq]};
         $( startActionChildren $t ) &
         
         return;
    fi;
    
    doChildMessages;

    action=true;
    while [ "$action"="true" ]; do
        sleep $1;
        st child;
    
    done;

    return; 
}
processChildMessage()
{
    
    if [ "$1" = "start" ]; then
            verbose "doing childs work from $commandPath/../actions "
            recursiveFileCB "$commandPath/../actions/*" 'processChildMessage';
            
            return 0;
    fi;
    verbose "including child job option $1" 3;
    if [ -f "$1" ]; then
        verbose "including child job $1" 3;
        . $1;

        return 0;
    fi;

    return 1;
}


startActionChildren()
{
    if [ ! "$1" ]; then 
         t=${config[jobFreq]};
         verbose "starting action children w freq $t" 3;
         $( startActionChildren $t ) &
         
         return;
    fi;
    st child $$;
    action=true;
    echo initChild >> /home/gerard/rCount;
    date  >> /home/gerard/rCount;
    while [ "$action"="true" ]; do
        sleep $1;
        echo "message home"  >> /home/gerard/rCount;
        date  >> /home/gerard/rCount;
        st child;
    
    done;

    return; 
}



