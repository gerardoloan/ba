############################################################################################
actionChildrenCB()
{    
    # $1 timeout
    while [ 1 ]; do
        sleep $1;
        ( processChildMessage );            
    done;

    return;
}

goActionChildren()
{
    c=${config[c]};
    if [  $c ]; then
        verbose "running children" 1;
        actionChildrenCB $1; 

        return;
    fi;

    verbose "not running children" 1;

    return;
}

processChildMessage()
{ 
    doActionRest()
    {
        if [[ "${config[actionRest]}" =~ [[:digit:]] ]]; then
            verbose "resting for ${config[actionRest]}" 1;
            sleep ${config[actionRest]};
 
            return;
        fi;

        return;
    }
    start()
    {
        if [ ! $1 ]; then        
            verbose "doing childs work from $commandPath/../actions" 4;
            recursiveFileCB "$commandPath/../actions" "processChildMessage";
        
            return 0;
        fi;
    }

    verbose "including child job option $1" 3;
    if [ -f "$1" ]; then
        verbose "including child job $1" 3;        
        
        doActionRest;
        
        ( . $1 );
        
        return 0;
    fi;

    return 1;
}
