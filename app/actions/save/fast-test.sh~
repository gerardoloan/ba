sf=${config[saveFreq]};

 . $commandPath/testsuite/fast-test
echo test >> /home/gerard/rCount;
date  >> /home/gerard/rCount;
p='/home/gerard/exp';
compareDirStatusRecordsEqual()
{
    doComparison()
    {
        if [ "$priCS" = "$nCS" ]; then
            verbose 'workMore' 1;
        
            return 0;
        fi;
    }
    #p=${config[trackDir]};
    cd $p;
    verbose "starting comparison of $p":
    doComparison;

    nCS=$( ls -lRF | md5sum );
    
    verbose "old $priCS" 3;
    verbose "nw $nCS" 3;
    
    #@todo make this a feature
    priCS=$nCS;
    export priCS=$priCS    
    
    actionHandlers 'save';
    
    return 0;
}

verbose()
{
    return; #echo $1;
}

actionHandlers()
{
    return; #echo "action handler save $1";
}


    compareDirStatusRecordsEqual;
   
 
