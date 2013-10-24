
compareDirStatusRecordsEqual()
{
    path=${config[trackDir]};
    
    
    nCS=$( ls -lRF | md5sum );
   
    verbose 'old '$priCS 3;
    verbose 'nw '$nCS 3;
    if [ "$priCS" = "$nCS" ]; then
        verbose 'workMore' 1;
        
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

