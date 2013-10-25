startActionChildren()
{
    if [ ! "$1" ]; then 
         t=${config[jobFreq]};
         $( $startActionChildren $t ) &;
         
         return;
    fi;
    st child $$;
    action=true;
    while [ "$action"="true" ]; do
        sleep $1;
        st child;
    
    done;

    return; 
}
processChildMessage()
{
    doChildActions()
    {
        if [ ! "$1" ]; then
            recursiveExFileCB "$commandPath/../actions" 'doChildWork';

            return
        fi; 
    
        . $1;

        return;
    }
    doChildMessages()
    {
        if [ "$1" ]; then
            echo $$ >> /var/tmp/space-tool/pid/child;
        fi;
    }
    if [ "$1" ]; then
         doChildMessages "$1";
      
         return;
    fi;

    doChildActions;
}


startActionChildren()
{
    if [ ! "$1" ]; then 
         t=${config[jobFreq]};
         $( $startActionChildren $t ) &;
         
         return;
    fi;
    st child $$;
    action=true;
    while [ "$action"="true" ]; do
        sleep $1;
        st child;
    
    done;

    return; 
}
processChildMessage()
{
    doChildActions()
    {
        if [ ! "$1" ]; then
            recursiveExFileCB "$commandPath/../actions" 'doChildWork';

            return
        fi; 
    
        . $1;

        return;
    }
    doChildMessages()
    {
        if [ "$1" ]; then
            echo $$ >> /var/tmp/space-tool/pid/child;
        fi;
    }
    if [ "$1" ]; then
         doChildMessages "$1";
      
         return;
    fi;

    doChildActions;
}

recursiveExFileCB()
{
    for file in $( find  $1 -executable ); do
        $2 $file;
    done;

}

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

#######################################################################

startActionChildren()
{
    if [ ! "$1" ]; then 
         t=${config[jobFreq]};
         $( $startActionChildren $t ) &;
         
         return;
    fi;
    st child $$;
    action=true;
    while [ "$action"="true" ]; do
        sleep $1;
        st child;
    
    done;

    return; 
}
processChildMessage()
{
    doChildActions()
    {
        if [ ! "$1" ]; then
            recursiveExFileCB "$commandPath/../actions" 'doChildWork';

            return
        fi; 
    
        . $1;

        return;
    }
    doChildMessages()
    {
        if [ "$1" ]; then
            echo $$ >> /var/tmp/space-tool/pid/child;
        fi;
    }
    if [ "$1" ]; then
         doChildMessages "$1";
      
         return;
    fi;

    doChildActions;
}


