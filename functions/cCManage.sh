############################################################################################
actionChildrenCB()
{    
    # $1 timeout
    # $2 dir
    while [ "$action"="true" ]; do
        sleep $1; 
       
        st child  &
                
    done;
}
cCManager()
{    
    startActionChildren()
    {      
        t=${config[jobFreq]};
        verbose "starting action children w freq $t" 3;
        
        r=$( actionChildrenCB $t $d );
         
        return;
    }
    local d='/var/tmp/space-tool';
    cCDispatcher()
    {
        if [ "$1" = "start" ]; then
            verbose "dispatching $1 : startChildProcCare" 3;
            startChildProcCare;
            verbose "start action children" 3;
            startActionChildren;
            sleep 1;
        fi;
        verbose "dispatching $1 : doChildCare " 3;
        doChildCare;

        return;        
    }
   
    startChildProcCare()
    {   
        doNerd()
        {
            if [ ! "$1" ]; then 
                recursiveExFileCB "$d" "doNerd";
                echo "recursionstarted at $d";     
            
                return;
            fi;
            echo "level";
            cOK=0;

            cOK=$( getChildId "$1");

            if [[ "$cOK" =~ [[:digit:]] ]]; then
                cFC=$( cat "$1/child" );
                echo 'shiva old child' 3;
                kill $cFC;
               
                return;
            fi;       
            
            
            return;
        }
        startDefault()
        {
            $( rm -R $d );
            $( mkdir -p $d );
            verbose "made child pid dir $d" 3;
        }
        doNerd;
        startDefault;
        
        return;
    }
    getChildId()
    {
        cat "$1/child";
    }
    checkChild()
    {        
        cFC=$( getChildId $1 );
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
    
    #runs if called with start
    verbose "cc dispatching $1" 3;
    cCDispatcher $1;        
      
    return;
}

processChildMessage()
{ 
    if [ "$1" = "start" ]; then
        
        verbose "doing childs work from $commandPath/../actions "
        
        
       exit 0;
    fi;
    verbose "including child job option $1" 3;
    if [ -f "$1" ]; then
        verbose "including child job $1" 3;
        . $1;

        exit 0;
    fi;

    exit 1;
}
